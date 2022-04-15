# Code Review for Programming Exercise 1 #

Reviewer: REDACTED   
Reviewer username: REDACTED  

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment three: Pikmini. In order to to do so, we will be giving you a rubric to give feedback on. For the feedback, please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to review the code and project files that were given out by the instructor.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.

## Due Date and Submission Information ##
This code review is due on:
Wednesday, April 21st by 11:59 PM

A successful submission should consist of a copy of this markdown document template that is modified with your peer-review. The file name should be the same as it is in the template: PeerReview-Exercise1.md. You also need to include your name and email address in the Peer-reviewer Information section below. This review document should be placed into the base folder of the repo you are reviewing in the master branch. This branch should be on the origin of the repository you are reviewing.

If you are in the rare situation where there are two peer-reviewers on a single repository, append your UC Davis user name before the extension of your review file. An example: PeerReview-Exercise1-username.md. Both reviewers should submit their reviews in the master branch.  

## Solution Assessment ##

### Stage 1 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The pirate moves right and left with the same animation and facing the correct direction which is exactly the task. The code for left and right movement are almost identical besides direction which looks good!

### Stage 2 ###

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The working pirates spawn correctly for the 3 intervals of work (slow, normal and fast). However, it seems that the pirates keep working after they spawn their last item instead of going straight to the exhausted state. This could be easily fixed by adding in an Exhausted bool to each of the worker scripts. Other than that, the code logic is clear and everything is working. 

### Stage 3 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justifaction ##### 
The captain motivates correctly and a random number is generated in order to choose between the three levels of work. The code logic could be simplified by using a different method of the Random class, but this implementation works just as well. 

### Stage 4 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justifaction ##### 
The custom command chosen for this stage was a jump. The pirate is able to jump while moving and while stationary. They created a new script for the jump command and it is much like the scripts that move the character left and right whereas in this instance, the velocity is in the upwards direction. 

## Code Style ##

### Code Style Infractions ###

While there is not any inherent infractions seen throughout the code, I did notice they put their comments after the chunk of code they are referring to; this makes it a bit hard to follow becuase normally the comment would be above the code it is referring to. 
An example can be found here:
https://github.com/ensemble-ai/exercise-1-command-pattern-raphel27/blob/215ebfd885ac2b03e2a8843e926a9b09c8bcc69a/Captain/Assets/Scripts/NormalWorkerPirateCommand.cs#L15

## Best Practices ##

### Best Practices Review ###

The code is very neat and organized. They followed .NET guidelines by putting the {} below the statement. I did notice there were 2 lines in the code that could have been combined into one: 
https://github.com/ensemble-ai/exercise-1-command-pattern-raphel27/blob/215ebfd885ac2b03e2a8843e926a9b09c8bcc69a/Captain/Assets/Scripts/NormalWorkerPirateCommand.cs#L37
https://github.com/ensemble-ai/exercise-1-command-pattern-raphel27/blob/215ebfd885ac2b03e2a8843e926a9b09c8bcc69a/Captain/Assets/Scripts/NormalWorkerPirateCommand.cs#L39

Other than that, the code is very clear and follows all the guidelines in the style guide provided to us. 
