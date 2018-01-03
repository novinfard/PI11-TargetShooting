# TargetShooting
This is an iOS game that creates targets surrounding the player, and it’s their job to find and shoot them as fast as possible. The game will create a new target every two seconds until 20 have been created in total, at which point the game ends as soon as the player finds the final target. 

Important Parameters:
- A `remainingLabel` that will show the player how many targets are currently visible.
- A `timer` that creates a new target every two seconds.
- A `targetsCreated` counter that stores how many targets have been created in total,
up to 20.
- Finally, a `targetCount` counter that stores how many targets are currently visible. When this changes, we’re going to update the ‍‍`remainingLabel` text so the user always knows their status.

## Screenshots
[![](http://www.novinfard.com/media/gitshots/PI11-targetShooting-1.png)](http://www.novinfard.com/media/gitshots/PI11-targetShooting-1.png)

## Main Targets
ARKit, SpriteKit, GameplayKit, ARAnchor, Timer

## Credits
The concept of this app is adapted from iOS Practical 11 book written by Paul Hudson.

## Author
**Soheil Novinfard** - [www.novinfard.com](https://www.novinfard.com)

## License
This project is licensed under the MIT License.