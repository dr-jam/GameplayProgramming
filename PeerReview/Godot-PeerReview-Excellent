# Code Review for Programming Exercise 1 #
## Description ##

For this assignment, you will be giving feedback on the completeness of Exercise 1.  To do so, we will be giving you a rubric to provide feedback on. For the feedback, please provide positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to review the code and project files that were given out by the instructor.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.

## Due Date and Submission Information ##
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer-review. The file name should be the same as in the template: PeerReview-Exercise1.md. You also need to include your name and email address in the Peer-reviewer Information section below. This review document should be placed into the base folder of the repo you are reviewing in the master branch. This branch should be on the origin of the repository you are reviewing.

If you are in the rare situation where there are two peer-reviewers on a single repository, append your UC Davis user name before the extension of your review file. An example: PeerReview-Exercise1-username.md. Both reviewers should submit their reviews in the master branch.  

## Solution Assessment ##

## Peer-reviewer Information


### Description ###

To assess the solution, you will be choosing ONE choice from unsatisfactory, satisfactory, good, great, or perfect. Place an x character inside of the square braces next to the appropriate label.

The following are the criteria by which you should assess your peer's solution of the exercise's stages.

#### Perfect #### 
    Cannot find any flaws concerning the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    A major flaw and some minor flaws.

#### Satisfactory ####
    A couple of major flaws. Heading towards a solution, however, did not fully realize the solution.

#### Unsatisfactory ####
    Partial work, but not really converging to a solution. Pervasive major flaws. Objective largely unmet.


### Stage 1 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
While it is called "UpCommand" instead of "JumpCommand," the implementation for Stage 1 is perfect. The command checks if the player is on the floor before setting the player's y velocity. There is a also a command callback so that the jump sound is played.

### Stage 2 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The implementation for Stage 2 follows the guidelines. When the player is near the follower, the follower moves towards the player. When the player is a set distance away from the follower, the follower stops moving. The follower also jumps when the player is above it.

### Stage 3 ###

- [ ] Perfect
- [X] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
Very enjoyable cutscene and dialogue. The characters are synced with the dialogue and all start jumping at the same time. However, there are only 6 unique commands used (Summon, Dialogue, Idle, Jump, MoveLeft, MoveRight). When the cutscene is triggered, the player inputs are unbound and the follower stops following. The cutscene uses a Timer to end the cutscene at the correct time and start the boss fight. Overall a fine way of handling the cutscene starting and ending.

### Stage 4 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The boss fight checks all of the boxes! The fight is winnable (although I had a tough time on my blind playthrough). The boss has a simple AI that moves the boss towards the player and attacks when close. After the boss moves five times, it has a unique mechanic where it jumps then shakes uncontrollably and this is when the boss is vulnerable to attacks. 

## Code Style ##

### Description ###
Check the scripts to see if the student code follows the .Net style guide.

If sections don't adhere to the style guide, please permalink the line of code from GitHub and justify why the line of code has infractions of the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Here is an example of the permalink drop-down on GitHub.

![Permalink option](../images/permalink_example.png)

Here is another example as well.

