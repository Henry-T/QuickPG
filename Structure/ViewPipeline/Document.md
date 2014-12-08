Document

ViewPipeline Pattern is driven by three key parts

- Selector    for data sharing
- Switcher    for view switch forward and back
- ViewStack   for view revisit



It is a solution for the following situation:

- you have a lot of views to switch and they share data during the switch. it's a mess when you got more views
- your team have different systems, views can share between different various systems.
- user is allowed to go "back", it's a stack of actions in someway
- user is allowed to go all the way back to the initial point, in canse the action stack getting larger 
- views can be visited more than once in a single action chain, without "back" action
- you need to share some common animations/effects/widgets between views


Move facts:

- you can make your game view driven. there's only one Cocos2d scene.


When you don't need this:
- your Views won't be shared during the whole action chain. (放射状交互链，设计使然或冗余代码实现)


良好抽象的Selection能够与View相分离，它只与系统有关，从而达到适应任何View，易于修改的良好设计。

