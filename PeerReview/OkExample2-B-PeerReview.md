# Code Review for Programming Exercise 1 #
## Description ##

Name: REDACTED 

Email: REDACTED

Github: REDACTED  

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
Stage one works perfectly as expected. Nothing wrong here. When spamming left and right there seems to be no issue.
Very similar to the moving right which is exactly what was supposed to be done. 

### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
Although the stage 2 does work perfectly as expected. There seems to be some readability issues. A lot of the code needs to be cleaned up properly. 
There seems to be some debug information and other commented code that seems to be misplaced. 
For example in 'SlowWorkerPirateCommand.cs', lines 53-60 should be cleaned up as well line 42, line 31, ...etc. 
Some of these commented code makes readability slightly difficult. 
Makes it hard to read when there are some bits of random code scattered everywhere. Other than that, it seems to be fine. 

### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justifaction ##### 
The motivate function works exactly as intended. Only suggest could be that unity's range function can be done with integers as well as float values.
No need to use floats if integers could be used. However, it works exactly as intended and there is no issues. 

### Stage 4 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justifaction ##### 
Really cool implementation of the double jump. I would say it is a perfect implementation. 
Only issue I have with it is most of the code is hard to read. They are using hard coded values instead of turning them into constants which allow for better readability. Additionally, comments are scatter around 

## Code Style ##

### Code Style Review ###

Overall, the coding style felt in consistent to an extent. It feels as though the organization of the code seemed too rushed. Although the main parts were implemented well, the readability of the code could use more work as things were not as consistent. 

#### Style Guide Infractions ####

- In consistent styles of brackets. Some code doesn't fit the C# coding conventions layed out in class. 

Examples: 

[CaptainController.cs](https://github.com/ensemble-ai/exercise-1-command-pattern-Tingwei1021/blob/08c312823885dd4545dce88f556c0f81864bb2be/Captain/Assets/Scripts/CaptainController.cs#L50)

[SlowWorkerPriate.cs](https://github.com/ensemble-ai/exercise-1-command-pattern-Tingwei1021/blob/08c312823885dd4545dce88f556c0f81864bb2be/Captain/Assets/Scripts/SlowWorkerPirateCommand.cs#L30)

- Using of 'temp' as a method of storing variables instead of naming them properly 

Examples: 

[PirateController.cs](https://github.com/ensemble-ai/exercise-1-command-pattern-Tingwei1021/blob/08c312823885dd4545dce88f556c0f81864bb2be/Captain/Assets/Scripts/PirateController.cs#L33)

[MoveCharacterJump.cs](https://github.com/ensemble-ai/exercise-1-command-pattern-Tingwei1021/blob/08c312823885dd4545dce88f556c0f81864bb2be/Captain/Assets/Scripts/MoveCharacterJump.cs#L19)

- Inconsistent naming adhering to the camel casing for private variables 

Examples: 

[CaptainController.cs](https://github.com/ensemble-ai/exercise-1-command-pattern-Tingwei1021/blob/08c312823885dd4545dce88f556c0f81864bb2be/Captain/Assets/Scripts/CaptainController.cs#L53)

#### Style Guide Exemplars ####

- Really great documentation of what is expected and how code interacts with everything 

Examples: 

[CaptainController.cs](https://github.com/ensemble-ai/exercise-1-command-pattern-Tingwei1021/blob/08c312823885dd4545dce88f556c0f81864bb2be/Captain/Assets/Scripts/CaptainController.cs#L55)

[MoveCharacterJump.cs](https://github.com/ensemble-ai/exercise-1-command-pattern-Tingwei1021/blob/08c312823885dd4545dce88f556c0f81864bb2be/Captain/Assets/Scripts/MoveCharacterJump.cs#L18)

## Best Practices ##

### Best Practices Review ###

Overall, there were some decent practices being used here. 
Although it can be decently followed, the readability always seems to be an issue as it sometimes gets hard to understand the core mechanics. 
Additionally random comments and statements are scattered around from the debugging process. 

#### Best Practices Infractions ####

- Use of hard coded values instead making them constants for readability. Harder to keep track of these values if not assigning them constant names. 

Examples: 

[CaptainController.cs](https://github.com/ensemble-ai/exercise-1-command-pattern-Tingwei1021/blob/08c312823885dd4545dce88f556c0f81864bb2be/Captain/Assets/Scripts/CaptainController.cs#L50)

- Random Debug logs and code that should be removed from the debugging process 

Examples:

[CaptainController.cs](https://github.com/ensemble-ai/exercise-1-command-pattern-Tingwei1021/blob/08c312823885dd4545dce88f556c0f81864bb2be/Captain/Assets/Scripts/CaptainController.cs#L47)

[SlowWorkerPirateCommand.cs](https://github.com/ensemble-ai/exercise-1-command-pattern-Tingwei1021/blob/08c312823885dd4545dce88f556c0f81864bb2be/Captain/Assets/Scripts/SlowWorkerPirateCommand.cs#L53-L58)

#### Best Practices Exemplars ####

- Not really any good practices other than most of the code was easy to follow. Just hard to read overall. 
