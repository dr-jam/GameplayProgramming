# Code Review for Programming Exercise 1 #
REDACTED  
REDACTED  
## Description ##

For this assignment, you will be giving feedback on the completeness of Exercise 1. In order to do so, we will be giving you a rubric to give feedback on. For the feedback, please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to review the code and project files that were given out by the instructor.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.

## Due Date and Submission Information ##

A successful submission should consist of a copy of this markdown document template that is modified with your peer-review. The file name should be the same as it is in the template: PeerReview-Exercise1.md. You also need to include your name and email address in the Peer-reviewer Information section below. This review document should be placed into the base folder of the repo you are reviewing in the master branch. This branch should be on the origin of the repository you are reviewing.

If you are in the rare situation where there are two peer-reviewers on a single repository, append your UC Davis user name before the extension of your review file. An example: PeerReview-Exercise1-username.md. Both reviewers should submit their reviews in the master branch.  

## Solution Assessment ##

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect. Place an x character inside of the square braces next to the appropriate label.

The following are the criteria by which you should assess your peer's solution of the exercise's stages.

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
Character moves in both left and right directions. Sprite flips if it was facing other direction.

### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The working commands all set to the numbers described in the assignment, and instantiate the prefabs at the right intervals. Prefabs spawn at random angles coming off of the pirates producing them.

### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justifaction ##### 
The PirateController Motivate makes a choice between the three work speeds and assigns one of them. 

### Stage 4 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justifaction ##### 
Student implemented a jump command. I am impressed with it, as I also implemented a jump command. They figured out better ways to solve some of the problems that I came across, [such as checking if the captain is grounded by checking if they collided with the ground](https://github.com/ensemble-ai/exercise-1-command-pattern-cwdaggs/blob/194e35dc274d37dac2dc92bd86a21bfa2df4d42b/Captain/Assets/Scripts/CaptainController.cs#L77) before last jump to prevent double jumps I think this is better than the method I used of checking if the vertical velocity is zero, because with my method you could theoretically get a double jump if you time it just right. [I also notice their use of AddForce makes for a much better jump feel than the velocity changing I did.](https://github.com/ensemble-ai/exercise-1-command-pattern-cwdaggs/blob/194e35dc274d37dac2dc92bd86a21bfa2df4d42b/Captain/Assets/Scripts/CaptainFireTwoCommand.cs#L19)

## Code Style ##

### Description ###
Check the scripts to see if the student code adheres to the dotnet style guide.

If there are sections that don't adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has infractured the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Here is an example of the permalink drop down on Github.

![Permalink option](../images/permalink_example.png)

Here is another example as well.

* [I go to Github and look at the ICommand script in the ECS189L repo!](https://github.com/dr-jam/ECS189L/blob/1618376092e85ffd63d3af9d9dcc1f2078df2170/Projects/CommandPatternExample/Assets/Scripts/ICommand.cs#L5)

### Code Style Review ###

Following this style guide: https://github.com/raywenderlich/c-sharp-style-guide

#### Style Guide Infractions ####

I can't find any infractions in the latest version of the student's project. I think that's because they took care to go through their project and fix any infractions at the end before submission. For example, I notice they fixed this [line](https://github.com/ensemble-ai/exercise-1-command-pattern-cwdaggs/blob/55a4cf37dcc1b422d3fb463c639d7612c37d809f/Captain/Assets/Scripts/NormalWorkerPirateCommand.cs#L33) because it was over 100 characters. They fixed it to line wrap. Student was clearly very careful to avoid infractions of style guide.

#### Style Guide Exemplars ####

Student used camel case for all variables and fields.
[Student used correct format for switch statement, avoiding an empty default case.](https://github.com/ensemble-ai/exercise-1-command-pattern-cwdaggs/blob/55a4cf37dcc1b422d3fb463c639d7612c37d809f/Captain/Assets/Scripts/PirateController.cs#L38)
Student followed all style guide rules, from what I can tell.

## Best Practices ##

### Description ###

If the student has followed best practices (Unity coding conventions from the StyleGuides document) then feel free to point at these segments of code as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infracture.

This should be similar to the Code Style justification.

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

### Best Practices Review ###

#### Best Practices Infractions ####

No violations of the unity style guide found, but I do have some feedback on issues I noticed and I think this is the best place to put them. Overall I think this is a great submission, please take all of this as constructive criticism!

[This variable should not be a float.](https://github.com/ensemble-ai/exercise-1-command-pattern-cwdaggs/blob/55a4cf37dcc1b422d3fb463c639d7612c37d809f/Captain/Assets/Scripts/PirateController.cs#L37) It is being assigned as an int and compared to ints. Only reason this is working is because of implicit conversion.

[The exhausted variable is never being changed.](https://github.com/ensemble-ai/exercise-1-command-pattern-cwdaggs/blob/194e35dc274d37dac2dc92bd86a21bfa2df4d42b/Captain/Assets/Scripts/NormalWorkerPirateCommand.cs#L14) It's always false, [yet it and its inverse are being returned.](https://github.com/ensemble-ai/exercise-1-command-pattern-cwdaggs/blob/194e35dc274d37dac2dc92bd86a21bfa2df4d42b/Captain/Assets/Scripts/NormalWorkerPirateCommand.cs#L37) Probably better to just return true or false here, this makes the code needlessly confusing. Same thing in the other two worker commands.

[It would be more clear what these values were for if they were constants.](https://github.com/ensemble-ai/exercise-1-command-pattern-cwdaggs/blob/194e35dc274d37dac2dc92bd86a21bfa2df4d42b/Captain/Assets/Scripts/NormalWorkerPirateCommand.cs#L18) Same thing in the other two worker commands.

[CaptainFireTwoCommand is not an ideal name for the jump command class when following command pattern.](https://github.com/ensemble-ai/exercise-1-command-pattern-cwdaggs/blob/194e35dc274d37dac2dc92bd86a21bfa2df4d42b/Captain/Assets/Scripts/CaptainFireTwoCommand.cs) I think the command name should be descriptive of what it does, not what button it's currently assigned to. If we changed the buttons this would be confusing.

Overall, more comments would be helpful. If I didn't do this project myself I would have trouble understanding the purpose of much of the code.

#### Best Practices Exemplars ####

[Using a property with a getter and setter instead of a public field is good practice.](https://github.com/ensemble-ai/exercise-1-command-pattern-cwdaggs/blob/194e35dc274d37dac2dc92bd86a21bfa2df4d42b/Captain/Assets/Scripts/CaptainController.cs#L19)

All classes and methods are not too long. Methods all meet the rule of thumb of fitting on screen.

I notice student made a very large number of commits while working on this project. This is a good practice.

