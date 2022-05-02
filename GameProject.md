# Description of Game Project

In this project, you will be designing and creating a game in Unity in teams of 5. While you will be responsible for designing the overall direction of your game, you will be given the following constraints:
* Each team member will have a role and a sub-role.
* Each team member will be responsible for creating at least one gameplay system.
* Each team member will be responsible for describing their work in your team's design document. 
* All roles and sub-roles must be assigned across your team's members.
* Your game, assets, source code, and project files will be placed in a publicly-accessible GitHub repository.

# Grading

The project will be graded on a 100 point scale with the following weights:
* Main Role
  * 30 Implementation
  * 10 Documentation
* Sub-Role
  * 20 Implementation
  * 10 Documentation
* 30 Team score of completed game.

# Submission Information

Submissions will be taken from the team registration spreadsheet via your teams GitHub repository link. Your project code

Your repository should include the following .gitignore file in the root directory of the project: https://gitignore.io/api/osx,unity,linux,windows,vscode

# Team Member Roles

Each team member must take on one main role and one sub-role. You will create the gameplay systems or complete the design tasks for your roles as well as provide the requested per-role documentation. Each team member must document the gameplay systems and software design patterns they used for their portion of the project.

## Main Roles

The following are the main roles and their basic descriptions


### Producer

The producer coordinates the technical dependencies and basic team logistics. Responsibilities include but are not limited to creating a dependency chart for the significant development tasks for the game, coordinating team meetings, working with the other roles to integrate their work into the main project, deciding on the Git-based workflow (i.e. how everyone's work gets combined into release branches without breaking the project), and organizing the final presentation.

While this role has fewer direct programming responsibilities, it requires understanding all parts of the development process. When performed well, the producer multiplies the effort of the entire team, which results in a better game project.

### User Interface

In this role, you are responsible for the user interface elements of the game. This typically includes the contents of the heads up display or HUD. This traditionally comprises gameplay status information such as player character health, score, resources like magic points or gold,  and time-keepers. This is also responsible for the menu and credit screens. You are responsible for documenting the various UI elements you implement and how they interact with the changing state of the game.

### Movement/Physics

This role is responsible for implementing movement within your game. You will have the choice of managing movement by directly translating objects in your game or leveraging Unity's physics system. It is your task to establish and document the basic conventions of movement in your game world (e.g. how gravity works, friction coefficients, animation curve value conventions, etc.). While you are responsible for documentation and making sure all objects in the game observe your conventions, other team members can implement objects and conventions that use your conventions.

### Animation and Visuals

As the team's master of visuals, you are responsible for implementing the basic animation scripts used by objects in your game. You are also tasked with setting the visual style and are the primary person responsible for finding the art assets to use in your game. You will document the animation systems used, a guide to the visual style of your game, and to document the sources and licenses of the art assets used in your game. 

### Input

In this role, you will be responsible for managing the input methods for your game. You should design your game to be used with either keyboard and mouse or a game controller. If you would like to excel in this role, you can add additional input control schemes for mobile devices. You will document what the inputs are and how they affect each of the game modes (e.g. menu, main gameplay, inventory screens, credits, etc.) and how they interact with the game work and UI/HUD.

### Game Logic

In most projects, this will be the most complicated role as it is a point of integration for nearly all of the gameplay systems. Traditionally, most of the game logic is placed in a game manager singleton and is referenced as needed by other scripts. It is the job of your team's game logician to manage the various game states (i.e. current level, main menu, main gameplay mode) and data (i.e. time remaining, quest completion status, references to all active enemies and items).  You will document what game states and game data you managed and what design patterns you used to complete your task. Charts are a great way to visually explain how parts of your game logic interact with the other gameplay systems.

## Sub-Roles


### Cross-Platform

It is common practice for games to be available on various platforms. The default set of platforms is Windows PC, OS X, web, and a mobile or tablet of your choosing. The Cross-Platform sub role is responsible for ensuring your game exports and is playable on multiple platforms. Your team may propose an alternate set of platforms based on the specifics of your design and development choices. This sub role will work with the Input and User Interface roles to ensure the game is playable on all of the target platforms.

### Audio

You are responsible for defining the game's sound style, procuring audio assets, and implementing scripts for adding sound to your game. You will document the sound style, the sources/licenses for all audio assets, and the implementation of your audio system.

### Gameplay Testing

As the gameplay tester, you are responsible for having 10 non-team members playtest your game. You fill out the Observation and Playtester Comments form for each of your playtesters and describe the results in the design document (after you share the results with your tea, of course!). For each playtester, fill out an [Observations and Playetester Comments form](https://docs.google.com/document/d/1oW7AulzjpEocDmMikRL0S0PKxlRrOxsEEP7KB-nGg-A/edit?usp=sharing).

### Narrative Design

You are responsible for designing and embedding the story of your game into the gameplay experience. While your team may collective decide on the story, you will make it present in the game. You will document how the narrative is present in the game via assets, gameplay systems, and gameplay.

### Press Kit and Trailer

You are responsible for creating a press kit for your game that includes screenshots and a 1-minute trailer. You should document the choices you made in the press kit and the goals of your trailer in the design document.

### Game Feel

In this role, you are responsible for using what we learned in class about game feel to enhance your game's playability. You will document what you added to and how you tweaked your game to improve its game feel.


