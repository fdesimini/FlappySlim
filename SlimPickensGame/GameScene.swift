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
    var bg3 = SKSpriteNode()
    


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
        
        //add the background texture to the scene
        var backgroundTexture = SKTexture(imageNamed: "bg_depthBlurred_back2" )
        
        //what does this do?
        var bgTextureWidth = backgroundTexture?.size().width
        println("BG width: \(bgTextureWidth)")

        //create a variable for animating the background scene

        var moveBG = SKAction.moveByX( -(bgTextureWidth!), y: 0, duration: 2)
        var replace = SKAction.moveByX(bgTextureWidth!, y:0, duration: 0)
        var moveBGForever =  SKAction.repeatActionForever( SKAction.sequence([moveBG, replace]) )
        var bgCalculation = 1 + self.frame.size.width / ( bgTextureWidth! * 2 )
        
        for var i:CGFloat = 0; i < 3 ; i++ {
            var backgroundSprite = SKSpriteNode(texture: backgroundTexture )
            backgroundSprite.position = CGPoint(x: bgTextureWidth! / 2 + bgTextureWidth! * i, y:CGRectGetMidY(self.frame))
            backgroundSprite.size.height = self.frame.height
            
            backgroundSprite.runAction( moveBGForever )
            addChild( backgroundSprite )
            
        }
        
//        for var i:CGFloat = 0; i < 3; i++ {
//            backGround = SKSpriteNode(texture: bgImage1)
//            backGround.position = CGPoint(x: bgImage1.size().width /2 +bgImage1.size().width *i, y:CGRectGetMidY(self.frame)
//            backGround.size.height = self.frame.height
//            
//            backGround.runAction(moveBGForEver)
//            movingObjects.addChild(backGround)
//        
//        }
        
        
//      background
        
//        bg = SKSpriteNode(texture: bgImage1)
//        bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
//        bg.size.height = self.frame.height
//        bg2 = SKSpriteNode(texture: bgImage2)
//        bg2.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
//        bg2.size.height = self.frame.height
//        bg3 = SKSpriteNode(texture: bgImage3)
//        bg3.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
//        bg3.size.height = self.frame.height
//
//        self.addChild(bg)
//        self.addChild(bg2)
//        self.addChild(bg3)
        
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
