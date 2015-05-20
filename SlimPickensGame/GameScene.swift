//
//  GameScene.swift
//  SlimPickensGame
//
//  Created by Frank Desimini on 2015-05-19.
//  Copyright (c) 2015 Eff Dee Productions. All rights reserved.
//

import SpriteKit

var slimPickens = SKSpriteNode()


class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Euphemia UCAS")
//        myLabel.text = "Yee Haw!";
//        myLabel.fontSize = 65;
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
//        
//        self.addChild(myLabel)
        
        self.backgroundColor = UIColor.magentaColor()
        
        var slimTexture = SKTexture(imageNamed: "nucular_bird1")
        var slimTexture2 = SKTexture(imageNamed: "nucular_bird2")
        var slimTexture3 = SKTexture(imageNamed: "nucular_bird3")
        var slimTexture4 = SKTexture(imageNamed: "nucular_bird4")
        
        slimPickens = SKSpriteNode(texture: slimTexture)
        slimPickens.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        var animation = SKAction.animateWithTextures([slimTexture, slimTexture2, slimTexture3, slimTexture4], timePerFrame: 0.15)
        var makeSlimFlap = SKAction.repeatActionForever(animation)
        slimPickens.runAction(makeSlimFlap)
        
        self.addChild(slimPickens)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