* [I go to Github and look at the ICommand script in the ECS189L repo!](https://github.com/dr-jam/ECS189L/blob/1618376092e85ffd63d3af9d9dcc1f2078df2170/Projects/CommandPatternExample/Assets/Scripts/ICommand.cs#L5)

### Code Style Review ###

#### Style Guide Infractions ####
There are very few infractions with the GDScript style guide and the few that do exist are small nitpicks.

* [There should be a blank line between these variables](https://github.com/ensemble-ai/exercise-1-command-pattern-cho-yujin/blob/aa5f6c9b85bf98d91cd5b449624709244e295a8b/Rut/scripts/boss_encounter_trigger.gd#L7) - These variables are public and private so they should be separated.

* ~~[Private function out of order](https://github.com/ensemble-ai/exercise-1-command-pattern-cho-yujin/blob/aa5f6c9b85bf98d91cd5b449624709244e295a8b/Rut/scripts/player.gd#L71) - Private functions should go below public functions.~~ This was a mistake made in the original exercise.

#### Style Guide Exemplars ####

* [Separating logical sections in functions](https://github.com/ensemble-ai/exercise-1-command-pattern-cho-yujin/blob/aa5f6c9b85bf98d91cd5b449624709244e295a8b/Rut/scripts/boss_battle.gd#L24) - This function showcases a great use of blank lines to separate logical sections of code within the function.

## Best Practices ##

### Description ###

If the student has followed best practices (Unity coding conventions from the StyleGuides document), then feel free to point at these segments of code as examples. 

If the student has breached the best practices and has done something that should be noted, please add the infracture.

This should be similar to the Code Style justification.

### Best Practices Review ###

#### Best Practices Infractions ####

* [Using %Player despite having a player variable](https://github.com/ensemble-ai/exercise-1-command-pattern-cho-yujin/blob/aa5f6c9b85bf98d91cd5b449624709244e295a8b/Rut/scripts/follower.gd#L9C1-L9C37) - If there is already a variable that stores a reference to the player, then it should be used instead of %Player each time.

* [Mysterious counter variable](https://github.com/ensemble-ai/exercise-1-command-pattern-cho-yujin/blob/aa5f6c9b85bf98d91cd5b449624709244e295a8b/Rut/scripts/boss_battle.gd#L6) - The boss contains a counter variable without any documentation on what it is supposed to be counting.

* [Unused moveLeft variable](https://github.com/ensemble-ai/exercise-1-command-pattern-cho-yujin/blob/aa5f6c9b85bf98d91cd5b449624709244e295a8b/Rut/scripts/cutscene_manager.gd#L16) - The cutscene manager contains an unused variable above a function. I assume this was pasted here and then forgotten.

* [Unused is_cutscene_activated variable](https://github.com/ensemble-ai/exercise-1-command-pattern-cho-yujin/blob/aa5f6c9b85bf98d91cd5b449624709244e295a8b/Rut/scripts/cutscene_manager.gd#L4) - There is an exported variable for the cutscene being activated that, as far as I can tell, is not used anywhere. It might have been left over from debugging.

* [Variable with no type assigned](https://github.com/ensemble-ai/exercise-1-command-pattern-cho-yujin/blob/8db9fa43ebb30f9d83845d53f1b315dd16d01d1e/Rut/scripts/follower.gd#L6) - The type of _following_enabled should be statically typed as a bool.

* [Variable with no type assigned](https://github.com/ensemble-ai/exercise-1-command-pattern-cho-yujin/blob/8db9fa43ebb30f9d83845d53f1b315dd16d01d1e/Rut/scripts/boss.gd#L9) - The type of _is_invincible should be statically typed as a bool.

These next few are more subjective:

* [Follower movement is controlled by Follow Command](https://github.com/ensemble-ai/exercise-1-command-pattern-cho-yujin/blob/8db9fa43ebb30f9d83845d53f1b315dd16d01d1e/Rut/scripts/commands/NPC/follow_command.gd#L11) - The Follow Command rewrites the code used for the move and jump commands. The logic could be changed so that the follower uses the move and jump commands so less code has to be rewritten. 

* [Cutscene logic is split between two scripts](https://github.com/ensemble-ai/exercise-1-command-pattern-cho-yujin/blob/aa5f6c9b85bf98d91cd5b449624709244e295a8b/Rut/scripts/boss_encounter_trigger.gd#L34) - The cutscene is handled by two different scripts, making the code harder to follow. The logic for handling the ending of the cutscene is done in the boss encounter trigger when the cutscene could have handled this itself. Additionally, the end_cutscene function should have all of the logic for ending the cutscene, but some of that logic is done in the timout function inside the boss trigger. This means if you want to change the ending cutscene logic, you would have to edit two completely different places in the code.

#### Best Practices Exemplars ####
* [Refilling the boss command list once its empty](https://github.com/ensemble-ai/exercise-1-command-pattern-cho-yujin/blob/aa5f6c9b85bf98d91cd5b449624709244e295a8b/Rut/scripts/boss_battle.gd#L21) - I think this is a simple but effective way of using the command pattern to have a looping boss AI.

* [Using static typing for function parameters and return types](https://github.com/ensemble-ai/exercise-1-command-pattern-cho-yujin/blob/8db9fa43ebb30f9d83845d53f1b315dd16d01d1e/Rut/scripts/boss_battle.gd#L24) - This is an example of how parameters and return types are statically typed throughout the code which is good practice.
