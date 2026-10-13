# Description of Game Project

In this project, your team will design and create a game in Godot. You decide what to make, subject to the requirements below.

The basic rules:

- Each student takes one main role and one sub-role.
- Everyone must be the primary author of a substantial programming contribution. Asset placement, writing, and managing a task board do not satisfy this requirement by themselves.
- Your work has to connect to the team's work. Systems should be used in the game, and production tools should be used by your teammates on the game.
- Team members record their own contribution in the team's documentation.
- The game and Godot project live in a public GitHub repository. Include source and credits for outside assets, check redistribution rights, and don't commit secrets or private information.

You can have two Gameplay Systems Programmers, two Level and World Designers, or other repeated roles, as long as each person owns different work. Your chosen roles should suit your game. **Every team should have a Technical Producer**, who takes the lead on keeping the project integrated and releasable.

If a role doesn't describe the technical work your game needs, propose an equivalent when you submit your project plan.

## Development

In keeping with our conversations on iterative design, prototype early in the process. As a team, agree on how systems will exchange information, and merge working features into the main project regularly. Waiting until the last week is bad policy.

Change your plans when you need to. Cutting a feature is often the right decision. Keep a record of important design changes so the instruction team can understand your decisions. Use scenes, signals, Resources, autoloads, and design patterns when they're useful. 

## Team Responsibilities

Some work belongs to the entire team even if one student takes the lead:

- **A working game:** A fresh checkout should open in the documented Godot version and run without missing files or mysterious setup steps.
- **Integration:** Agree on interfaces and dependencies, review one another's changes, and fix problems that cross system boundaries.
- **Testing:** Have ten people who aren't on the team playtest the game. Use the [Observations and Playtester Comments form](https://docs.google.com/document/d/1oW7AulzjpEocDmMikRL0S0PKxlRrOxsEEP7KB-nGg-A/edit?usp=sharing) for each tester. Summarize what you learned and show at least one change made because of the results. Don't put testers' private information in the public repository.
- **A release:** Keep the repository usable throughout development. Before submission, test the actual build or project from a fresh checkout, not just the copy on someone's laptop.
- **A press kit and trailer:** Include a short description of the game, screenshots, and a **one-minute trailer** showing the real game. These are team deliverables, not somebody's sub-role. You can divide up the work however you like.

The Technical Producer coordinates the build and release, and a student taking User Experience leads the playtesting. Neither role excuses everyone else from helping.

# Grading

The project is worth **100 points**:

| Category | Points |
| --- | ---: |
| Main role: implementation | 40 |
| Main role: documentation | 10 |
| Sub-role: implementation | 15 |
| Sub-role: documentation | 5 |
| Completed team game | 30 |
| **Total** | **100** |

**Individual work (70 points):** I'll look at whether your work functions, how well it's programmed or executed, the difficulty of the problem, and how it fits into the team's game. Your main role needs to demonstrate programming competence. Your sub-role can involve code, design, testing, art, sound, or other production work. Documentation should make it possible to find and understand what you did; it doesn't have to be long.

**Completed game (30 points):** This is a shared team score. Is it playable, understandable, and reasonably stable? Are the major systems integrated? Did the team finish a sensible amount of work? The final game, README, playtesting results, and press materials should all be present. A simple, complete game can earn full marks. I'm not grading how many levels you made or whether it looks like a commercial release.

Your system is not finished if it only works in isolation. On the other hand, a great finished game doesn't automatically give everyone great individual scores.

## Individual Technical Record

Each student adds a short section to the team's design document. About a page is fine. Include:

1. **What you built.** Name your main role, sub-role, and main programming contribution.
2. **Where to find it.** Link a few relevant commits or pull requests and name the important scripts, scenes, or tools. Commit counts and lines of code are not grades.
3. **How it works.** A short explanation, diagram, or pseudocode. Include an engineering choice worth discussing.
4. **Where it connects.** Name another team member's system your work uses, changes, or supports. Explain the connection.
5. **What changed.** Describe a bug, test result, change in design, or integration problem and what you did about it.

Be prepared to demonstrate your work and answer a technical question about it in the final presentation or project review. Programming assistants are subject to the course policy. You're still responsible for understanding and testing what you submit.

# Project Plan and Submission

In your project plan, include a short description of the game and its main gameplay loop. Add a table showing each student's main role, sub-role, main technical contribution, and important dependencies. Name the Technical Producer and the person coordinating playtesting. This should help you discover missing responsibilities before you've spent weeks building the wrong things.

We'll use the GitHub repository link from the team registration spreadsheet. Have the final Godot project, code, documentation, and redistributable assets in that repository by the deadline.

