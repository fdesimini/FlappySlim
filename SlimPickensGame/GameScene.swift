//
//  GameScene.swift
//  SlimPickensGame
//
//  Created by Frank Desimini on 2015-05-19.
//  Copyright (c) 2015 Eff Dee Productions. All rights reserved.
//

import SpriteKit


// create sprite nodes

var slimPickens = SKSpriteNode()
var bg = SKSpriteNode()


class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
       
        self.backgroundColor = UIColor.greenColor()

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
        
        self.addChild(slimPickens)
        
//        add a background
        
        //define ground object
        var ground = SKNode()
        //set the ground position
        ground.position = CGPointMake(0, 0)
        //add physics
        ground.physicsBody = SKPhysicsBody (rectangleOfSize: CGSizeMake(self.frame.size.width, 1))
        ground.physicsBody?.dynamic = false
        
        self.addChild(ground)
        
        //add the background to the scene
        var backgroundImage1 = SKTexture(imageNamed: "bg_depthBlurred_front")
        bg = SKSpriteNode(texture: backgroundImage1)
        bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame))
        bg.size.height = 504
        self.addChild(bg)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
//            let sprite = SKSpriteNode(imageNamed:"nucular_bird1")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
