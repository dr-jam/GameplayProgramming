# Description of Game Project

In this project, you will be designing and creating a game in Unity in teams of 5. While you will be responsible for designing the overall direction of your game, you will be given the following constraints:
* Each team member will have a role and a sub-role.
* Each team member will be responsible for creating at least one gameplay system.
* Each team member will be responsible for describing their work in your team's design document. 
* All roles and sub-roles must be assigned across your team's members.
* Your game, assets, source code, and project files will be placed in a publicly-accessible GitHub repository.

# Grading

The project will be graded on a 100-point scale with the following weights:
* Main Role
  * 30 Implementation
  * 10 Documentation
* Sub-Role
  * 20 Implementation
  * 10 Documentation
* 30 Team score of completed game.

# Submission Information

Submissions will be taken from the team registration spreadsheet via your team's GitHub repository link. Your project code

# Team Member Roles

Each team member must take on one main role and one sub-role. You will create the gameplay systems or complete the design tasks for your roles as well as provide the requested per-role documentation. Each team member must document the gameplay systems and software design patterns they used for their portion of the project.

## Main Roles

The following are the main roles and their basic descriptions.

### Producer

The producer coordinates the technical dependencies and basic team logistics. Responsibilities include, but are not limited to, creating a dependency chart for the significant development tasks for the game, coordinating team meetings, working with the other roles to integrate their work into the main project, deciding on the Git-based workflow (i.e., how everyone's work gets combined into release branches without breaking the project), and organizing the final presentation.

While this role has fewer direct programming responsibilities, it requires understanding all parts of the development process. When performed well, the producer amplifies the team's effort, leading to a better game project.





### User Interface and Input

In this role, you are responsible for the user interface elements of the game. This typically includes the contents of the heads-up display or HUD. This traditionally comprises gameplay status information such as player character health, score, resources like magic points or gold,  and timekeepers. This is also responsible for the menu and credit screens. You will be responsible for managing the input methods for your game. You should design your game to be used with either keyboard and mouse or a game controller. If you would like to excel in this role, you can add additional input control schemes for mobile devices. You will document the inputs and how they affect each game mode (e.g., menu, main gameplay, inventory screens, credits, etc.) and how they interact with the game work and UI/HUD. You are responsible for documenting the various UI elements you implement and how they interact with the changing state of the game.

### Movement/Physics

This role is responsible for implementing movement within your game. You can manage movement by directly translating objects in your game or leveraging Unity's physics system. It is your task to establish and document the basic movement conventions in your game world (e.g., how gravity works, friction coefficients, animation curve value conventions, etc.). While you are responsible for documentation and ensuring all objects in the game observe your conventions, other team members can implement objects and conventions that use your conventions.

### Animation and Visuals

As the team's master of visuals, you are responsible for implementing the basic animation scripts used by objects in your game. You are also tasked with setting the visual style and are the primary person responsible for finding the art assets to use in your game. You will document the animation systems used, a guide to the visual style of your game, and to document the sources and licenses of the art assets used in your game. 


### Game Logic

This will be the most complicated role in most projects as it is a point of integration for nearly all gameplay systems. Traditionally, most of the game logic is placed in a game manager singleton and is referenced as needed by other scripts. It is the job of your team's game logician to manage the various game states (i.e., current level, main menu, main gameplay mode) and data (i.e., time remaining, quest completion status, references to all active enemies and items).  You will document the game states and game data you managed and the design patterns you used to complete your task. Charts are a great way to visually explain how parts of your game logic interact with the other gameplay systems.


### Systems and Tools Engineer

As the Systems and Tools Engineer, you are responsible for developing reusable systems, custom Unity tools, and workflow scripts that improve your team’s development efficiency. This includes creating procedural content generators, editor extensions, data serialization pipelines, debugging overlays, or asset-management tools. You will document the tools and systems you create, their purpose, and how they are used by other team members. When performed well, this role amplifies the productivity of the entire team, ensuring that technical systems are modular, efficient, and maintainable.

### Level and World Designer

As the Level and World Designer, you are responsible for defining the spatial layout and player flow of your game. This includes building levels, placing objects and obstacles, shaping the rhythm of exploration and challenge, and incorporating environmental storytelling. You will use the conventions established by the other roles—movement physics, visual style, and game logic—to create coherent gameplay spaces. Your documentation should include annotated maps, flow diagrams, and a discussion of how level design supports player experience, pacing, and difficulty progression.

### Technical Artist

As the Technical Artist, you are responsible for bridging art and engineering. You will ensure that all visual assets integrate smoothly into the project while maintaining real-time performance. This includes implementing shaders, materials, lighting setups, and post-processing effects, as well as optimizing textures and meshes. You may also develop custom visual tools to support other roles. You will document your visual pipeline, performance optimizations, and the aesthetic principles guiding your work. When done effectively, this role connects artistic direction with technical stability.

### AI and Behavior Designer

As the AI and Behavior Designer, you are responsible for creating the artificial intelligence systems that give life to the game’s world. You will design and implement the logic for enemies, allies, or other autonomous agents using techniques such as finite-state machines, behavior trees, or utility systems. You will collaborate with the Game Logic and Animation roles to integrate these behaviors into the larger gameplay structure. Documentation should include diagrams or pseudocode showing the architecture of your AI systems and explanations of how they shape player experience and game difficulty.

### Data and Analytics Engineer

As the Data and Analytics Engineer, you are responsible for instrumenting your game to collect and analyze gameplay data. This includes building systems that record metrics such as completion times, player deaths, resource usage, and score distributions. You will analyze this data to identify balance issues or design insights that can improve the gameplay experience. You will document your data collection methods, analytical results, and how those results informed subsequent design decisions. This role supports iterative development through evidence-based refinement and data-driven insight.

### Procedural Content Design

You are responsible for implementing or prototyping a system that procedurally generates some element of your game—such as levels, enemies, puzzles, or visual patterns. You will document the algorithms or randomization methods used, describe how the generated content varies across playthroughs, and show how it integrates into the existing game systems. This role highlights creative computation and demonstrates how generative design can expand replayability and variety.

### Main Role Deliverables

| **Main Role**                   | **Design Deliverables (🎮)**                      | **Technical Deliverables (⚙️)**                      | **Documentation Deliverables (📄)**                    | **Integration Deliverables (🔗)**                          |
| ------------------------------- | ------------------------------------------------- | ---------------------------------------------------- | ------------------------------------------------------ | ---------------------------------------------------------- |
| **Producer**                    | Project roadmap and milestone plan                | Git workflow setup, build pipeline                   | Dependency chart, meeting summaries, workflow guide    | Final presentation coordination, release build integration |
| **UI and Input**                | HUD, menus, control scheme layouts                | Input scripts, UI prefabs/scenes, interface code     | UI map, input mapping chart, interaction documentation | Integrated UI connected to Game Logic systems              |
| **Movement / Physics**          | Movement conventions, physics feel tuning         | Physics scripts, rigidbody configurations            | Motion system flowchart, parameter tables              | Verified consistent behavior across game objects           |
| **Animation and Visuals**       | Visual style guide, animation plan                | Animator controllers, shader/material setups         | Asset licensing list, system overview                  | Integrated visuals aligned with movement and game states   |
| **Game Logic**                  | Game flow and rule definitions                    | Game manager or modular logic scripts                | System diagrams, design pattern rationale              | Coordinated interaction among all gameplay systems         |
| **Systems and Tools Engineer**  | Workflow enhancements, reusable templates         | Editor extensions, utility scripts, automation tools | Tool documentation and usage instructions              | Tools implemented and used by other team members           |
| **Level and World Designer**    | Level layouts, pacing, worldbuilding plan         | Scene construction, prefab/scene arrangement         | Annotated maps, level flow diagrams                    | Levels integrated with physics, logic, and visuals         |
| **Technical Artist**            | Visual cohesion and fidelity goals                | Lighting, materials, post-processing effects         | Pipeline documentation, optimization records           | Performance testing in integrated builds                   |
| **AI and Behavior Designer**    | Enemy/NPC design and behavioral tuning            | AI logic (FSMs, behavior trees, utility systems)     | Architecture diagrams, tuning tables                   | Verified AI behavior integrated into game loop             |
| **Data and Analytics Engineer** | Gameplay balance insights, metric definitions     | Logging and data collection scripts                  | Data tables, analysis report                           | Feedback applied to improve later builds                   |
| **Procedural Content Design**   | Procedural variation plan (levels, puzzles, etc.) | Generation algorithms and randomization systems      | Algorithm documentation, system diagrams               | Integration of procedural content into main game loop      |


## Sub-Roles



### Audio

You are responsible for defining the game's sound style, procuring audio assets, and implementing scripts for adding sound to your game. Document the intentional use of sound and how it defines and compliments the rest of the game. You will document the sound style, the sources/licenses for all audio assets, and the implementation of your audio system.

### Gameplay Testing

As the gameplay tester, you must have ten non-team members playtest your game. You fill out the Observation and Playtester Comments form for each playtester and describe the results in the design document (after you share the results with your team, of course!). For each playtester, fill out an [Observations and Playtester Comments form](https://docs.google.com/document/d/1oW7AulzjpEocDmMikRL0S0PKxlRrOxsEEP7KB-nGg-A/edit?usp=sharing). Provide a meaningful analysis of the results.

### Narrative Design

You are responsible for designing and embedding your game's story into the gameplay experience. While your team may collectively decide on the story, you will make it present in the game. You will document how the narrative is present in the game via assets, gameplay systems, and gameplay.

### Press Kit and Trailer

You are responsible for creating a press kit for your game that includes screenshots and a 1-minute trailer. You should document the choices you made in the press kit and the goals of your trailer in the design document.

### Game Feel

In this role, you are responsible for using what we learned in class about game feel to ensure your game's playability. You will document what you added to and how you tweaked your game to improve its game feel.

### Accessibility and Usability Design

You are responsible for ensuring that your game can be played and understood by the widest possible audience. This includes evaluating input schemes, color contrast, text readability, and overall user comprehension. You will document the accessibility features implemented in your game—such as scalable UI elements, clear tutorials, or color-blind–safe palettes—and describe how they improve usability. Your report should include before-and-after examples or screenshots showing design changes made to support a broader range of players.

### Performance Optimization

You are responsible for ensuring that your game runs smoothly and efficiently. You will analyze frame rates, memory usage, and object counts across builds, and identify sources of performance bottlenecks. You will document the profiling tools you used (such as Unity Profiler or Frame Debugger), the optimizations you implemented, and the resulting performance improvements. This subrole emphasizes engineering discipline and teaches how to balance artistic fidelity with technical constraints.

### Visual Cohesion and Style Guide

You are responsible for maintaining a consistent visual identity across your game. You will define the game’s palette, typography, and visual tone, and ensure that all visual elements—from menus to levels—adhere to this cohesive style. You will create a short visual style guide that references your sources and explains your artistic decisions. This subrole supports the Animation and Visuals main role by ensuring that all assets, regardless of origin, appear unified in presentation.

### Build and Release Management

You are responsible for creating and maintaining stable builds of your game throughout development. This includes managing the version control workflow, resolving merge conflicts, and preparing playable builds for milestones and the final presentation. You will document the release process—how assets and scripts are integrated, how branches are merged, and how the final build is packaged for distribution. This subrole ensures that the team’s work is consistently deliverable and technically stable.

### Player Onboarding and Tutorial Design

You are responsible for helping new players understand how to play your game effectively. This includes designing and implementing tutorial sequences, hint systems, or onboarding UI elements that teach core mechanics in an intuitive way. You will document your tutorial structure and describe how it gradually introduces game systems to players. Screenshots or diagrams showing the player learning curve will strengthen your report. This subrole emphasizes clarity, communication, and player empathy.
