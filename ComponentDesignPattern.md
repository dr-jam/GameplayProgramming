```c++
class GameObject
{
public:
  GameObject()
  : velocity_(0),
    x_(0), y_(0)
  {}

  void update(World& world, Graphics& graphics);

private:
  static const int WALK_ACCELERATION = 1;

  int velocity_;
  int x_, y_;

  Volume volume_;

  Sprite spriteStand_;
  Sprite spriteWalkLeft_;
  Sprite spriteWalkRight_;
};

void GameObject::update(World& world, Graphics& graphics)
{
  // Apply user input to hero's velocity.
  switch (Controller::getJoystickDirection())
  {
    case DIR_LEFT:
    velocity_ -= WALK_ACCELERATION;
    break;

    case DIR_RIGHT:
    velocity_ += WALK_ACCELERATION;
    break;
  }

  // Modify position by velocity.
  x_ += velocity_;
  world.resolveCollision(volume_, x_, y_, velocity_);

  // Draw the appropriate sprite.
  Sprite* sprite = &spriteStand_;
  if (velocity_ < 0)
  {
    sprite = &spriteWalkLeft_;
  }
  else if (velocity_ > 0)
  {
    sprite = &spriteWalkRight_;
  }

  graphics.draw(*sprite, x_, y_);
}
```

```C++
class InputComponent
{
public:
  void update(GameObject& gameObject)
  {
    switch (Controller::getJoystickDirection())
    {
      case DIR_LEFT:
        gameObject.velocity -= WALK_ACCELERATION;
        break;

      case DIR_RIGHT:
        gameObject.velocity += WALK_ACCELERATION;
        break;
    }
  }

private:
  static const int WALK_ACCELERATION = 1;
};

class GameObject
{
public:
  int velocity;
  int x, y;

  void update(World& world, Graphics& graphics)
  {
    input_.update(*this);

    // Modify position by velocity.
    x += velocity;
    world.resolveCollision(volume_, x, y, velocity);

    // Draw the appropriate sprite.
    Sprite* sprite = &spriteStand_;
    if (velocity < 0)
    {
      sprite = &spriteWalkLeft_;
    }
    else if (velocity > 0)
    {
      sprite = &spriteWalkRight_;
    }

    graphics.draw(*sprite, x, y);
  }

private:
  InputComponent input_;

  Volume volume_;

  Sprite spriteStand_;
  Sprite spriteWalkLeft_;
  Sprite spriteWalkRight_;
};
```

```C++
class GraphicsComponent
{
public:
  void update(GameObject& gameObject, Graphics& graphics)
  {
    Sprite* sprite = &spriteStand_;
    if (gameObject.velocity < 0)
    {
      sprite = &spriteWalkLeft_;
    }
    else if (gameObject.velocity > 0)
    {
      sprite = &spriteWalkRight_;
    }

    graphics.draw(*sprite, gameObject.x, gameObject.y);
  }

private:
  Sprite spriteStand_;
  Sprite spriteWalkLeft_;
  Sprite spriteWalkRight_;
};

class PhysicsComponent
{
public:
  void update(GameObject& gameObject, World& world)
  {
    gameObject.x += gameObject.velocity;
    world.resolveCollision(volume_,
        gameObject.x, gameObject.y, gameObject.velocity);
  }

private:
  Volume volume_;
};

class GameObject
{
public:
  int velocity;
  int x, y;

  void update(World& world, Graphics& graphics)
  {
    input_.update(*this);
    physics_.update(*this, world);
    graphics_.update(*this, graphics);
  }

private:
  InputComponent input_;
  PhysicsComponent physics_;
  GraphicsComponent graphics_;
};
```
