# ECS189L - Gameplay Programming

## CRN for FALL 2019
62871

# Syllabus
## Basic Information

### Instructor
Dr. Joshua A. McCoy, Assistant Professor  
Computer Science and Cinema and Digital Media Departments  
Email: jamccoy at ucdavis dot edu  
Office: 3033 Kemper Hall  
Office Hours: Thursdays at 1:45 to 3:00 PM and by appointment  
http://joshmccoy.com  
https://faculty.engineering.ucdavis.edu/mccoy/  
https://www.twitter.com/deftjams  

### TA
Zee Chen  
Email: zeychen at ucdavis dot edu  
Office: 53 Kemper Hall for both OH slots
Office hours: Monday 11-12 PM and Thursday 2-3 PM   

### Course
Lecture Meeting Time: Tuesdays and Thursdays at 12:10 to 1:30 PM in Hoagland room 168  
Lab Meeting Time: Mondays at 5:10 - 6:00 PM in Wellman room 212  
Final Examination Period: Tuesday, December 10th at 1:00 to 3:00 PM  

## Course Description

This course is about the design and development of nuanced and highly-contextual gameplay systems built on the foundation of traditional game engines. Technical game development has many facets including graphics engines, sound engines, networking, and animation system. Many of these facets are now well-established and are provided for in modern game engines. The focus of this course is on the remaining areas that are difficult to abstract and engineer into game engines as they are depend on the genre or details of a specific game design.

## Materials

