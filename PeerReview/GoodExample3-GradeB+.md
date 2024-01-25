# Code Review for Programming Exercise 1 #
# Feedback #

## Peer Reviewer Information ##
Reviewer Name: REDACTED

Reviewer Email Address: REDACTED

Reviewer Github: REDACTED

### Stage 1 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The captain moves right when the right arrow key is pressed, as expected. The sprite also flips to show that it is going right. The code logic follows the same format as MoveCharacterLeft.cs, with some changes to make it move right.

### Stage 2 ###

- [ ] Perfect
- [X] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The pirates perform the slow, normal, and fast working pirate commands perfectly. Logic is easy to follow in the scripts and the objects are launched out from the pirate at random x and y velocities, instead of just spawning under the pirate. This adds great visuals and shows the pirates are hard at work producing the items!

There is however one issue with the logic in how the time is kept for the pirates working. A random number is generated depending on the type of work (ie slow, normal, or fast) which is correct. Also, a timer is incremented by Time.deltaTime to keep track of the time since the last spawn (or before anything has spwaned, since the pirate started working), which is also correct. However, the rand value, which represents the total time the pirate will work, is only decremented when an item is spawned. The check from above is also seeing if rand > 0 to know if the pirate is exhausted. I believe this is incorrect logic since with this, the pirate may work over its alotted time. Here is an example:

Imagine it is the slow working pirate, and rand is 25. Let's suppose timer is incremented to 8, and then since timer is equal to the interval, an item is spawned and rand is decreased to 13. Then timer gets to 8 again (8 seconds later), and an item is spawned, and rand is decreased to 5. Here, no more items should be made since the rand is less than the interval. But with the logic implemented, timer is allowed to increase to 8 again, another item is spawned, and rand is decreased to -3, which is less than 0, and the pirate becomes exhausted. 

### Stage 3 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justifaction ##### 
The captain correctly motivates the pirates. Since the student implemented a payment system, the motivations only work once the pirates have been paid. The code in the PirateController.cs script shows that each pirate is given a random work type as asked for in the problem statement. These pirates correctly get these motivations and start to work again once they are motivated by the captain (and have been paid).

### Stage 4 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justifaction ##### 
The custom fire2 command involved paying the pirates for working. This involved keeping track of their wages to know if they have been paid enough, and collision detection between the captain and the coins and the pirates and the coins. It also involved modifying the booty variable to decrement the total booty when the captain paid his workers. I liked that the captain could not motivate them unless they were paid. I also like the visual queue of the star above their heads to know if they need to be paid or not. It was a smart way to make it not seem so bad that these pirates were working for nothing by making them get paid!

## Code Style ##

### Code Style Review ###
For the most part, the style guide from raywenderlich was followed correctly. There was correct variable naming in camelCase and class naming and method naming using PascalCase. There was one case where there weren't spaces between operations using math symbols.

#### Style Guide Exemplars ####
* [correct use of PascalCase for class naming](https://github.com/ensemble-ai/exercise-1-command-pattern-SaltMeister/blob/f3ded0164e97e5afaa1f014d2dd9d9087311ea0a/Captain/Assets/Scripts/SpawnMoney.cs#L10) - it is good practice to use PascalCase for classes and for methods
* [correct use of camelCase for variables](https://github.com/ensemble-ai/exercise-1-command-pattern-SaltMeister/blob/f3ded0164e97e5afaa1f014d2dd9d9087311ea0a/Captain/Assets/Scripts/SpawnMoney.cs#L19) - it is good practice to use camelCase for variables and parameters for methods

#### Style Guide Infractions ####
* [no space around * operator](https://github.com/ensemble-ai/exercise-1-command-pattern-SaltMeister/blob/f3ded0164e97e5afaa1f014d2dd9d9087311ea0a/Captain/Assets/Scripts/SpawnMoney.cs#L37) - having extra space around the * would make it more readable

## Best Practices ##

### Best Practices Review ###
Overall, there were really good practices in this student's work. The student added helpful comments and put them above what they were commenting on. Also, the student made some logic easier to follow by abstracting a method. There were a couple of practices that weren't so good as well. There was variable naming that could have been more specific, and there were times that certain variables were made public to be shared across different scripts.

#### Best Practices Exemplars ####
* [helpful commenting](https://github.com/ensemble-ai/exercise-1-command-pattern-SaltMeister/blob/f3ded0164e97e5afaa1f014d2dd9d9087311ea0a/Captain/Assets/Scripts/CaptainController.cs#L38) - easier to follow code logic and know what parts of code are doing when helpful comments are given
* [abstracting a method](https://github.com/ensemble-ai/exercise-1-command-pattern-SaltMeister/blob/f3ded0164e97e5afaa1f014d2dd9d9087311ea0a/Captain/Assets/Scripts/FastWorkerPirateCommand.cs#L53) - helps code flow and makes the logic easier to understand; it could also be used throughout the code base if similar values needed to be calculated

#### Best Practices Infractions ####
* [poor variable naming](https://github.com/ensemble-ai/exercise-1-command-pattern-SaltMeister/blob/f3ded0164e97e5afaa1f014d2dd9d9087311ea0a/Captain/Assets/Scripts/FastWorkerPirateCommand.cs#L11) - it's easier to follow certain values and code logic if variable names are more specific or meaningful. I think the name "rand" could have been changed to "randWorkDuration" for example, just to truly know what it is being used for



