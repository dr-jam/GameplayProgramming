# Code Review for Programming Exercise 1 #
## Peer Reviewer Information ##
Reviewer Name: REDACTED

Reviewer Email: REDACTED

Reviewer GitHub: REDACTED

## Description ##

For this assignment, you will be giving feedback on the completeness of Exercise 1. In order to to do so, we will be giving you a rubric to give feedback on. For the feedback, please give positive criticism and suggestions on how to fix segments of code.

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
The Captain is able to move the right. The sprite flips back and forth according to left or right input as well. Code follows code for left movement as well, but with right attributes.

### Stage 2 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
All the correct logic is there. The pirates work until they get exhausted and the items spawn. However, if you look at the code, the intervals are fixed at 20, 10, 5. These are supposed to be randomized in the intervals stated in the project description.

### Stage 3 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justifaction ##### 
The motivate function when tested showed that 2 work speeds were possible. Fast wasn't. Looking at the code, it generates a random integer from 1-3, but because they used integers, the Random.Range method is not inclusive on the end range. So it actually only generates the integer 1 and 2. FastWorker never happens, but the other two work great.

### Stage 4 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [x] Unsatisfactory

#### Justifaction ##### 
Multiple tests of this stage shows that nothing changes. I notice that there is code to change the velocity, however in play mode it does nothing. Perhaps it is a problem on my Unity, otherwise, nothing is happening when fire2 is pressed.

## Code Style ##


### Code Style Review ###

#### Style Guide Infractions ####
There are no glaring infractions in my opinion.
#### Style Guide Exemplars ####
* [Correct placement of brackets](https://github.com/ensemble-ai/exercise-1-command-pattern-HoaiAnHo/blob/7533577f5d73d142bb078349720d27dd6fcc3d80/Captain/Assets/Scripts/NormalWorkerPirateCommand.cs#L28) - Put brackets after the if and else statement lines.
## Best Practices ##


### Best Practices Review ###

#### Best Practices Infractions ####
Not many comments to clarify code. Would have been good to put comments on your custom stage 4 CaptainDashCommand.cs to explain what it does for someone else reviewing your code.
#### Best Practices Exemplars ####
* [Use of comments to clarify code](https://github.com/ensemble-ai/exercise-1-command-pattern-HoaiAnHo/blob/7533577f5d73d142bb078349720d27dd6fcc3d80/Captain/Assets/Scripts/PirateController.cs#L32) - Good comment to explain how your motivate works.
