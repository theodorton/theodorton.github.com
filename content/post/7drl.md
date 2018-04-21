---
title: "7DRL"
date: 2018-04-20T23:07:42+02:00
draft: true
categories: [ "Gamedev" ]
---

_tl;dr My friend and I made a roguelike named Skyspire. It's our first roguelike, and first game in a long while. You can find the [code on Github](https://github.com/geppetto-apps/7drl)._

---

A week ago I decided to do a 7DRL Challenge. I've been tinkering with different game engines since middle school, but I tend to start projects without finishing. I read about the 7DRL concept some time last year, and I figured it seemed like a good idea to actually get to something playable.

I started last Friday at 21:30 and stopped programming around 21:15 today when my laptop battery drained out. (I forgot my charger at work, so I had to go get it to write this blog post.)

<div style="width:100%;height:0;padding-bottom:63%;position:relative;"><iframe src="https://giphy.com/embed/ZNVCwBR1FGVUjqjZB2" width="100%" height="100%" style="position:absolute" frameBorder="0" class="giphy-embed" allowFullScreen></iframe></div>

I didn't have any experience playing roguelikes–except from the basic mechanics–so I learned a ton from the process. A tutorial for Python and libtcod exists, and it seems like the usual starting point for most roguelike developers. Coming from web development and a heavy object- and pattern-oriented programming world, the tutorial comes off as pretty pragmatic to me. This turned out to create som unexpected problems as I deviated from the example code and attempted to refactor my code. More on that later.

Alex, a friend of mine did the graphics and audio. We've been working on games before, but never made something as playable as this. It made a big difference to the play experience and making it more accessible compared to an ASCII-experience. He also came up with the theme, title and backstory for the game.

In Skyspire, you're a citizen of a poor country-side village. One day a tower appeared out of nowhere outside the city. No one but the bravest dare to enter the tower to challenge its power, but no one has managed to get to the top floor yet. Your goal is to enter and slay the as much of the evil within as possible.

The game is pretty playable, although the randomness of the monster and item spawning can make some of the playthroughs harder (I guess sometimes impossible). I spent time adjusting the tutorial code to balance the progression of the game, but it's nowhere near perfect yet.

In learned a lot about the roguelike genre, but I think there is more than enough material out there for you to read already. But I do have some tips about the process that I would apply personally next time.

### Schedule your sessions

The 7DRL gives you 168 hours to work with. I'll guess most people will be able to spend around 50 hours for any given work week and lose the rest of the time to sleep, work, eating and chores. I believe I managed to spend around half of that for my week, if I were to do something similar it again I would probably set aside more time during the weekend.

### Playability over code quality

I copy-pasted most of the code from the tutorial, except my refactoring of extracting and grouping methods in new classes and to new files. I did end up with a minimal set of global variables, but probably not time well spent. I would probably be able to get the same result in a shorter time by keeping everything in one file and survive with a couple more global variables.

Specifically, the refactoring caused some issues for me when implementing save games on Day 4 and I wasn't able to solve it until the last day. Keeping the same structure would be better for the scope of the week. I'd recommend typing out the example code by hand instead of copying. It should give you a more intimate relationship with your code.

I read this advice in the [Make a 7DRL post](http://www.gamesofgrey.com/blog/?p=157) by Darren Gray, but ignored it. Don't make the same mistake!

### Plan and keep a backlog

The steps of the tutorial was the basis for my initial backlog. I tried splitting the backlog between the days, which worked well. When I got new ideas I added them to the end of the backlog. I have limited experience with the genre so next time I would play a couple games before starting. I'd probably get some ideas I could develop further (or steal). I'm still satisfied having something playable, even if it's a little "vanilla".

## Features not in the tutorial

We didn't get to the "Adventure gear"-part of the tutorial, but the game has some other features.

### Optimal placement of ladders and monsters

The tutorial code places the ladder in a random room. After implementing A* pathfinding, I figured I could use that to calculate the distance from the player's starting position and make sure the ladder waso somewhat harder to reach. For monsters I avoided spawning monsters  and items in the first room of each floor. For new players, I think it makes sense to let them figure out the movement and FOV in the first room before proceeding.

### Inferred stats from level

Fighter components in the tutorial, which represents the biggest part of the combat system. Skyspire determine your hit points, strength and defense from your level. The player and monsters will get different bonuses for each level, and I had to test a lot to make it balanced. I've managed to reach player level 7 before dying, but I'm not a well-versed roguelike player. Alex, the graphics dude, managed to reach level 10.

You'll find a similar concept in the tutorial, but the implementation is a bit weak.

### Graphical Tiles and audio

Thanks to @scribbel's work the game has graphical tiles and audio. To me, it makes the game feels more "gamey".

### Deterministic Dungeon Generator

The Skyspire has a seed-based dungeon generator, so you can provide a seed with an environment variable. As a developer it makes it easier for me to debug and you could play the same dungeon as another player to see who's best.

### A bit more object-oriented code

As noted above this is probably not a plus. I lost some time to debugging issues with the save games and reducing global variables to get it to work, but I think I have a better foundation to work on for new features.

### Monster AI state machine

The monsters use a simple state machine implementation for their AI. I've implemented idle and aggro states, and adding monsters fleeing should be simple.

### XP exploration

The player receives XP when he reaches a new room in the dungeon. This felt natural to me and a concept I've seen in some MMORPGs.


### Analytics via Segment/Google Analytics

Lastly, the game has some analytics implemented for me so I can track number of active players and how strong the players/monsters are. We collect the following events:

- Viewed Main Menu
- Started Game
- Loaded Game
- Player Leveled Up
- Player Defeated {monster}
- {monster} Defeated Player
- Exited Game

The analytics is anonymous and opt-in so you keep your privacy.

## Now what?



1. Use https://gameanalytics.com/ instead of Segment/Google Analytics
2. Ladders should be visible outside FOV after explored
3. Put the chests back
3. Floor indicator
4. Medium and large healing potions
5. Swords with tiers
6. Add more analytics data
7. Cooperation mode online
8. Playing via a browser
9. More deterministic randomness (for online play)
10. More organic cave generator

