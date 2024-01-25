# Code Review for Programming Exercise 1 #

# Feedback #

What a wonderfully done Code Review. You did an excellent job at making the code review a personal journey as well as an informative one. I also enjoyed how you gave examples of what you liked. Very genuine. Thank you :) (also look at the examples for properly linking.)
---

## Solution Assessment ##

### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The captain moves to the right as required. The code needed for this was pretty much the same as the code in the move left script with two minor tweaks that were done in the move right script.

### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The working pirates perform the slow working, normal working, and fast working command just fine. Code and logic is easy to follow, and spawned objects are near the pirate instead of on. The working scripts work for all stages of the game itself. 

### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The captain motivates the other pirate correctly. The code itself is easy to follow and self explanatory. A random number between 1 and 3 is generated and from there you decide which pirate command to use.

### Stage 4 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The custom command that was made was a jump command for the captain which honestly was done very well. The captain jumps as expected and the jump animation is also used. One thing I would add is to make the captain jump a bit higher because at first I wasn't so sure what the second command was.

## Code Style ##

### Code Style Infractures ###

For the most part, the coding conventions were followed correctly. The comments were on a separate line from the code and there was a space between the comment command ('//') and the actual comment. All the first letters of the comment were capitalized, however most of the comments did not end with a period. The comments still got the general point accross though. The following code snippets are instances where the comments did not end with a period:

https://github.com/ensemble-ai/exercise1-commandpattern-alnol/blob/cbab0b1f33beeddf13203553b2a2de55ef7b3e48/Captain/Assets/Scripts/PirateController.cs#L12

https://github.com/ensemble-ai/exercise1-commandpattern-alnol/blob/cbab0b1f33beeddf13203553b2a2de55ef7b3e48/Captain/Assets/Scripts/PirateController.cs#L15

https://github.com/ensemble-ai/exercise1-commandpattern-alnol/blob/cbab0b1f33beeddf13203553b2a2de55ef7b3e48/Captain/Assets/Scripts/PirateController.cs#L31

https://github.com/ensemble-ai/exercise1-commandpattern-alnol/blob/cbab0b1f33beeddf13203553b2a2de55ef7b3e48/Captain/Assets/Scripts/FastWorkerPirateCommand.cs#L11 - the rest of the comments on this file did not end with a period.

https://github.com/ensemble-ai/exercise1-commandpattern-alnol/blob/cbab0b1f33beeddf13203553b2a2de55ef7b3e48/Captain/Assets/Scripts/CaptainJumpCommand.cs#L38

## Best Practices ##

### Best Practice observations ###

All classes and scripts were readable and easy to go over. I liked how there was comments that described what specific variables did even though the name of the variable was clear. I also like that the brackets were always on their own line for functions, as well as if-else statements.

For example: https://github.com/ensemble-ai/exercise1-commandpattern-alnol/blob/cbab0b1f33beeddf13203553b2a2de55ef7b3e48/Captain/Assets/Scripts/FastWorkerPirateCommand.cs#L11-L18

https://github.com/ensemble-ai/exercise1-commandpattern-alnol/blob/cbab0b1f33beeddf13203553b2a2de55ef7b3e48/Captain/Assets/Scripts/FastWorkerPirateCommand.cs#L59-L67
