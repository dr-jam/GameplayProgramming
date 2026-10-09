# GodotBounce

A minimal Godot 4 project with C# scripts. A ball (`RigidBody2D`) falls through a coin (`Area2D`) onto the ground (`StaticBody2D`) and bounces off it; its physics material gives it a bounce of 0.5.

- `scripts/Ball.cs` connects the ball's `BodyEntered` and `BodyExited` signals in `_Ready`, and prints each landing.
- `scripts/Coin.cs` is connected from the scene (`[connection]` in `main.tscn`); it frees the coin when a body in the `players` group enters.

It is the example for [From Godot C# to C](../../GodotCSharp.md). Pack and run it with crust:

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

To open it in the Godot editor, use Godot's **.NET edition** with the .NET SDK installed; Godot creates the C# project files when you first build. The same scene with GDScript scripts is [`../GodotBounceGDScript`](../GodotBounceGDScript), for the standard edition.
