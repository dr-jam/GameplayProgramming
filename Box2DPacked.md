# Box2D-Packed: 2D physics for Unity-style projects

*Optional material, added in this fork. It is not part of the course requirements. Read [From Unity C# to C](CSharpSubset.md) first.*

## Unity's 2D physics is Box2D

When you add a `Rigidbody2D` and a `BoxCollider2D` in Unity, the physics that moves them is Box2D. Unity's manual says its built-in 2D physics uses an integration of the Box2D engine ([Physics integrations in Unity](https://docs.unity3d.com/Manual/physics-integrations.html)); its 3D physics uses NVIDIA PhysX. Box2D is an open-source engine by Erin Catto, and it is used by many other 2D games and engines.

[Box2D-Packed](https://github.com/crustos/box2d) is a fork of Box2D v3. It keeps Box2D's solver and adds two things:

- **Smaller, cache-friendly data.** Handles are 4 bytes instead of 8, and the records the engine reads every step are laid out so that the fields read together sit in the same cache line.
- **Game code compiled into the engine.** A build tool can put your game's collision logic inside the physics engine's own loop, where the data it needs is already in the CPU cache. See [`INTRUSIVENGINE.md`](https://github.com/crustos/box2d/blob/main/INTRUSIVENGINE.md).

When you pack a Unity-style project with crust's `unity_pack`, Box2D-Packed is its 2D physics engine. Your scripts and scenes stay the same: the `Rigidbody2D`, collider, and `OnCollisionEnter2D` you use in Unity are what `unity_pack` reads.

## How your Unity physics maps

| In Unity | In the packed program |
|---|---|
| `Rigidbody2D`, Dynamic / Kinematic / Static | A Box2D dynamic / kinematic / static body |
| `Rigidbody2D.mass` | The body's mass |
| `BoxCollider2D`, `CircleCollider2D`, with offset | A Box2D box or circle shape |
| A collider without a `Rigidbody2D` | A static body |
| `isTrigger` | A Box2D sensor |
| `PhysicsMaterial2D` friction, bounciness, combine modes | Mixed with Unity's rules: Average, Multiply, Minimum, Maximum |
| `rb.velocity` / `rb.linearVelocity`, `transform.position`, `gravityScale`, `linearDamping`, `Physics2D.gravity` | Read and written each fixed step |
| `gameObject.AddComponent<Rigidbody2D>()` | A new Box2D body, created when it appears |
| `OnCollisionEnter2D`, `Stay2D`, `Exit2D` | Sent after the physics step, as in Unity |

Each fixed step, the generated glue, `physics_box2d.c` in your output folder:

1. creates Box2D bodies for new rigidbodies,
2. pushes what your scripts changed (velocity, teleports, gravity scale, damping, world gravity) into Box2D,
3. steps the world,
4. copies positions and velocities back into your objects,
5. reports which colliders are touching, so `unity_pack` can send Enter, Stay, and Exit.

It is about 300 lines of plain C, and reading it is one of the fastest ways to understand how a game engine drives a physics engine.

## Try it

The [`examples/BouncingBall`](examples/BouncingBall) project is a ball that falls onto the ground and bounces three times. With crust and Box2D-Packed checked out side by side (see [Try it](CSharpSubset.md#try-it)):

```sh
python3 crust/tools/unity_pack.py GameplayProgramming/examples/BouncingBall -o /tmp/ball --strict
/tmp/ball/BouncingBall -logFile -
```

```
landed 1
left the ground
ticks=60 draws=0
```

`unity_pack` builds Box2D-Packed for you. It finds the checkout beside crust, through `--box2d PATH`, or through `BOX2D_PACKED_ROOT`.

### Advanced: collision logic inside the engine

```sh
python3 crust/tools/unity_pack.py GameplayProgramming/examples/BouncingBall -o /tmp/ball --physics-inject
```

With `--physics-inject`, the touching pairs are recorded by code compiled into Box2D-Packed's own contact loop, instead of being read from Box2D's event arrays after the step. Your scripts still run after the step, as in Unity, and the results are identical. The `box2d_inject.json` file in the output folder is the whole injection. It is short enough to read in a minute.

## What to expect, honestly

- **It is a research project.** It has been tested against Box2D v3, the engine it forks, not yet against Unity. With simulated caches, it cuts the slowest kind of cache miss by up to 65% in query-heavy scenes, with identical results. We have not measured whether a packed game runs faster than the same game in Unity. The details are in the [paper](https://github.com/crustos/box2d/blob/main/paper/box2d_packed.pdf).
- **Body rotation is locked.** Packed rigidbodies do not have a rotation yet, so bodies slide and stack but do not tip over.
- **Trigger messages are not sent yet.** `isTrigger` colliders become sensors, but `OnTriggerEnter2D` is never called.
- **One physics world**, up to 65,535 bodies and 65,535 shapes, and 16 collision layers.
- **3D physics is not Box2D.** `Rigidbody` and 3D colliders use `unity_pack`'s own simple solver.

## Why open source matters here

In Unity, the physics engine is a black box you configure. Here you can:

- read the glue between your components and the physics engine (`physics_box2d.c`),
- read the physics engine itself (Box2D-Packed is MIT-licensed, like Box2D),
- change either one, rebuild, and see what your change does,
- measure it, with the same tools the Box2D-Packed paper uses.

That is the difference between using an engine and understanding one.

## Things to try

1. **Stack some crates.** Add a few `BoxCollider2D` + `Rigidbody2D` objects above each other to the scene and check that they settle into a stack. Box2D-Packed's own integration test does the same with six crates.
2. **Change the bounce.** Give the ball a `PhysicsMaterial2D` with bounciness, remove the scripted bounce, and compare. Then look up the combine rule in `physics_box2d.c`.
3. **Read one step.** In `physics_box2d.c`, find `engine_box2d_step` and list, in order, what happens in one fixed step. Compare it with Unity's [order of execution](https://docs.unity3d.com/Manual/ExecutionOrder.html) for physics.
