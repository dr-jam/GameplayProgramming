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

    private void OnBodyExited(Node body)
    {
        GD.Print("left the ground");
    }
}
