//
//  Scene.swift
//  TargetShooting
//
//  Created by Soheil on 01/01/2018.
//  Copyright © 2018 Soheil Novinfard. All rights reserved.
//

import SpriteKit
import ARKit
import GameplayKit

class Scene: SKScene {
	
	let remainingLabel = SKLabelNode()
	var timer: Timer?
	var targetsCreated = 0
	var targetCount = 0 {
		didSet {
			remainingLabel.text = "Remaining: \(targetCount)"
		}
	}
	let startTime = Date()
	
    override func didMove(to view: SKView) {
        // Setup your scene here
		remainingLabel.fontSize = 36
		remainingLabel.fontName = "AmericanTypewriter"
		remainingLabel.color = .white
		remainingLabel.position = CGPoint(x: 0, y: view.frame.midY -
			50)
		addChild(remainingLabel)
		targetCount = 0
		
		timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
			self.createTarget()
		}
    }
	
	// create new targets
	func createTarget() {
		if targetCount == 20 {
			timer?.invalidate()
			timer = nil
			return
		}

		targetsCreated += 1
		targetCount += 1
		
		// find the scene view we are drawing into
		guard let sceneView = self.view as? ARSKView else { return }
		
		// get access to a random number generator
		let random = GKRandomSource.sharedRandom()
		
		// create a random X rotation
		let xRotation = simd_float4x4(SCNMatrix4MakeRotation(Float.pi *
			2 * random.nextUniform(), 1, 0, 0))
		
		// create a random Y rotation
		let yRotation = simd_float4x4(SCNMatrix4MakeRotation(Float.pi *
			2 * random.nextUniform(), 0, 1, 0))
		
		// combine them together
		let rotation = simd_mul(xRotation, yRotation)
		
		// move forward 1.5 meters into the screen
		var translation = matrix_identity_float4x4
		translation.columns.3.z = -1.5
		
		// combine that with our rotation
		let transform = simd_mul(rotation, translation)
		
		// create an anchor at the finished position
		let anchor = ARAnchor(transform: transform)
		sceneView.session.add(anchor: anchor)
	}
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else {return }
		let location = touch.location(in: self)
		
		let hit = nodes(at: location)
		
		if let sprite = hit.first {
			let scaleOut = SKAction.scale(to: 2, duration: 0.2)
			let fadeOut = SKAction.fadeOut(withDuration: 0.2)
			let group = SKAction.group([scaleOut, fadeOut])
			let sequence = SKAction.sequence([group, SKAction.removeFromParent()])
			sprite.run(sequence)
			
			targetCount -= 1
		}
    }
}
