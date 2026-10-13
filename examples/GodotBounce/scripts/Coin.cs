using Godot;

public partial class Coin : Area2D
{
    private void OnBodyEntered(Node2D body)
    {
        if (body.IsInGroup("players"))
        {
            GD.Print("picked up the coin");
            QueueFree();
        }
    }
}
