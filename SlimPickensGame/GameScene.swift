//
//  GameScene.swift
//  SlimPickensGame
//
//  Created by Frank Desimini on 2015-05-19.
//  Copyright (c) 2015 Eff Dee Productions. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {

// create sprite nodes

    var slimPickens = SKSpriteNode()
    var bg = SKSpriteNode()
    var bg2 = SKSpriteNode()


    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
       
        self.backgroundColor = UIColor.whiteColor()

        var slimTexture = SKTexture(imageNamed: "nucular_bird1")
        var slimTexture2 = SKTexture(imageNamed: "nucular_bird2")
        var slimTexture3 = SKTexture(imageNamed: "nucular_bird3")
        var slimTexture4 = SKTexture(imageNamed: "nucular_bird4")
 
        // create variable for animation and create action (SKAction)
        
        var animation = SKAction.animateWithTextures([slimTexture, slimTexture2, slimTexture3, slimTexture4], timePerFrame: 0.15)
        var makeSlimFlap = SKAction.repeatActionForever(animation)
        
        
        // Add/assign texture to the node
        
        slimPickens = SKSpriteNode(texture: slimTexture)
        slimPickens.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        // attachd the animation to the node
        slimPickens.runAction(makeSlimFlap)
        
        // add physics (phycial properties) to Flappy
        slimPickens.physicsBody = SKPhysicsBody(circleOfRadius: slimPickens.size.height/2)
        slimPickens.physicsBody?.dynamic = true
        slimPickens.physicsBody?.allowsRotation = false
        slimPickens.zPosition = 10
        
        self.addChild(slimPickens)

        
        //define ground object
        var ground = SKNode()
        //set the ground position
        ground.position = CGPointMake(0, 0)
        //add physics
        ground.physicsBody = SKPhysicsBody (rectangleOfSize: CGSizeMake(self.frame.size.width, 150))
        ground.physicsBody?.dynamic = false
        
        self.addChild(ground)
        
        //add the background to the scene
        var backgroundImage1 = SKTexture(imageNamed: "bg_depthBlurred_front")
        var backgroundImage2 = SKTexture(imageNamed: "bg_depthBlurred_mid")
        bg = SKSpriteNode(texture: backgroundImage1)
        bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame))
        bg.size.height = self.frame.height
        bg2 = SKSpriteNode(texture: backgroundImage2)
        bg2.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame))
        bg2.size.height = self.frame.height
        self.addChild(bg)
        self.addChild(bg2)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        println("Flappy is flying")
        slimPickens.physicsBody?.velocity = CGVectorMake(0, 0)
        slimPickens.physicsBody?.applyImpulse(CGVectorMake(0, 150))
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            if location == slimPickens.position {
                println("Flappy is touched")
                

            }
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
