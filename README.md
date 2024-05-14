#yoel godot card game framework

## demo gifs:
[![gameplay 2](https://github.com/yoel123/godot-yoel-space-sim-game/blob/main/gifs/2.gif)]



## the goal "big idea"

my goal was to make a framework that implaments card gui behaviours
like those in popular card games like sts and other rouglike deckbuilders(or any digital card game).
there is the card scene/class, it can be placed in the "hand" class,dragged and dropped
around the screen, the card can be placed on a genral object called the card pile.
the card pile can be the draw deck,discard pile or a place on the board for placing cards.
it can represent a target for cards etc.
cards can be placed or can target (with raycasting, im talking about the red white gradiant line).

the core code for all this behaviours is about 600 lines of code.

its enogh to get anyone started and add their own logic and game rules/behaviours.

i left a couple of custom methods that run inside core methods so it will be easy
to extand any of my objects without touching the core code.
i also made a lot of boolean "flags" that help control my objects behaviours,
for example say you dont want the card pile to be targeted by cards just change
"can_be_targeted_by_cards" to false.

i wanted this framework to be agnostic to any project requirment and be able to easily
integrate to any project.

i will document this soon.

also i dont want this to be a dead framework no one knows how to use.
so for the first 1-3 people to contact me i will give an hour of my time via zoom
and personaly teach how to use it. the only condition is that the person i will teach
will also teach another member of the godot community how to use it.



## contact me

contact form:

https://yoelspacesim.wordpress.com/

discord:
