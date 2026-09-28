# From Godot C# to C: the course engine, all the way down

*Optional material, added in this fork. It is not part of the course requirements: the course engine is Godot 4.7.2 and the course language is GDScript (see the [README](README.md)). This page describes an optional path that starts from the same engine and scenes, with C# scripts.*

## What is new

The earlier pages, [From Unity C# to C](CSharpSubset.md) and [Box2D-Packed](Box2DPacked.md), start from Unity. That was a detour: this course teaches Godot.

[crust](https://github.com/brentharts/crust) now reads **Godot 4 projects**. Its `godot_pack` tool takes the scenes you build in the Godot editor (`.tscn`, `.tres`, `project.godot`) and your **C# node scripts**, and turns them into a small native program:

- your scenes become plain data tables, including instanced scenes, groups and physics materials;
- your scripts' `_Ready`, `_Process`, `_PhysicsProcess`, exported fields and `Position` become plain C functions and fields;
- `RigidBody2D`, `StaticBody2D`, `CharacterBody2D`, `Area2D` and their `CollisionShape2D`s run on [Box2D-Packed](Box2DPacked.md), in a mode that follows **Godot's** physics rules, not Unity's;
- the physics signals, `body_entered`, `body_exited`, `area_entered` and `area_exited`, are wired the way you wire them in Godot, from the scene or from `_Ready`.

So the optional path now starts where the course already is: in Godot, with the node, scene and signal ideas the exercises teach.

## Why C#, and not GDScript

GDScript is a good first language for Godot. It ships with every download, it is woven into the editor, and every course exercise and tutorial uses it. This page does not argue that GDScript is a bad choice for learning Godot. It argues that, for **learning gameplay programming**, C# gives a student two things GDScript cannot.

### A language you keep

GDScript exists only inside Godot. Nothing you write in it runs anywhere else, and no other tool, job or codebase uses it.

C# is one of the most widely used languages in industry, and not only for games:

- **Games:** Unity's scripting language; Godot's .NET edition; frameworks like MonoGame and FNA.
- **Everything else:** web services and back ends (ASP.NET Core), desktop applications, cloud services, developer tools, and enterprise software.

The skills a gameplay course builds — types, classes, interfaces, events, generics, and reading a real compiler's error messages — are the skills a C# job asks for. The course's own pattern pages, such as the [Observer Pattern](ObserverPattern.md), are already written in C#.

Godot supports C# officially, through its **.NET edition**. The same C# node scripts this page packs run in Godot's editor and player. A student does not choose between Godot and a transferable language: they get both.

### A pipeline you can see

A GDScript script is compiled to bytecode and executed by Godot's GDScript virtual machine, inside the engine. There is no machine code of your script to look at, and no tool a student uses to see what their `health -= 1` turns into. It is a black box, and a complex one: the interpreter, the engine and the scene tree are all between your line and the CPU.

With crust, every step from your C# to the CPU is a **file you can open**:

```
Ball.cs           your Godot C# node script
   │   godot_pack reads it as the C# subset, and lowers it
   ▼
engine.cpp        a subset of C++
   │   cpprust translates it; crust's own C compiler checks it
   ▼
engine.c          C
   │   gcc -S
   ▼
engine.s          assembly
```

Each stage is small enough to read, and each one keeps a trail back to your code: the C records which line of which script each function came from. [Four files, one handler](#four-files-one-handler) below walks one signal handler through all four.

Godot's own .NET runtime also compiles C#, just in time, at run time. That is fast, but it is just as hidden. The transparency here comes from the crust pipeline, and C# is what makes it possible: GDScript has no such path, and the same C# script runs in both.

### The power is in the hands of the teacher and the student

- **Nothing is a black box.** crust and Box2D-Packed are open source (MIT). Every stage, including the physics engine, can be read, changed and rebuilt by a student or a teacher.
- **The subset is explicit.** Everything outside it is refused with an error in the C# compiler's format, naming the file, the line and the column. A teacher can say "write inside the subset," and the tool enforces it; nothing is silently dropped.
- **Understanding can be checked at every level.** This course grades whether you can show that you understand the work you claim. A packed project gives that question concrete forms: where does this field live in memory? What does this handler become in C? Which instruction adds one to it? A student who wrote the code can answer; the answers are in files anyone can open.
- **The subset can grow.** Supporting a new engine call is adding a row to a binding table in crust. A teacher who needs something for a course can read how the existing rows work, and add one.

## Try it

You need Python 3, gcc, and three repositories side by side:

```sh
git clone https://github.com/brentharts/crust.git
git clone https://github.com/crustos/box2d.git        # Box2D-Packed, for 2D physics
git clone https://github.com/crustos/GameplayProgramming.git
```

Pack the example in this repository, [`examples/GodotBounce`](examples/GodotBounce), and run it:

```sh
python3 crust/tools/godot_pack.py GameplayProgramming/examples/GodotBounce -o /tmp/bounce --strict
/tmp/bounce/GodotBounce
```

```
picked up the coin
landed 1
left the ground
ticks=60 draws=0
```

A ball falls through a coin, which frees itself, lands on the ground, and bounces off it. The headless player runs 60 frames, one second.

Now open [`examples/GodotBounceGDScript`](examples/GodotBounceGDScript) in Godot 4.7.2 — the standard edition, as the course uses — and run it. It is the same scene with GDScript scripts, and it prints the same three lines. To open `examples/GodotBounce` itself in the editor, you need Godot's .NET edition and the .NET SDK. Packing it with crust needs neither.

## The same scene, two languages

The ball's script, in the two languages:

```gdscript
# GodotBounceGDScript/scripts/ball.gd
extends RigidBody2D

@export var landings := 0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(_body: Node) -> void:
	landings = landings + 1
	print("landed ", landings)
```

```csharp
// GodotBounce/scripts/Ball.cs
using Godot;

public partial class Ball : RigidBody2D
{
    [Export] public int Landings = 0;

    public override void _Ready()
    {
        BodyEntered += OnBodyEntered;
        BodyExited += OnBodyExited;
    }

    private void OnBodyEntered(Node body)
    {
        Landings = Landings + 1;
        GD.Print("landed ", Landings);
    }
    ...
}
```

The ideas are the same: a node type, an exported field, `_ready` / `_Ready`, a signal connected to a method. What changes is that the C# version is typed, is a class in a language used far beyond Godot, and can be followed all the way down.

## Four files, one handler

Here is what happens to `OnBodyEntered`. Everything below is copied from the output of the command in [Try it](#try-it).

**1. C#**, as you wrote it:

```csharp
private void OnBodyEntered(Node body)
{
    Landings = Landings + 1;
    GD.Print("landed ", Landings);
}
```

**2. `engine.cpp`**, the C++ subset `godot_pack` writes:

```cpp
static void Ball_OnBodyEntered(unsigned i, int body) {
            Ball_set_Landings(i, Ball_get_Landings(i) + 1);
            Console_WriteLine_s(_str_plus_f(_str_plus_s("", ("landed ")), (Ball_get_Landings(i))));
}
```

Read it next to the C#:

- **An object is an index.** `i` is which ball this is, and `Ball_get_Landings(i)` reads ball `i`'s field.
- **The node a signal passes is an index too.** `body` is the other body's row in the collider table. In a handler you can ask `body is Player`, `body.IsInGroup("players")` or `body.Name`; each of those is a lookup in that table.
- **`GD.Print` concatenates, and so does this.** Each `_str_plus_*` call appends one piece, typed: `s` for a string, `f` for a number.

**3. `engine.c`**, the C that `cpprust` translates it into. For this function, it is the same text: the C++ subset crust writes here uses nothing C lacks, and the translation changes only declarations elsewhere in the file. The whole ball object is this struct:

```c
struct Ball { int Landings; };
```

That is 4 bytes. The ball's position is not in it: it lives in a separate array, `_Ball_pos`, with the positions of every other ball, because the code that moves objects reads positions and nothing else. There is no `Node`, no scene-tree entry, and no header. A comment above the functions, `/* unity_pack:site res://scripts/Ball.cs:7 */`, points back to your script.

**4. Assembly.** Make it yourself from the output folder:

```sh
gcc -O1 -fno-inline -S -masm=intel -fno-asynchronous-unwind-tables engine.c
```

In `engine.s`, the handler is:

```asm
Ball_OnBodyEntered:
	push	rbx
	mov	ebx, edi                  # i, which ball
	call	Ball_get_Landings
	lea	esi, 1[rax]               # Landings + 1
	mov	edi, ebx
	call	Ball_set_Landings
	mov	edi, ebx
	call	Ball_get_Landings
	mov	eax, eax
	pxor	xmm1, xmm1
	cvtsi2ss	xmm1, rax         # the number, for "landed "
	movd	ebx, xmm1
	lea	rsi, .LC4[rip]
	lea	rdi, .LC1[rip]
	call	_str_plus_s
	mov	rdi, rax
	movd	xmm0, ebx
	call	_str_plus_f
	mov	rdi, rax
	call	Console_WriteLine_s
	pop	rbx
	ret
```

Line for line, it is the C. The comments are ours; the rest is gcc's.

Now build it as the generated `Makefile` does, optimized (`-O2` or `-O3` instead of `-O1 -fno-inline`). The handler disappears into the function that sends signals, and `Landings = Landings + 1` becomes three instructions:

```asm
	mov	eax, DWORD PTR _Ball_inst_array[rip]
	add	eax, 1
	mov	DWORD PTR _Ball_inst_array[rip], eax
```

There is one ball, and `Landings` is the first field of its struct, so the compiler can name the field's address directly. That is what data-oriented design buys: when the data is plain, the compiler can see all of it.

## Signals are the observer pattern

A Godot signal is the [observer pattern](ObserverPattern.md), built into the engine: the node that emits `body_entered` is the subject, and each connected method is an observer.

In Godot, the list of observers is a data structure the engine searches at run time. In the packed program, `godot_pack` knows every connection when it packs the scene, so the list becomes code. This is the complete signal dispatch for the example, from `engine.c`:

```c
static void _godot_signal(int ci_self, int ci_other, int kind) {
    int other_area = _Collider2D_is_trigger[ci_other] != 0;
    int og = _godot_col2d_go[ci_other];
    if (og >= 0 && _engine_go_destroyed[og]) return;
    (void)other_area;
    switch (ci_self) {
    case 0:
        /* Ball.body_entered -> Ball.OnBodyEntered */
        if (kind == 0 && !other_area && !_engine_go_destroyed[0]) {
            ...
                Ball_OnBodyEntered(0u, ci_other);
        }
        /* Ball.body_exited -> Ball.OnBodyExited */
        if (kind == 2 && !other_area && !_engine_go_destroyed[0]) {
            ...
                Ball_OnBodyExited(0u, ci_other);
        }
        break;
    case 1:
        /* Coin.body_entered -> Coin.OnBodyEntered */
        if (kind == 0 && !other_area && !_engine_go_destroyed[1]) {
            ...
                Coin_OnBodyEntered(0u, ci_other);
        }
        break;
    default: break;
    }
}
```

After each physics step, the engine compares which colliders touch now with which touched before; each new pair is an Enter (`kind == 0`), each ended pair an Exit (`kind == 2`), and each goes through this function. You can read off every rule in it: an area's `body_entered` ignores other areas; a node freed with `QueueFree()` (`_engine_go_destroyed`) sends and receives nothing more. The coin in the example is connected in the scene, `[connection signal="body_entered" from="Coin" to="Coin" ...]`, and the ball in its `_Ready`; both end up here.

## How your Godot project maps

| In Godot | In the packed program |
|---|---|
| A node | One object: a row of its class's table |
| A node's C# script class | The object's class; its `[Export]` values from the scene are its fields |
| An instanced scene (`crate.tscn` six times) | One class, six rows |
| `_Ready`, `_EnterTree`, `_Process`, `_PhysicsProcess`, `_ExitTree` | Called by the packed engine's loop, with `delta` |
| `Position`, `GlobalPosition`, `Vector2.Up` (which is `(0, -1)`: y points down) | The position table, in Godot's pixels |
| `GD.Print`, `QueueFree()` | Printing, and freeing the node |
| `RigidBody2D` / `CharacterBody2D` / `StaticBody2D` / `Area2D` + `CollisionShape2D` | Box2D-Packed bodies and shapes: rectangles and circles |
| `PhysicsMaterial`: `friction`, `bounce`, `rough`, `absorbent` | Godot's rules: friction `|min(a, b)|`, bounce `clamp(a + b, 0, 1)` |
| `project.godot` gravity, damping, physics ticks | The same values: 980 px/s² down, 60 ticks a second |
| `body_entered`, `body_exited`, `area_entered`, `area_exited` | `_godot_signal`, above |

Godot and Unity mix materials differently. A ball with bounce 0.5 on a floor with bounce 0 rebounds to about a quarter of its drop in Godot, and to about a sixteenth under Unity's averaging. Box2D-Packed has a mode for each engine. See [Box2D-Packed](Box2DPacked.md#godot-mode).

## Checked against real Godot

We did not want to claim "Godot's rules" from reading Godot's source alone, so we ran the same scenes in **Godot 4.7.2 itself**, headless at a fixed 60 frames a second, with GDScript twins of the scripts.

| Scene | Real Godot 4.7.2 | Packed with crust |
|---|---|---|
| `GodotBounce`: events in order | coin, landed (frame 38), left the ground | coin, landed (frame 38), left the ground |
| Box2D-Packed's `Bounce`: first contact of two balls | frames 36 and 35 | frames 36 and 35 |
| Rebound, bounce 0.5 on a plain floor | 0.256 of the drop | 0.243 |
| Rebound, bounce 0.5 on an absorbent 0.3 pad | 0.041 of the drop | 0.036 |
| Speed after 60 steps with `linear_damp` 2 | 13.080 px/s | 13.080 px/s |

The two engines use different solvers, Godot Physics and Box2D, so small differences remain. The rules match: Unity's rule would put the first rebound at 0.0625, and ignoring `absorbent` would put the second at 0.64.

One thing we learned: Godot runs `_physics_process` *before* each physics step, so a script reading a velocity there sees the value from one step earlier. Our first measurement, at frame 60, read 13.531. It took a second measurement at frame 61 to see that both engines agree.

## What is supported, honestly

This is an early research project. Today it is for **studying what an engine does with your code**, not for building your course project.

**Works:** the scenes, instancing, resources and groups described above; the lifecycle methods; `int`, `float`, `bool` and `string` fields and exported values; arithmetic, `if` / `else`, string concatenation; `Position`; `GD.Print`; `QueueFree()`; 2D rigid, static, character and area bodies with rectangle and circle shapes; physics materials; the four physics signals.

**Not yet**, each one refused with an error at your line:

- **Nothing is drawn.** Sprites, textures, and `Camera2D` are not packed yet; the player runs headless.
- **No input.** `Input` and `_Input` are refused, so a playable game is not possible yet.
- **No `GetNode`**, other signals (`Timeout`, `Pressed` ...), node references in exported fields, collision layers, or `Rotation` / `Scale`.
- **GDScript is not packed.** Only C# scripts are.
- **Bodies do not rotate.** Packed bodies are locked upright; the packer warns about any `RigidBody2D` that could rotate.
- **A freed node's body stays in the physics world.** It sends no more signals, but it still collides.

Pack with `--strict` while you learn: then anything the translator cannot handle stops the build, instead of being reported as a warning. The full reference is [`GODOT_PACK.md`](https://github.com/brentharts/crust/blob/master/GODOT_PACK.md) in crust.

## Reading the errors

When a script leaves the subset, `godot_pack` stops with a diagnostic in the C# compiler's format, naming the file as Godot does, with `res://`:

```
res://scripts/Ball.cs(11,20): error CS8000: `GetNode` (Godot API) is not packed yet
res://coin.tscn:6: error: GDScript is not packed yet (res://scripts/coin.gd); unity_pack reads Godot C# scripts
```

Scene problems name the `.tscn` line: a second shape on one body, an unsupported shape type, a signal that is not packed.

## Connections to the course

| Competency | Where this material helps |
|---|---|
| Engine Usage | See what Godot's nodes, scenes, signals and physics look like once they are plain data and plain functions |
| Design Patterns | Signals as the observer pattern, with the observer list compiled into a `switch`; components as table rows |
| Debugging and Testing | Errors point at your line; every stage can be opened, and the C stepped through in a debugger |
| Game Systems | Every system your scene uses is visible, down to the physics engine |

## Things to try

1. **Find the three instructions.** Pack the example, build `engine.c` with `gcc -O2 -S -masm=intel`, and find the `add eax, 1` that is `Landings = Landings + 1`. Then add a second ball to `main.tscn` and look again. What had to change, and why?
2. **Leave the subset on purpose.** In `Ball.cs`'s `_Ready`, add `var coin = GetNode<Area2D>("../Coin");`. Pack with `--strict` and read the error. Then remove it.
3. **Change a rule, in both engines.** Give the `Ground` a `PhysicsMaterial` with `bounce = 0.3` and `absorbent = true`. Predict the ball's first rebound from Godot's rule, then check it: in Godot with `GodotBounceGDScript`, and packed with `GodotBounce`.
4. **Follow a signal.** In the output folder, find where `physics_box2d.c` reports a touching pair, then follow it into `engine_physics_collide2d_messages` and `_godot_signal` in `engine.c`, to `Ball_OnBodyEntered`.
