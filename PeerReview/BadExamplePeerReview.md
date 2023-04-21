# Code Review for Programming Exercise 1 #



## Solution Assessment ##

### Stage 1 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The captain is able to move to the right as intended and faces in the correct direction. The code to do so is similar to the code to make the character move left, but with the correct changes.

### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The pirates are able to work at the three different speeds. Velocity is added to the items dropped, which improves the look of the game. The scripts are well commented, making it easy to follow the logic.

### Stage 3 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justifaction ##### 
The captain is able to motivate the 3 pirates, when they are exhausted. The captain's motivation also results in a random pirate work duration/efficiency. Random.Range is used as a great way to randomize the work duration.  

### Stage 4 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justifaction ##### 
The custom command chosen for this stage was a jump. The captain is able to jump once while stationary or while moving. The comments explain the command well and the code ensures that the captain cannot infinitely jump. 

## Code Style ##

### Code Style Infractions ###

Overall the code follows the .NET style guide. The variable and class names follow the naming convention and comments use "//" instead "/\* \*/". The opening and closing brackets for if and else statements are on their own line, in following with the style guide.
Such as is done here: https://github.com/ensemble-ai/exercise-1-command-pattern-alecF2/blob/f02e20db8b6b2fd395da8396adb21a516474e744/Captain/Assets/Scripts/NormalWorkerPirateCommand.cs#L28
![image](https://user-images.githubusercontent.com/37753647/164865567-0893b457-e803-4976-a81e-e6e1ad99e93f.png)

## Best Practices ##

### Best Practices Review ###

The code is very organized and easy to follow, especially because of the informative, yet concise comments. There were no infractions to the Unity best practices that I noticed.
You use private variables, which is good practice.
https://github.com/ensemble-ai/exercise-1-command-pattern-alecF2/blob/f02e20db8b6b2fd395da8396adb21a516474e744/Captain/Assets/Scripts/NormalWorkerPirateCommand.cs#L7
![image](https://user-images.githubusercontent.com/37753647/164866006-7f3cc45a-ccac-4b7e-ae06-9f4d4803cc25.png)
I like that you put comments above lines of code to explain their function and that they are cosistent and concise.
https://github.com/ensemble-ai/exercise-1-command-pattern-alecF2/blob/f02e20db8b6b2fd395da8396adb21a516474e744/Captain/Assets/Scripts/NormalWorkerPirateCommand.cs#L34
![image](https://user-images.githubusercontent.com/37753647/164866073-7cde15d5-cb8d-498e-8b66-0b890bef436a.png)