Your `README.md` should explain the Godot version, how to run the game, its controls, known problems, credits and licenses, and where to find the design document. Identify the final commit or release to be graded and provide a build link if you have one. Also link the press kit (description and screenshots) and one-minute trailer. Please test the instructions on a fresh checkout.

# Team Member Roles

Each person chooses a main role and a sub-role. The lists below are options, not a checklist of jobs that must appear on every team. The deliverable tables are a guide to what we expect; adapt them to your game and be specific in the project plan about what you'll make.

## Main Roles

### Technical Producer

You keep the development process moving and the game in one piece. Work with the team on milestones, dependencies, code integration, and Git conventions. You're also responsible for coordinating builds, exports, and the final release.

This is a technical job, not just meeting notes and a Trello board. Implement something the team actually uses: build or export automation, a test or validation tool, a debugging utility, an editor extension, a tool to check assets, or another appropriate system. Keep the workflow simple enough that your teammates will use it. You coordinate the release; you don't have to fix every other student's merge conflict.

### User Interface and Input

You handle controls and the parts of the game through which players give commands and read information: menus, HUDs, settings, inventory screens, dialogue controls, and so forth.

Think about changes in context. The same button may mean different things in a menu, during play, or while interacting with an object. Make the UI read actual game state rather than displaying placeholder numbers.

### Movement and Interaction Systems

You handle character or object movement and the way things physically or spatially interact. Depending on the game, this could involve a platformer controller, top-down movement, steering, a camera-relative control scheme, dragging objects, or grid-based movement. It doesn't have to mean rigid-body physics.

Establish useful conventions for speeds, collision behavior, timing, and controls. Give other programmers something dependable to build on. A good movement system has as much to do with how it *feels* as whether the math works.

### Gameplay Systems Programmer

You implement the rules and mechanics that make the game work: combat, puzzles, inventories, abilities, crafting, dialogue mechanics, turn handling, resources, win/loss conditions, or any other substantial system. This is a broad role, and **more than one person can take it**. Divide up the systems clearly.

Don't pile everything into one `GameManager`. Figure out who owns the state, which systems can change it, and how other code learns about those changes. The architecture can be simple; it should at least be understandable.

### Level and World Designer

You make the places and situations in which the game is played. Think about layout, pacing, encounters, obstacles, and how players discover the mechanics. Maps and diagrams will help you explain your design.

This is still a programming main role. Write encounter logic, puzzle systems, interactive environments, level progression, reusable triggers, or other code that supports the levels. Dropping assets into a scene isn't enough. Your level should also make good use of systems other students are writing.

### Technical Artist

You make the visual and animated parts of the game work through code and Godot's runtime systems. This combines animation, effects, and technical art. You might work with `AnimationPlayer`, `AnimationTree`, shaders, procedural effects, particles, materials, rigs, sprite systems, or tools for preparing and importing art.

The programming matters. For example, build an animation controller driven by game state, a shader that communicates damage or danger, a configurable effect system, or a tool that turns artists' assets into something the game can use. Choosing sprites and tuning a few editor settings won't be sufficient on their own. Work with the game's art direction, and record where outside assets came from.

### AI and Behavior Designer

You create behavior for enemies, allies, or other agents. Finite-state machines, behavior trees, decision trees, utility systems, navigation, planning, and simpler custom approaches are all fair game. Use whatever solves the problem.

Coordinate with the other programmers so the agents can sense relevant state, move or act, and communicate what they're doing to the player. Clever AI isn't especially useful if the player can't tell it's there.

### Procedural Content Designer

You create an algorithm that produces something the game needs: levels, puzzles, encounters, enemy variations, layouts, animations, or other content. Describe its inputs, constraints, and the range of results it can produce.

Use the generator in the game or in the team's actual content-building process. Test whether the output works, not merely whether it's different each time. A generator that creates fifty unplayable levels is not much help.

### Main Role Deliverables

| Main role | Design (🎮) | Technical (⚙️) | Documentation (📄) | Integration (🔗) |
| --- | --- | --- | --- | --- |
| Technical Producer | Milestones, dependencies, release plan | Build/test/export automation or another team tool | Workflow and tool instructions, important decisions | Working releases and a usable repository |
| UI and Input | Controls, HUD, menu flow | Input actions, UI scripts and scenes | UI map and controls | UI uses actual game state and actions |
| Movement and Interaction Systems | Movement and interaction rules | Controllers, collision, movement or camera systems | Parameters, interaction or motion diagram | Other game systems use the movement/interaction code |
| Gameplay Systems Programmer | Rules, state, system behavior | Gameplay mechanics and rule code | State/data flow and design choices | Mechanics connected to other systems |
| Level and World Designer | Level maps, encounters, pacing | Scripted levels, puzzles, triggers or progression | Annotated maps and flow | Levels use the game's mechanics |
| Technical Artist | Animation and visual feedback goals | Animation controllers, shaders, effects or art tools | System overview, asset credits/licenses | Visuals and animation respond to gameplay |
| AI and Behavior Designer | Agent behaviors and difficulty | Decision and navigation code | Behavior diagram and tuning notes | Agents interact with the game world |
| Procedural Content Designer | Generation rules and constraints | Generation and validation algorithms | Algorithm and example outputs | Generated content used by the game or team |

