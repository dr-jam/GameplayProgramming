# GodotBounceGDScript

The [`GodotBounce`](../GodotBounce) scene with GDScript scripts instead of C#: the same nodes, physics material, group and signal connections. Open it in Godot 4.7.2, the standard edition the course uses, and run it. The output panel shows the same three lines the packed C# version prints:

```
picked up the coin
landed 1
left the ground
```

This is the Godot side of the comparison in [From Godot C# to C](../../GodotCSharp.md). crust does not pack GDScript: to follow the scripts down to C and assembly, use the C# version.

The same run, headless, from a terminal:

```sh
godot --headless --path GameplayProgramming/examples/GodotBounceGDScript --fixed-fps 60 --quit-after 60
```
