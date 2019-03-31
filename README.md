# Crazy Bowling
# Game Design Document

##  Game Concept
A fun 3D motion-controlled physics-based rolling ball game in which the player is tasked with completing a variety of gamemodes that range from obstacle courses, floor is lava and time-based collection. Each game mode will be unique and challenge the player in a different way.

### Gamemode Concepts
#### Gamemode 1
* Time based 
* Knockdown/destroy as many pins as possible (Score) 
* Avoid holes/obstacles

#### Gamemode 2
* Obstacle course
* Avoid exploding/hazardous pins (Result in death)
* Completion time tracked

#### Gamemode 3
* Platformer - Floor is lava
* Reach the end of the level
* Completion time tracked
* Moving platforms

##  Areas of Interest 
* Motion Controls
* Personal Stats  
* Push Notifications

##  Mock Screens
![Image of Menu-Screen](https://raw.githubusercontent.com/iksneS/CrazyBowling/master/MenuCB_1.png)
![Image of Menu-Screen2](https://raw.githubusercontent.com/iksneS/CrazyBowling/master/MenuCB_2.png)
![Image of In-game UI](https://raw.githubusercontent.com/iksneS/CrazyBowling/master/MenuCB_3.png)
![Image of In-game UI2](https://raw.githubusercontent.com/iksneS/CrazyBowling/master/MenuCB_4.png)

## Value of the Game/App 
To create a quick, fun and replayable experience for gamers that will keep them coming back for more on their free-time.

##  Path through-out the game 
**When the player opens up our application they are greeted with the Main Menu:**

1. Play, Options menu or Quit (The User has the option to start game or go to options to adjust the in game music/ Sound effects.)
1. Player hits Play and is loaded into the gamemode selection page.
1. Upon selecting a gamemode, the player is loaded into the first level of their corresponding gamemode.
1. After each attempt, the player is given the option to Continue, retry or Quit to the main menu.
1. When the game is finished with either a win or loss result the following occurs:
   * Win:

        1. Congratulations Notification
        
        1. "Continue to next level" or "Exit to main menu"

   * Loss:

        1. Level failed Notification

        1. "Retry" or "Exit to main menu"

1. The cycle repeats until the player decides to quit the application


##  Discuss a few use cases 
User (player) is given 3 options at the main menu (Play, Achievements, Options). 

Play - Player is loaded into the gamemode selection screen where they are prompted to select a gamemode. Upon selecting their desired gamemode, they are then loaded into the first level and the game begins. Upon completing a level the user is given the option to continue to the next level or quit to the main menu.

Options Menu - Allows the user to adjust audio, etc.

Quit - Exits the app.
