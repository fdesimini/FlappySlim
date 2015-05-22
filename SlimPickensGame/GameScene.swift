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

    
    var newColour = UIColor(red: 242/255, green: 238/255, blue: 135/255, alpha: 1.0)
    
    var slimPickens = SKSpriteNode()
    var background = SKSpriteNode()
    var background2 = SKSpriteNode()
    var background3 = SKSpriteNode()
    
    //Collision and Contact Category
    let slimPickensCategory:UInt32 = 0x1 << 0
    let groundCategory:UInt32 = 0x1 << 1
    let gapCategory:UInt32 = 0x1 << 2
    let pipeCategory:UInt32 = 0x1 << 3


    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
       
        self.backgroundColor = newColour

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
        
        
        
        //add the Front background texture to the scene
        var backgroundTextureFront = SKTexture(imageNamed: "bg_front_blue")
        
        //create a variable(s) for animating the background scene

        var moveBackground = SKAction.moveByX( -backgroundTextureFront.size().width, y: 0, duration: 10)
        var replaceBackground = SKAction.moveByX(backgroundTextureFront.size().width, y:0, duration: 0)
        var moveBackgroundForever =  SKAction.repeatActionForever( SKAction.sequence([moveBackground, replaceBackground]) )
        
        for var i:CGFloat = 0; i < 3 ; i++ {
            background = SKSpriteNode(texture: backgroundTextureFront)
            background.position = CGPoint(x: backgroundTextureFront.size().width/2 + backgroundTextureFront.size().width * i, y: CGRectGetMidY(self.frame))
            background.size.height = self.frame.height
            
            background.runAction( moveBackgroundForever )
            background.zPosition = 2
            addChild( background )
            
        }
        
        //add the Mid background texture to the scene
        var backgroundTextureMid = SKTexture(imageNamed: "bg_mid_brown")
        
        //create a variable(s) for animating the background scene
        
        var moveBackgroundMid = SKAction.moveByX( -backgroundTextureMid.size().width, y: 0, duration: 8)
        var replaceBackgroundMid = SKAction.moveByX(backgroundTextureMid.size().width, y:0, duration: 0)
        var moveBackgroundForeverMid =  SKAction.repeatActionForever( SKAction.sequence([moveBackgroundMid, replaceBackgroundMid]) )
        
        for var i:CGFloat = 0; i < 3 ; i++ {
            background2 = SKSpriteNode(texture: backgroundTextureMid)
            background2.position = CGPoint(x: backgroundTextureMid.size().width/2 + backgroundTextureMid.size().width * i, y: CGRectGetMidY(self.frame))
            background2.size.height = self.frame.height
            
            background2.runAction( moveBackgroundForeverMid )
            background2.zPosition = 1
            addChild( background2 )
            
        }
        
        // add the Back background texture to the scene
        var backgroundTextureBack = SKTexture(imageNamed: "bg_back_purple")
        
        //create a variable(s) for animating the background scene
        
        var moveBackgroundBack = SKAction.moveByX( -backgroundTextureBack.size().width, y: 0, duration: 12)
        var replaceBackgroundBack = SKAction.moveByX(backgroundTextureBack.size().width, y:0, duration: 0)
        var moveBackgroundForeverBack =  SKAction.repeatActionForever( SKAction.sequence([moveBackgroundBack, replaceBackgroundBack]) )
        
        for var i:CGFloat = 0; i < 3 ; i++ {
            background3 = SKSpriteNode(texture: backgroundTextureBack)
            background3.position = CGPoint(x: backgroundTextureBack.size().width/2 + backgroundTextureBack.size().width * i, y: CGRectGetMidY(self.frame))
            background.size.height = self.frame.height
            
            background3.runAction( moveBackgroundForeverBack )
            background3.zPosition = 0
            addChild( background3 )
            
        }
        
        //Set up a timer
        var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("makePipes"), userInfo: nil, repeats: true)
        

    }
    
    func makePipes() {
        //creating a function from what we've done for pipes
        
        //create a gap
        var gap = slimPickens.size.height * 2
        //movement amount
        var movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        // gap offset
        var pipeOffset = CGFloat (movementAmount) - self.frame.size.height / 4
        // move pipes animation
        var movePipes = SKAction.moveByX(-self.frame.size.width * 2, y: 0, duration: NSTimeInterval(self.frame.size.width / 100))
        // remove a pipe
        var removePipes = SKAction.removeFromParent()
        // move and remove Pipes
        var moveAndRemovePipes = SKAction.sequence([movePipes, removePipes])
        //Pipe1
        var pipe1Texture = SKTexture(imageNamed: "pipe_top_green")
        var pipe1 = SKSpriteNode(texture: pipe1Texture)
        //added action to pipe1
        pipe1.runAction(moveAndRemovePipes)
        pipe1.physicsBody = SKPhysicsBody(rectangleOfSize: pipe1.size)
        pipe1.physicsBody?.dynamic = false
        
        pipe1.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.width, y: CGRectGetMidY(self.frame) + pipe1.size.height/2 + gap / 2 + pipeOffset)
        
        pipe1.zPosition = 5
        self.addChild(pipe1)
        
        //Pipe2
        var pipe2Texture = SKTexture(imageNamed: "pipe_bott_green")
        var pipe2 = SKSpriteNode(texture: pipe2Texture)
        //added action to pipe1
        pipe2.runAction(moveAndRemovePipes)
        pipe2.physicsBody = SKPhysicsBody(rectangleOfSize: pipe2.size)
        pipe2.physicsBody?.dynamic = false
        //added action to pipe
        
        pipe2.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.width, y: CGRectGetMidY(self.frame) - pipe2.size.height/2 - gap / 2 + pipeOffset)
        
        pipe2.zPosition = 6
        
        self.addChild(pipe2)
        
    }

    func playSound(audio:String, shouldRepeat:Bool)
    {
        var sound = SKAction.playSoundFileNamed(audio, waitForCompletion: shouldRepeat)
        runAction(sound)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
//        println("Flappy is flying")
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
