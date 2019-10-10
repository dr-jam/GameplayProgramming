using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MarioJump : MonoBehaviour
{

    [SerializeField] private float JumpVerticalSpeed = 10.0f;
    [SerializeField] private float JumpHorizontalSpeed = 1.0f;
    [SerializeField] private float JumpGravity = -9.81f;

    [SerializeField] private float ShortLongJumpThreshold = 0.15f;

    [SerializeField] private float InitialDuration = 0.25f;
    [SerializeField] private AnimationCurve Initial;
    private float InitialTimer;

    [SerializeField] private float LongUpDuration = 0.25f;
    [SerializeField] private AnimationCurve LongUp;
    private float LongUpTimer;

    [SerializeField] private float LongFloatDuration = 0.25f;
    [SerializeField] private AnimationCurve LongFloat;
    private float LongFloatTimer;

    [SerializeField] private float LongDownDuration = 0.25f;
    [SerializeField] private AnimationCurve LongDown;
    private float LongDownTimer;

    [SerializeField] private float ShortUpDuration = 0.25f;
    [SerializeField] private AnimationCurve ShortUp;
    private float ShortUpTimer;

    [SerializeField] private float ShortFloatDuration = 0.25f;
    [SerializeField] private AnimationCurve ShortFloat;
    private float ShortFloatTimer;

    [SerializeField] private float ShortDownDuration = 0.25f;
    [SerializeField] private AnimationCurve ShortDown;
    private float ShortDownTimer;

    private float InitialVelocity = 0.0f;
    private float InitialJumpButtonHold = 0.0f;

    private enum State { Initial, LongUp, LongFloat, LongDown, ShortUp, ShortFloat, ShortDown, None}
    private State CurrentState = State.None;

    private bool Jumping = false;

    void Start()
    {
        this.ResetTimers();
        this.CurrentState = State.None;
    }

    public void SetInitialVelocity(float initialVelocity)
    {
        this.InitialVelocity = initialVelocity;
    }

    void Update()
    {
        if(Input.GetButtonDown("Jump"))
        {
            this.ResetTimers();
            this.CurrentState = State.Initial;
            this.Jumping = false;
            this.InitialJumpButtonHold = 0.0f;
            Debug.Log("JumpTime");
        }

        if (Input.GetButton("Jump"))
        {

        }

        if (Input.GetButtonUp("Jump") & State.Initial == this.CurrentState)
        {
            this.InitialJumpButtonHold = this.InitialTimer;
            if(this.InitialTimer <= this.ShortLongJumpThreshold)
            {
                this.CurrentState = State.ShortUp;
            }
            else
            {
                this.CurrentState = State.ShortDown;
            }
        }

        if (this.Jumping)
        {
            var position = this.gameObject.transform.position;
            position.x += this.JumpVerticalSpeed * this.CalcJumpYVelocity() * Time.deltaTime;
            this.gameObject.transform.position = position;
        }
    }

    private float CalcJumpYVelocity()
    {
        float velocity = 1.0f;

        if (State.Initial == this.CurrentState)
        {
            velocity = this.Initial.Evaluate(this.InitialTimer / this.InitialDuration);
            this.InitialTimer += Time.deltaTime;
            if (this.InitialTimer > this.InitialDuration)
            {
                this.CurrentState = State.LongUp;
            }
        }
        else if (State.LongUp == this.CurrentState)
        {
            velocity = this.LongUp.Evaluate(this.LongUpTimer / this.LongUpDuration);
            this.LongUpTimer += Time.deltaTime;
            if (this.LongUpTimer > this.LongUpDuration)
            {
                this.CurrentState = State.LongFloat;
            }
        }
        else if (State.LongFloat == this.CurrentState)
        {
            velocity = this.LongFloat.Evaluate(this.LongFloatTimer / this.LongFloatDuration);
            this.LongFloatTimer += Time.deltaTime;
            if (this.LongFloatTimer > this.LongFloatDuration)
            {
                this.CurrentState = State.LongDown;
            }
        }
        else if (State.LongDown == this.CurrentState)
        {
            velocity = this.LongDown.Evaluate(this.LongDownTimer / this.LongDownDuration);
            this.LongDownTimer += Time.deltaTime;
            if (this.LongDownTimer > this.LongDownDuration)
            {
                this.CurrentState = State.None;
            }
        }
        else if (State.ShortUp == this.CurrentState)
        {
            velocity = this.ShortUp.Evaluate(this.ShortUpTimer / this.ShortUpDuration);
            this.ShortUpTimer += Time.deltaTime;
            if (this.ShortUpTimer > this.ShortUpDuration)
            {
                this.CurrentState = State.ShortFloat;
            }
        }
        else if (State.ShortFloat == this.CurrentState)
        {
            velocity = this.ShortFloat.Evaluate(this.ShortFloatTimer / this.ShortFloatDuration);
            this.ShortFloatTimer += Time.deltaTime;
            if (this.ShortFloatTimer > this.ShortFloatDuration)
            {
                this.CurrentState = State.ShortFloat;
            }
        }
        else if (State.ShortFloat == this.CurrentState)
        {
            velocity = this.ShortFloat.Evaluate(this.ShortFloatTimer / this.ShortFloatDuration);
            velocity *= this.JumpGravity;
            this.ShortFloatTimer += Time.deltaTime;
            if (this.ShortFloatTimer > this.ShortFloatDuration)
            {
                this.CurrentState = State.None;
            }
        }
        Debug.Log(velocity);
        return velocity;

    }

    private void OnCollisionEnter(Collision collision)
    {
        if (LayerMask.NameToLayer("Ground") == collision.gameObject.layer)
        {
            this.Jumping = false;
        }
    }

    private void ResetTimers()
    {
        this.InitialTimer = 0.0f;
        this.LongUpTimer = 0.0f;
        this.LongFloatTimer = 0.0f;
        this.LongDownTimer = 0.0f;
        this.ShortUpTimer = 0.0f;
        this.ShortFloatTimer = 0.0f;
        this.ShortDownTimer = 0.0f;
    }
}
