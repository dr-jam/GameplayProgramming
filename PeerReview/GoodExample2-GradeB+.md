# Code Review for Programming Exercise 1 #

## Peer Reviewer Information ##
Reviewer Name: REDACTED

Reviewer Email Address: REDACTED

Reviewer Github: REDACTED

## Solution Assessment ##

Individual stages are assessed using the following criterion:

#### Perfect #### 
    Can't find any flaws in relation to the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not really converging to a solution. Pervasive Major flaws. Objective largely unmet.


### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The Captain moves to the right as required. The solution uses the left movement script as the basis. The velocity in the x direction is positive and the captain's sprite is not flipped when moving right.

### Stage 2 ###

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The pirate correctly generates items at 8, 4, or 2 second intervals depending on their work speed. 
All pirates start as slow workers when the game is started.

Checking the code, the total work time (totalTime) is initialized as a random float in a range depending on the work speed. 
As the pirate works, deltaTime is added to currentTime. When currentTime is greater than PRODUCTION_TIME and the pirate is not exhausted, the pirate generates an item in a random position next to but not on the pirate.
PRODUCTION_TIME is then subtracted from currentTime and totalTime, and work continues until totalTime is less than PRODUCTION_TIME, in which the pirate becomes exhausted.

There are two flaws in this implementation:
1. Having the pirate create items in only [5 possible locations](https://github.com/ensemble-ai/exercise-1-command-pattern-eavivi4/blob/c1a7874864008b734625a3560c4b0a46f42ddae6/Captain/Assets/Scripts/SlowWorkerPirateCommand.cs#L30) causes loot to be frequently made in the same position and therefore overlap each other perfectly. What might look like one piece of loot might actually be 2 or 3 overlapping each other.
This means that it is difficult to count how many items a pirate has made in total unless the player collects the layer of loot, logs how much their booty number went up, and divides it by the value of a singlular piece of loot.

2. The [condition](https://github.com/ensemble-ai/exercise-1-command-pattern-eavivi4/blob/c1a7874864008b734625a3560c4b0a46f42ddae6/Captain/Assets/Scripts/SlowWorkerPirateCommand.cs#L47) in which exhaustion is determined makes it so that the pirate becomes exhausted when there is not enough time to make another item. 
This means that the pirate gets exhausted immediately after making the last item. However, the pirate is supposed to work for the remaining amount of time even if they do not make an item in that time.
The pirate only works for floor(totalTime / PRODUCTION_TIME) seconds and not the full time that was decided randomly at the beginning.

### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justifaction ##### 
Testing the [Motivate()](https://github.com/ensemble-ai/exercise-1-command-pattern-eavivi4/blob/c1a7874864008b734625a3560c4b0a46f42ddae6/Captain/Assets/Scripts/PirateController.cs#L27) method in play mode multiple times showed that all three work speeds were possible. Looking at the code, the Motivate() method generated a random integer from 1-3 and attributed one of the three work speeds to each number.

### Stage 4 ###

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justifaction ##### 
A [jumping script](https://github.com/ensemble-ai/exercise-1-command-pattern-eavivi4/blob/c1a7874864008b734625a3560c4b0a46f42ddae6/Captain/Assets/Scripts/Jump.cs#L10) was added and mapped to Fire2.

There are two flaws in its implementation.

1. There is no check for whether the captain is allowed to jump (for example, if the captain is grounded). 
As a result, the player can repeatedly press Fire2 and jump infinitely while midair.

2. The left movement script was used as the basis for the jump script. 
The x component of the captain's velocity was changed to the captain's current x component. The y component was changed to a constant positive value. This sends the captain upward as expected. 
However, [the flipX line of code](https://github.com/ensemble-ai/exercise-1-command-pattern-eavivi4/blob/c1a7874864008b734625a3560c4b0a46f42ddae6/Captain/Assets/Scripts/Jump.cs#L21) was not removed or changed.
If the captain is standing still and facing right, jumping will make the captain face left even though the player is not holding left.
This means that when the player is not holding right, the captain will always face left when jumping. 

## Code Style ##

### Code Style Review ###
There are a couple of infractions, but the code style is consistent overall.
#### Style Guide Infractions ####
- Most [comments](https://github.com/ensemble-ai/exercise-1-command-pattern-eavivi4/blob/c1a7874864008b734625a3560c4b0a46f42ddae6/Captain/Assets/Scripts/SlowWorkerPirateCommand.cs#L26) across multiple .cs files do not have a space after '//,' do not start with a capital letter, and do not end with a period.

- When generating a random integer for [determining pirate work speed](https://github.com/ensemble-ai/exercise-1-command-pattern-eavivi4/blob/c1a7874864008b734625a3560c4b0a46f42ddae6/Captain/Assets/Scripts/PirateController.cs#L29) and for [item spawn position](https://github.com/ensemble-ai/exercise-1-command-pattern-eavivi4/blob/c1a7874864008b734625a3560c4b0a46f42ddae6/Captain/Assets/Scripts/SlowWorkerPirateCommand.cs#L30), the variable's type is not var despite knowing that Random.Range() with integer parameters returns an integer.

- Multiple [conditions in an if statement separated by 'and' symbols](https://github.com/ensemble-ai/exercise-1-command-pattern-eavivi4/blob/c1a7874864008b734625a3560c4b0a46f42ddae6/Captain/Assets/Scripts/SlowWorkerPirateCommand.cs#L27) are not put in their own set of parentheses to make them stand out.


#### Style Guide Exemplars ####
- Most [comments](https://github.com/ensemble-ai/exercise-1-command-pattern-eavivi4/blob/c1a7874864008b734625a3560c4b0a46f42ddae6/Captain/Assets/Scripts/SlowWorkerPirateCommand.cs#L26) are on their own separate line of code.
- The local variable [newItem](https://github.com/ensemble-ai/exercise-1-command-pattern-eavivi4/blob/c1a7874864008b734625a3560c4b0a46f42ddae6/Captain/Assets/Scripts/SlowWorkerPirateCommand.cs#L39) has a type var even though it is obvious that it is a GameObject due to casting. Furthermore, since it is a local variable, it is correctly named using camelCase.
- [Things like conditionals and functions](https://github.com/ensemble-ai/exercise-1-command-pattern-eavivi4/blob/c1a7874864008b734625a3560c4b0a46f42ddae6/Captain/Assets/Scripts/SlowWorkerPirateCommand.cs#L27) have their brackets on separate lines.

## Best Practices ##


### Best Practices Review ###
 The code overall is easy to follow and its processes are easy to understand when reading from top to bottom.
#### Best Practices Infractions ####
- Honestly, I could not see one that would not fall under Code Style instead of Unity Best Practices.

#### Best Practices Exemplars ####

- Private variables like [currentTime](https://github.com/ensemble-ai/exercise-1-command-pattern-eavivi4/blob/c1a7874864008b734625a3560c4b0a46f42ddae6/Captain/Assets/Scripts/SlowWorkerPirateCommand.cs#L10) use camelCase.

- Classes like [SlowWorkerPirateCommand](https://github.com/ensemble-ai/exercise-1-command-pattern-eavivi4/blob/c1a7874864008b734625a3560c4b0a46f42ddae6/Captain/Assets/Scripts/SlowWorkerPirateCommand.cs#L7) are short. Its [Execute](https://github.com/ensemble-ai/exercise-1-command-pattern-eavivi4/blob/c1a7874864008b734625a3560c4b0a46f42ddae6/Captain/Assets/Scripts/SlowWorkerPirateCommand.cs#L15) method is not one huge block of code, and is broken into sections with comments explaining what each section does. This makes it more readable and easier to follow.

- There are no public variables in the WorkerCommand files.
