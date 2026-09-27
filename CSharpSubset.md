# From Unity C# to C: the crust C# subset

*Optional material, added in this fork. It is not part of the course requirements, and the course engine is still Godot (see the [README](README.md)). It applies to Unity-style projects: C# scripts and `.unity` scenes.*

## What this is

Unity runs your C# scripts on a managed runtime. Each script is a `MonoBehaviour`, each object carries a `GameObject` and a `Transform`, and a garbage collector cleans up after you. That machinery is powerful, but it is also hidden. You rarely see what your game becomes in memory.

[crust](https://github.com/brentharts/crust) is an open-source compiler toolkit that can take a Unity-style project and turn it into a small C program you can read line by line. Its `unity_pack` tool reads your scripts and scenes, finds out which parts of the Unity API your scripts actually use, and emits only that:

1. Your C# scripts are translated to a subset of C++ (`tools/cs2cpp.py`).
2. That C++ is translated to C (`tools/cpprust.py`) and checked by crust's own C compiler.
3. The C is compiled with gcc, together with the scene's data and, for 2D physics, [Box2D-Packed](Box2DPacked.md).

The result is a native program with no runtime, no garbage collector, and no hidden objects. Everything it does is in files you can open.

## Why a student might want this

- **You can see what an engine does with your code.** Every C# line has a C counterpart, and the generated file records which script line it came from.
- **You learn how game data is laid out in memory.** This is the core idea behind data-oriented design, which many engines use internally for performance.
- **Everything is open source.** crust and Box2D-Packed are MIT-licensed. You can read, change, and rebuild every part of the pipeline, including the physics engine.
- **It fits your Unity workflow.** You keep authoring in Unity: the same scripts, the same scenes. `unity_pack` reads the project files Unity already writes.

Be clear about what it is not: it is not Unity. It supports a **subset** of C# and a **subset** of the Unity API, and it is an early research project with known gaps, listed below. When your code steps outside the subset, it reports it in the same format the C# compiler uses. Use `--strict` so those reports stop the build.

## Try it

You need Python 3, gcc, and two repositories side by side:

```sh
git clone https://github.com/brentharts/crust.git
git clone https://github.com/crustos/box2d.git        # Box2D-Packed, for 2D physics
git clone https://github.com/crustos/GameplayProgramming.git
```

Pack the example in this repository, [`examples/BouncingBall`](examples/BouncingBall), and run it. `-logFile -` sends `Debug.Log` to the terminal, as in a Unity player:

```sh
python3 crust/tools/unity_pack.py GameplayProgramming/examples/BouncingBall -o /tmp/ball
/tmp/ball/BouncingBall -logFile -
```

```
landed 1
left the ground
ticks=60 draws=0
```

The headless player runs 60 frames, one second of game time, so you see the first landing and the first bounce. `unity_pack` finds Box2D-Packed because it is checked out beside crust. You can also pass `--box2d PATH` or set `BOX2D_PACKED_ROOT`.

## What your script becomes

The example's script, [`Ball.cs`](examples/BouncingBall/Assets/Scripts/Ball.cs), is ordinary Unity C#:

```csharp
public class Ball : MonoBehaviour
{
    public int bounces;
    public int landings;

    void OnCollisionEnter2D(Collision2D collision)
    {
        landings = landings + 1;
        Debug.Log("landed " + landings);
        if (bounces < 3)
        {
            bounces = bounces + 1;
            GetComponent<Rigidbody2D>().velocity = new Vector2(0, 6);
        }
    }
    ...
}
```

In the generated `engine.c`, the whole `Ball` object is this:

```c
struct Ball { int bounces; int landings; };
```

That is 8 bytes. The ball's position is not in the struct at all. It lives in a separate array, `_Ball_pos`, next to the positions of all other balls, because the code that moves objects reads positions and nothing else. There is no `GameObject`, no `Transform` object, and no header. The collision handler becomes:

```c
static void Ball_OnCollisionEnter2D(unsigned i, int collision) {
    Ball_set_landings(i, Ball_get_landings(i) + 1);
    Debug_Log_s(_str_plus_f("landed ", (Ball_get_landings(i))));
    if (Ball_get_bounces(i) < 3)
    {
        Ball_set_bounces(i, Ball_get_bounces(i) + 1);
        { int _up_rb = GameObject_GetComponent_Rigidbody2D(_engine_go_of_Ball(i));
          if (_up_rb >= 0) { _Rigidbody2D_vel_x[_up_rb] = (0); _Rigidbody2D_vel_y[_up_rb] = (6); } }
    }
}
```

Read it next to the C# and a few things become concrete:

- **An object is an index.** `i` is which ball this is. `Ball_get_landings(i)` reads a field of ball number `i`.
- **`GetComponent` is a table lookup.** It finds the ball's `Rigidbody2D` row, `_up_rb`, and writes its velocity columns.
- **A component is a row in a table.** Every `Rigidbody2D` in the scene is a row in the `_Rigidbody2D_*` arrays. This is the [component pattern](ComponentDesignPattern.md) taken to its data-oriented conclusion.

`unity_pack` shrinks fields further when it can prove it is safe. A `hp` field that the scene and the scripts only ever set to values 0 to 7 becomes a 3-bit field. `bounces` stays a full `int` here, because `bounces + 1` could in principle grow without bound. The crust documentation, [`UNITY_PACK.md`](https://github.com/brentharts/crust/blob/master/UNITY_PACK.md), explains each of these rules.

## The C# subset

The subset is shaped by one decision: **there is no garbage collector**. A C# `class` becomes a value with a single owner, destroyed when its owner goes out of scope. Features that need a runtime or a collector, such as `async` / `await`, `yield`, LINQ, and `dynamic`, are left out on purpose.

There are two layers, and it helps to know which one you are using:

- **crust's C# translator**, `cs2cpp`, supports a fairly wide subset: classes, structs, interfaces, inheritance, enums, properties, generics, `List<T>` and `Dictionary<K, V>`, lambdas, and more. It is documented in [`CSRUST.md`](https://github.com/brentharts/crust/blob/master/CSRUST.md).
- **Unity scripts packed by `unity_pack`** go through a translator that is still moving onto `cs2cpp`, one feature at a time. Today it supports less. The table below is what we checked inside a Unity script, packed and run:

| In a Unity script today | Status |
|---|---|
| Fields: `int`, `float`, `bool`, `string`, `Vector2` / `Vector3`, component references | Works |
| `void` methods, Unity messages (`Start`, `Update`, `FixedUpdate`, `OnCollisionEnter2D`, ...) | Works |
| Arithmetic, comparisons, `if` / `else`, string concatenation with `+` | Works |
| Default and named arguments: `Bump()`, `Bump(by: 2)` | Works |
| Static fields and static methods | Works |
| The Unity API in [`UNITY_PACK_SYSTEMS.md`](https://github.com/brentharts/crust/blob/master/UNITY_PACK_SYSTEMS.md): input, UI, animation, audio, `Rigidbody2D`, colliders | Works as documented there |
| Methods that return a value (`int Double(int v)`) | Not yet |
| Reading a property (`int t = Total;`) | Not yet |
| Enum members in method bodies (`Mood.Calm`) | Not yet |
| `List<T>` with `foreach` | Not yet |
| Lambdas | Not yet |
| String interpolation `$"..."` | Not yet |
| `OnTriggerEnter2D` / `Stay2D` / `Exit2D` | Compiled but never called: triggers do not send messages yet |

**Pack with `--strict` while you learn.** Without it, a method the translator cannot handle yet is reported as `warning CS8000` and emitted as an empty method. The program still builds, and it silently does less than your script says. With `--strict`, the same thing is an error that stops the build:

```sh
python3 crust/tools/unity_pack.py GameplayProgramming/examples/BouncingBall -o /tmp/ball --strict
```

## Reading the errors

When a script leaves the subset, `unity_pack` stops with a diagnostic in the C# compiler's format, naming the file and line, like an error in the Unity console:

```
Assets/Scripts/Ball.cs(12,6): error CS8000: `Ball.OnCollisionEnter2D` is not lowered yet (`Total`: C# property read ...)
```

Most diagnostics point at the exact line. Some still point at the start of the method that contains the problem, and a few are generic. String interpolation, for example, currently reports `invalid conversion between types`. When a message is unclear, remove lines from the method until it packs.

## Known issues

These are open problems in crust that we found while writing this page:

- An array field with an initializer, `private int[] hs = new int[4];`, packs without a warning, but the array is never allocated, and the program crashes when it first writes to it. Until this is fixed, do not index array fields in packed scripts.
- `OnTriggerEnter2D` and its siblings are never called.
- The features marked "Not yet" above empty the whole method, not just the line that uses them.

## Connections to the course

| Competency | Where this material helps |
|---|---|
| Engine Usage | See what an engine's components, messages, and physics look like underneath |
| Design Patterns | Components as table rows; collision messages as a fixed, explicit observer list |
| Debugging and Testing | Errors point at your line; the generated C can be read and stepped through in a debugger |
| Game Systems | Every system your game uses is visible as plain data and plain functions |

## Things to try

1. **Watch a field shrink.** Add `public int mood;` to `Ball.cs`, and in `OnCollisionEnter2D` only ever assign it 1 or 2. Pack again and find `mood` in `engine.c`. It becomes a 3-bit field: `unsigned mood : 3;`.
2. **Leave the subset on purpose.** Add a property, `public int Total { get { return landings; } }`, and read it in `OnCollisionEnter2D`: `int t = Total;`. Pack with `--strict` and read the error. Then replace the property with a field, and pack again.
3. **Follow a collision.** In the output folder, open `physics_box2d.c` and find where touching pairs are reported, then find where `Ball_OnCollisionEnter2D` is called in `engine.c`. See [Box2D-Packed](Box2DPacked.md).
