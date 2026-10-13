# Prowl2D: a Unity-style 2D engine you can read all the way down

*Optional material, added in this fork. It is not part of the course requirements: the course engine is Godot 4.7.2 and the course language is GDScript (see the [README](README.md)). This page describes one more engine for the same optional path as [From Godot C# to C](GodotCSharp.md) and [From Unity C# to C](CSharpSubset.md). Nothing here is code in this repository: it links to [Prowl2D](https://github.com/crustos/Prowl2D) and its `Samples/`.*

## What it is

[Prowl2D](https://github.com/crustos/Prowl2D) is a fork of the MIT-licensed [Prowl](https://github.com/ProwlEngine/Prowl) game engine (C# on .NET 10), changed in two ways:

1. **The physics is 2D, and it is Box2D.** `Rigidbody2D`, `Collider2D`, triggers, layers, joints and scene queries run on [Box2D-Packed](Box2DPacked.md), the same physics engine the Godot and Unity paths use.
2. **The core is moving to C.** Not by hand: the core is written once, in a *subset* of C#, and a compiler translates it to C. The same source runs on .NET (in the editor, in tests) and as a native or WebAssembly program with no .NET in it.

Its scripting API is Unity-shaped: a game object and component model, with `OnCollisionBegin2D`, `OnTriggerEnter2D`, `Update` and `FixedUpdate` callbacks. If you know Unity's `MonoBehaviour`, you know most of the shape of a Prowl2D script.

Be clear about what it is not. It is an early research project, not a replacement for Godot in this course. Its own README separates what exists, what has been proven and what is a plan: read that before you build on it.

## Why it belongs next to the Godot path

[From Godot C# to C](GodotCSharp.md) argues that a student learns more about an engine when every step from the script to the CPU is a file they can open. Prowl2D is a second, independent engine on the same idea:

```
Game.cs        your C# game, written against Prowl.Core2D
   │   CCSharp (a C# cross-compiler on Roslyn) reads it as the C# subset
   ▼
C++ subset     crust's C++ subset
   │   cpprust translates it
   ▼
C              plain C
   │   gcc (or clang, for WebAssembly)
   ▼
native / wasm  one executable, Box2D-Packed linked in
```

Two things make it a good comparison with the Godot path:

- **The same source is run twice and compared.** `build.py player <game> --verify` runs the game on .NET and as the translated C program, and requires that they print the same thing. Differences between engines, runtimes and compilers become something you can test for, not something you argue about.
- **The engine is small enough to read.** `Prowl.Core2D`, the runtime that translates to C, is about 1,700 lines: nodes, a scene with a component lifecycle, physics components, and collision and trigger messages to scripts.

## An idea worth reading: a stream of calls

The C# subset has no virtual dispatch, interface or delegate, so the scene cannot simply call a script's `Update`. Prowl2D's answer is that the scene produces a **stream of calls**, and a small generated function performs them:

```csharp
scene.BeginFixedStep(dt);
while (scene.NextCall()) Scripts.Invoke(scene);   // a switch on the component's kind and the callback
```

Each `NextCall` decides what runs next from the scene *as it is at that moment*, so a callback can enable, disable, destroy or create things, and the very next call reflects it. This is a concrete answer to a question every engine has to answer: what happens when a script destroys an object in the middle of an update? The rules (Start runs once, execution order, deferred destruction, pose sync) are in [`Prowl.Core2D/README.md`](https://github.com/crustos/Prowl2D/blob/main/Prowl.Core2D/README.md).

A script is an ordinary C# class marked `[Script]`:

```csharp
[Script, MaxInstances(16)]
class Ball
{
    public Component Self;                    // set when the script is added to a node
    public int Hits;

    public void OnCollisionBegin2D(Collision2D hit) { if (++Hits >= 4) Scene2D.Current.Destroy(Self.Node); }
}
```

## The samples

Start with the first, and read in order. Every sample is a folder of C# under [`Samples/`](https://github.com/crustos/Prowl2D/tree/main/Samples) in the Prowl2D repository.

| Sample | What it shows |
|---|---|
| [`Headless2D`](https://github.com/crustos/Prowl2D/tree/main/Samples/Headless2D) | A ball dropped on a floor, in about 40 lines. No window, no renderer. The smallest complete game, and the first end-to-end test of the runtime. **Start here.** |
| [`Draw2D`](https://github.com/crustos/Prowl2D/tree/main/Samples/Draw2D) | The same idea, drawn: sprites, one instanced draw call. It also runs in a web browser (WebGL2, or WebGPU where there is one). |
| [`UIText2D`](https://github.com/crustos/Prowl2D/tree/main/Samples/UIText2D) | In-game text: measuring, wrapping and clipping. |
| [`Terrain2D`](https://github.com/crustos/Prowl2D/tree/main/Samples/Terrain2D) | Destructible terrain under physics: dig a crater, build a platform. |
| [`Destruction2D`](https://github.com/crustos/Prowl2D/tree/main/Samples/Destruction2D) | A crate shatters into fragments and digs a crater; the fragments fall in. |
| [`Sand2D`](https://github.com/crustos/Prowl2D/tree/main/Samples/Sand2D) | Falling sand and flowing water on the pixels of a terrain. |
| [`GpuSand2D`](https://github.com/crustos/Prowl2D/tree/main/Samples/GpuSand2D) | The same kind of simulation, entirely on the GPU. |
| [`Script2D`](https://github.com/crustos/Prowl2D/tree/main/Samples/Script2D), [`DrawScript2D`](https://github.com/crustos/Prowl2D/tree/main/Samples/DrawScript2D) | What happens when a script leaves the subset (a lambda, `try`/`catch`): the game becomes a hybrid, with that script running managed beside the native engine. |
| [`SlimeJump`](https://github.com/crustos/Prowl2D/tree/main/Samples/SlimeJump) | A complete small platformer, ported from a Unity original, played by a bot. Several systems at once: movement, enemies, traps, a lasso. |
| [`SlimeJumpDestruct`](https://github.com/crustos/Prowl2D/tree/main/Samples/SlimeJumpDestruct) | `SlimeJump` plus a dirt wall the bullets dig through and crates that shatter and chain. Its [README](https://github.com/crustos/Prowl2D/blob/main/Samples/SlimeJumpDestruct/README.md) explains each system. |
| [`SlimeJumpDestructSand`](https://github.com/crustos/Prowl2D/tree/main/Samples/SlimeJumpDestructSand) | A shaft down a ruined building, full of sand, water, boulders and crates. Its [README](https://github.com/crustos/Prowl2D/blob/main/Samples/SlimeJumpDestructSand/README.md) covers the web build, and there is a [playable web demo](https://crustos.github.io/Prowl2D/). |

The three `SlimeJump` samples are the closest thing here to a course-sized game. The last two READMEs are written as case studies, with the numbers behind each design choice.

## Try it

Prowl2D has its own build script and its own prerequisites (Python 3, git, cmake, a C compiler, the .NET 10 SDK, and sibling checkouts of `box2d`, `CCSharp` and `crust`). Follow [its README](https://github.com/crustos/Prowl2D#building) rather than this page, since those steps change. The commands you want look like this:

```sh
python3 build.py deps                                                # clone ../box2d
python3 build.py player Samples/Headless2D --run                     # translate to C, build, run
python3 build.py player Samples/Headless2D --verify                  # ... and compare with the .NET run
python3 build.py check Samples/SlimeJumpDestruct                     # what is outside the C# subset, and where
```

## What to expect, honestly

- **It is a research project.** Its README says a full `dotnet build` of the whole solution had not been run since the 2D changes, and that parts of the editor and the destruction components were written against the engine's APIs as read from source and not yet compiled.
- **Most games are headless today.** Drawing goes through an offscreen renderer; there is no native window, input or audio. The browser build is where a game is shown and played.
- **Linux x86-64 only** for the native player.
- **Limits are small and fixed.** One physics world per process, and engine limits of 256 rigidbodies and 64 joints; pools (nodes, components, meshes) are bounded.
- **It is the Unity way, not the Godot way.** Prowl2D's engine has an editor, but the packed C player has no scene files yet: a game builds its scene in code, and its scripts are `MonoBehaviour`-like callbacks, not Godot nodes and signals. It is a comparison, not a path for the course exercises.

## Connections to the course

| Competency | Where this material helps |
|---|---|
| Engine Usage | Compare two engines' answers to the same question: how a component lifecycle runs, and what a script may do while it runs |
| Design Patterns | Components as records the scene walks; the call stream as an event-dispatch design, with its rejected alternatives set out in the Prowl2D README |
| Debugging and Testing | `--verify` runs one game two ways and compares; `--sanitize` runs it under AddressSanitizer and UBSan; `check` names each construct outside the subset and its line |
| Game Systems | The `SlimeJump` samples layer destruction, sand and water on one game, each system documented and each with a bot that plays it |
| Game Design Reasoning | Read how the destruction samples choose what a blast pushes, kills and chains, and what a crate may collide with |

## Things to try

1. **Read the smallest game.** Open `Headless2D/Game.cs`. Find where the ball is created, where physics is added, and what prints. Then predict how many `hit` lines it prints, and run it to check.
2. **Compare with Godot.** Put `Headless2D` beside [`examples/GodotBounce`](examples/GodotBounce). List what each engine makes you write for a ball that falls and lands, and which of those things the other engine does for you.
3. **Follow one callback.** In `Headless2D`, find `OnCollisionBegin2D`. Using the Prowl2D `Prowl.Core2D` README, trace how it is called: where is `NextCall`, and what does the generated `Scripts.Invoke` do with it?
4. **Read a design decision.** In the `SlimeJumpDestruct` README, find "Nothing is destroyed inside a script's callback". Say why, and say what the Godot way of doing the same thing is (`QueueFree`, which `GodotBounce`'s `Coin.cs` uses).
5. **Leave the subset on purpose.** Add a lambda to a script in a copy of `Headless2D`, and run `python3 build.py check` on it. Read the error, then read what `--dna` does about it.