## Sub-Roles

### Audio

Choose or create the game's sound and music, then get them working with play. Which actions need feedback? What should sound different as the game state changes? Keep track of outside assets and licenses. If the game needs an audio manager or other code, you can build that too.

### User Experience

Lead the team's playtesting and help the game make sense to someone who didn't build it. Plan useful test scenarios, watch what players actually do, and note where they get stuck or misunderstand the game. Coordinate the team's ten outside playtests and the required observation forms.

Bring the findings back to the team and help choose what to fix. It's fine if the result is less glamorous than adding a feature: a better tutorial, clearer controls, or a change to a confusing mechanic. User Experience is about evidence from players, not just giving opinions about the game.

### Narrative Design

Make story and characterization part of play, whether through dialogue, environmental details, events, or systems that remember player choices. Work with the other programmers so narrative changes happen in the game, not just in a separate story document.

### Game Feel

Put the class material on game feel to work. Tune controls, motion, timing, camera behavior, hit reactions, animation, sound, or feedback. Explain what you changed and why. Before-and-after clips or concrete player observations are more useful than saying it feels better.

### Accessibility Engineering

Implement changes that make the game usable by more players. Depending on the game, this could include remappable controls, text sizing, subtitles, alternatives to color-only cues, input assistance, or options for reducing visual effects. Choose features that address actual needs and test that they work.

This is distinct from User Experience: UX gathers evidence about players' experience; this role takes responsibility for implementing accessibility features.

### Performance Optimization

Use Godot's profiler, debugger, and monitors before deciding what needs optimizing. Fix something that matters and measure it under comparable conditions. If the game already runs well, build a repeatable benchmark or stress test and find its limits. Don't invent a performance problem just to claim this role.

### Art Direction and Gameplay Communication

Help decide how the game's visual language communicates its world, characters, mechanics, and state. That includes palettes, typography, iconography, shapes, visual metaphors, and how one screen or object relates to another. A short style guide can help, but it isn't the main deliverable.

Work with the UI programmer, Technical Artist, and other team members to carry those ideas into functioning systems. For example, establish how health, danger, factions, abilities, or interactable objects are represented; make sure the right art, animations, icons, or state cues appear when the game calls for them. The point is not just a consistent look. It's making the game's art *say something useful* while it runs.

### Player Onboarding and Tutorial Design

Teach the game without requiring a lecture from its developers. Design and implement prompts, hints, tutorials, or early encounters that introduce important mechanics. Watch new players try them, then change what isn't working. Coordinate with User Experience if your team has someone in that role.

### Analytics and Instrumentation

Add logging or other instrumentation to answer a question about your game: Where do players die? Which choices do they make? How long does a level take? Gather data from play, analyze it, and bring back a result the team can use. Record what changed, or what you recommend changing, because of the findings.

### Sub-role Deliverables

| Sub-role | Design (🎮) | Technical (⚙️) | Documentation (📄) | Integration (🔗) |
| --- | --- | --- | --- | --- |
| Audio | Sound and music plan | Audio triggers, playback and any supporting code | Audio overview, asset credits/licenses | Sound responds to game events |
| User Experience | Playtest plan and questions | Test builds, issue tracking, usability changes with team | Ten observation forms, findings and a change made | Findings inform the finished game |
| Narrative Design | Story and narrative flow | Dialogue, events or state triggers as needed | How the narrative works in play | Narrative responds to player action |
| Game Feel | Timing and feedback goals | Tuning, motion, effects and feedback changes | Before/after evidence and explanation | Changes visible or felt in gameplay |
| Accessibility Engineering | Accessibility goals | Working accessibility features | What changed and how it was tested | Options and cues function in the game |
| Performance Optimization | Performance problem or benchmark | Profiling, fixes or a repeatable stress test | Comparable measurements and findings | Final game performance verified |
| Art Direction and Gameplay Communication | Visual language tied to meaning and rules | Applied assets, states, cues and visual-system coordination | Brief visual guide and examples | Game state is communicated consistently |
| Player Onboarding and Tutorial Design | Learning sequence and prompts | Tutorial triggers, hints or encounters | Onboarding flow and observation notes | New players can learn the controls and goals |
| Analytics and Instrumentation | Questions and measures | Logging and analysis tools | Results and proposed or completed changes | Play data informs design decisions |
