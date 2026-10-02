# BouncingBall

A minimal Unity-style project: a ball with a `Rigidbody2D` and a `CircleCollider2D` falls onto a ground with a `BoxCollider2D`. Its script, `Ball.cs`, logs each landing and bounces the ball three times from `OnCollisionEnter2D`.

It is the example for [From Unity C# to C](../../CSharpSubset.md) and [Box2D-Packed](../../Box2DPacked.md). The folder holds only what `unity_pack` reads: the script, its `.meta` file, and the scene.

```sh
python3 crust/tools/unity_pack.py GameplayProgramming/examples/BouncingBall -o /tmp/ball --strict
/tmp/ball/BouncingBall -logFile -
```