Unity version 2019.3.0b5. Download it directly [here](https://unity3d.com/unity/beta/2019.3.0b5) or get it with Unity Hub putting the following URI in your browser:  
unityhub://2019.3.0b5/13eef430e0c9  
You can download Unity Hub [here](https://unity3d.com/get-unity/download).

## Grading and Assessment

* [35] Group Game Project
* [40] Exercises
* [15] Quizzes
* [10] Participation/Attendance

### Grade Scale

Grade | Point Threshold
------ | -------
A  | 95
A- | 90
B+ | 87
B  | 84
B- | 80
C+ | 77
C  | 74
C- | 70
D+ | 67
D  | 64
D- | 60
F  | 0

### Exercises

The programming exercises consist of projects in Unity in which you will have to implement significant game systems or capabilities. These exercises are to be completed individually and will be worth 10 points each. Each will have two components which are described below with the amount of grade points they are worth:
1. [7] The individual programming assignment.
2. [3] Peer-reviewing the work of another pseudo-randomly assigned student.

*Individual Programming Assignment* - The exercise repositories complete with project descriptions and work specific ations will distributed via GitHub Classroom. You will be responsible for completing the excercise objectives, code quality, and following the best practices as described in class. Final submissions will be made via GitHub classroom.

*Peer-review* - For each programming excercise, each student will perform a peer review for another student's work. The reviewing student will be given access to the repository of another student's submmission for review. The peer-reviewer will make a new branch in the repository named "review" and will be responsible for a code review based on C# style guides, an assessment of how well the submission achieved the objectives of the assignment, and notes for improvement.

### Group Game Project

You will design and develop your own game given a set of themes and constraints in teams of 5. Each team embmer will have a main role and a sub-role on the game.

### Quizzes

Light quizzes will be given during discussion sections. Their contents will be based on recent lectures and readings.

### Participation and Attedance

Students are required to attend and participate in class, labs, and their team meetings. Attendance will be taken during lectures and discussion sections.

## Schedule

Week | Topic | Reading
----- | ----- | -----
1 | Overview of the course, game engines, anatomy of game development, command pattern. | Salen and Zimmermen ch. 4 & 5
2 | Unity structures, Code standards, best practices, style guides, camera systems, lerp. | Class documentation
3 | Gameplay mechanics, Game Events and the Observer Pattern.Data-driven game systems.| [Defining Game Mechanics](http://gamestudies.org/0802/articles/sicart) by Miguel Sicart, [Pubsub](Nystrom)
4 | Interactivity, rules, component systems. | Salen and Zimmermen ch. 6 & 13, [Component design pattern](Nystrom)
5 | Emergence, agency, game combat algorithms. | Salen and Zimmermen ch. , Ryan
6 | The jump. | Swink
7 | Game balance and testing. | TBA
8 | Game AI: character behavior, agents, and real-time performance. | TBA
9 | Game AI: analytics and applications of data science and machine learning. | TBA
10 | Procedural content generation. | TBA

## Development and Design Resources


### Are you prepared?


[![World of Warcraft: The Burning Crusade Cinematic Trailer](https://img.youtube.com/vi/IBHL_-biMrQ/0.jpg)](https://youtu.be/IBHL_-biMrQ?t=142)  
*You are not prepared!*  
-- [Illidan Stormrage](https://youtu.be/IBHL_-biMrQ?t=142)

Illidan's words may resonate with you as computer science and game development are both difficult disciplines whose surrounding communities are laced with high expectations and elitism. Below are resources that can cut through assumptions and feeling though self-examination.

Introductory practice exercises for C# and game systems (you can run these in Unity, .Net, or MonoDevelop):
1. [Final Fantasy VI Combat System](https://docs.google.com/document/d/144-2AXOJX79Sw03EwPXGYxdZJOk0zqVZRnSgKHiStA0/edit?usp=sharing)
2. [Crystal Warriors](https://docs.google.com/document/d/1lvsscM-no1C31GW-NSpH_a2u4a2PGHmWhGRHpY7cxyk/edit?usp=sharing)
3. [Fantasy Fight](https://docs.google.com/document/d/1DX_LwKX4Yg7oCnHDdarZkJdcausVmn9BE9hKh_D-Fac/edit?usp=sharing)

[Unity and C# Practice Exam for New Programmers](https://docs.google.com/document/d/1_GUQKvwa-ZqboAhgp63pToQQvR6WdVvVJ3kcRDQ1qR0/edit?usp=sharing)

### Preparing for Projects

Day | Material
------ | -----
1 | [Creating Your First Unity Project](https://learn.unity.com/tutorial/create-your-first-unity-project) - [Using the Unity Interface](https://learn.unity.com/tutorial/using-the-unity-interface) - [Microsoft .NET Interactive Introduction to C#](https://docs.microsoft.com/en-us/dotnet/csharp/tutorials/intro-to-csharp/)
2 |[Essential Unity Concepts](https://learn.unity.com/tutorial/essential-unity-concepts) - [Roll-a-ball Tutorial](https://learn.unity.com/project/roll-a-ball-tutorial?courseId=5c61706dedbc2a324a9b022d) - [Scripting Overview](https://docs.unity3d.com/Manual/ScriptingConcepts.html), 
3 | [Beginner Scripting](https://learn.unity.com/project/beginner-gameplay-scripting) (You can use nearly any 3D project with this tutorial.)
4 | [Intermediate Scripting Tutorial](https://learn.unity.com/project/intermediate-gameplay-scripting) (You can use nearly any 3D project with this tutorial.)
5 | [Project Architecture: Unity Project Folder Structure](https://learn.unity.com/tutorial/project-architecture-unity-project-folder-structure#) - [Unity Tips](https://learn.unity.com/tutorial/unity-tips) (This is long; watch as many as you can or care to.)

### Unity

[Unity User Manual (2018.3)](https://docs.unity3d.com/Manual/index.html)  
[Unity Tutorials](https://unity3d.com/learn/get-started)

#### Learning the Basics

* [Editor Basics](https://unity3d.com/learn/tutorials/topics/interface-essentials/editor-basics) - A video introduction to the basics of working with the Unity editor.
* [Learning the interface](https://docs.unity3d.com/Manual/LearningtheInterface.html) - An introductory web page to the basic components of the Unity editor.
* [An Introduction to Editor Scripting](https://unity3d.com/learn/tutorials/topics/scripting/introduction-editor-scripting) - An example-driven lesson about the basics of creating Unity scripts in C#.
* [Important Classes](https://docs.unity3d.com/Manual/ScriptingImportantClasses.html) - Basic descriptions and links to MonoBehavior, Transform, and RigidBody(2D).
* [Unity C# class relationship diagram](resources/UnityClassHierarchy.png) (originally from this [Reddit post](https://www.reddit.com/r/Unity3D/comments/70ra7b/after_surprising_response_from_the_first_thread_i/))
* [Vector Cookbook](https://docs.unity3d.com/Manual/VectorCookbook.html) - A basic introduction into vector operations in Unity.
* [2D or 3D projects](https://docs.unity3d.com/Manual/2Dor3D.html) - A guide to the differences between 2D and 3D projects in Unity.
* [Graphics](https://docs.unity3d.com/Manual/Graphics.html) - The entrypoint to the graphics capabilities of Unity.
* [Physics](https://docs.unity3d.com/Manual/PhysicsSection.html) - The entrypoint to Unity's physics system.
* [Scripting](https://docs.unity3d.com/Manual/ScriptingSection.html) - The entrypoint into scripting in Unity.
* [Scripting Tutorials](https://unity3d.com/learn/tutorials/s/scripting) - An index of beginner, intermediate, and topical scripting tutorials and lessons.

### C#

#### Learning C#
* [Getting started iwth C#](https://docs.microsoft.com/en-us/dotnet/csharp/getting-started/) from Microsoft .NET documentation.
* [Beginning C# 7 Programming with Visual Studio 2017](https://search.library.ucdavis.edu/primo-explore/fulldisplay?docid=01UCD_ALMA51321760760003126&context=L&vid=01UCD_V1&search_scope=everything_scope&tab=default_tab&lang=en_US) by Perkins, Benjamin, Hammer, Jacob Vibe, and Reid, Jon D.
* [Illustrated C# 7 : the C# language presented clearly, concisely, and visually](https://search.library.ucdavis.edu/primo-explore/fulldisplay?docid=01UCD_ALMA51326862240003126&context=L&vid=01UCD_V1&search_scope=everything_scope&tab=default_tab&lang=en_US) by Solis, Daniel M., and Schrotenboer, Cal.
* [Design patterns in C# : a hands-on guide with real-world examples](https://search.library.ucdavis.edu/primo-explore/fulldisplay?docid=01UCD_ALMA51326874630003126&context=L&vid=01UCD_V1&search_scope=everything_scope&tab=default_tab&lang=en_US) by Sarcar, Vaskaran.



### Game Design

##### How Games are Made
* [Fallout: A Postmortem](https://www.gdcvault.com/play/1015843/Classic-Game-Postmortem) by Timothy Cain
* [Postmortem: Ion Storm's Deus Ex](http://www.gamasutra.com/view/feature/131523/postmortem_ion_storms_deus_ex.php) by Warren Spector
* [How Long Does It Take to Make an Indie Game?]( http://www.gamasutra.com/blogs/JosephMirabello/20140407/214931/How_Long_Does_It_Take_to_Make_an_Indie_Game.php) by Joseph Mirabello

#### Design Documents
* [The "Core" of a Game](https://bbrathwaite.wordpress.com/2008/10/15/the-core-of-a-game/) by Brenda Romero
* [A Feature Set from a “Core”](https://bbrathwaite.wordpress.com/2008/10/17/a-feature-set-from-a-core/) by Brenda Romero
* [Creating a Game Design Document](https://bbrathwaite.wordpress.com/2008/11/30/creating-a-game-design-document/) by Brenda Romero
* [One Page Designs](http://www.gdcvault.com/play/1012356/One-Page) by Stone Librande
* [A GDD Template for the Indie Developer](http://www.gamasutra.com/blogs/JasonBakker/20090604/84211/A_GDD_Template_for_the_Indie_Developer.php) by Jason Bakker
* [Effectively Organize Your Game's Development With a Game Design Document](http://code.tutsplus.com/articles/effectively-organize-your-games-development-with-a-game-design-document--active-10140) by Gamux

#### Game Feel
 * [Jan Willem Nijman - Vlambeer - "The art of screenshake"](https://www.youtube.com/watch?v=AJdEqssNZ-U) by Jan Wellem Jijman (Valmbeer)
 * [Juice it or lose it](https://www.youtube.com/watch?v=Fy0aCDmgnxg) by Martin Jonasson and Petri Purho

#### Production Cycles
* [The four phases of game development](http://www.gamasutra.com/blogs/PascalBestebroer/20151020/256765/The_four_phases_of_game_development.php) by Pascal Bestebroer

#### Development teams
* [pp. 39-56 of Game Development and Production](https://books.google.com/books?id=m5exIODbtqkC&lpg=PR1&pg=PA39#v=onepage&q&f=false) by Erik Bethke [free preview]

#### Techniques for Team Development
* [Scrum: A Breathtakingly Brief and Agile Introduction](http://www.agilelearninglabs.com/resources/scrum-introduction/) by Agile Learning Labs
* [Try Git: Code School](https://try.github.io/) by GitHub

#### Scrum and GitHub

* [Agile Lessons from Ryse and Crysis 3](http://www.gdcvault.com/play/1020790/Agile-Lessons-from-Ryse-and) by Patrick Payne
* [Beyond Scrum: Lean and Kanban for Game Developers](http://www.gamasutra.com/view/feature/132241/beyond_scrum_lean_and_kanban_for_.php) by Clinton Keith
* [git - the simple guide](http://rogerdudler.github.io/git-guide/) by Roger Dudler

#### Project Versioning and Control
* [GitHub for Noobs (1/4) – A Short History](https://youtu.be/1h9_cB9mPT8) by Travis Neilson
* [GitHub for Noobs (2/4) - Common Workflows](https://youtu.be/_ALeswWzpBo) by Travis Neilson
* [GitHub for Noobs (3/4) Using the GitHub Desktop App](https://youtu.be/BKr8lbx3uFY) by Travis Neilson
* [GitHub for Noobs (4/4) Using the Command Line](https://youtu.be/JPKOESR1k04) by Travis Neilson

#### User Interface and User Experience (UI/UX)
* [The Interface is Part of Gameplay](https://bbrathwaite.wordpress.com/2010/04/15/the-interface-is-a-part-of-gameplay/) by Brenda Romero

#### Game Trailers and Press Kits
* [Game Trailer and Press Kit](http://drive.google.com/open?id=1-cVwNxSJyvt37HPLE-af_c9y9iXNahkaXlVaJzGuToo)

## Attendance Policy
This course has no formal attendance policy. However, regular attendance is greatly recommended to be successful in the course as many of the class meetings will involve programming and one-on-one learning. If you expect to be consistently absent, please discussion the situation with your instructor.


## UC Davis Code of Academic Conduct

The UC Davis Code of Academic Conduct (http://sja.ucdavis.edu/files/cac.pdf) will be strictly enforced in this class. In particular, plagiarism, academic dishonesty, and cheating will be dealt with severely.  Any breach of the Code of Academic conduct can result in failing the assignment, failing the course, and displinary action via the Office of Student Support and Judicial Affairs (http://sja.ucdavis.edu/).

## Technology in the Classroom Policy
The use of laptops and technology in general are encouraged in this course as long as they are not disruptive to the rest of the class. If you choose to use a device with a screen, please sit in the back of the room to avoid distracting your fellow students. You are required to ask for permission before video or audio recording in the classroom. In general, students will be treated as adults capable of managing their technological lives while being respectful of others in the classroom.

## Social Media Policy
Students are not permitted to make visual or audio recordings, including live streaming, of classroom lectures or any class related content, using any type of recording devices (e.g., smart phone, computer, digital recorder, etc.) unless prior permission from the instructor is obtained, and there are no objections from any of the students in the class. If permission is granted, personal use and sharing of recordings and any electronic copies of course materials (e.g., PowerPoints, formulas, lecture notes and any classroom discussions online or otherwise) is limited to the personal use of students registered in the course and for educational purposes only, even after the end of the course.

To supplement the classroom experience, lectures may be audio or video recorded by faculty and made available to students registered for this class. Faculty may record classroom lectures or discussions for pedagogical use, future student reference, or to meet the accommodation needs of students with a documented disability. These recordings are limited to personal use and may not be distributed (fileshare), sold, or posted on social media outlets without the written permission of faculty.

Unauthorized downloading, file sharing, distribution of any part of a recorded lecture or course materials. or using information for purpose other than the student's own learning is prohibited unless prior authorization is given by the instructor.
