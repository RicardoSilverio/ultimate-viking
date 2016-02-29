//
//  Tiro.swift
//  CocosSwift
//
//  Created by Ricardo Silverio de Souza on 28/02/16.
//  Copyright © 2016 Flameworks. All rights reserved.
//

import Foundation
class Tiro : CCNode {
    
    private var sprite:CCSprite?
    private var alvo:CGPoint?
    private var tempoDeslocamento:CGFloat?
    
    convenience init(imageNamed:String, alvo:CGPoint, tempoDeslocamento:CGFloat) {
        self.init()
        sprite = CCSprite(imageNamed: imageNamed)
        self.alvo = alvo
        self.tempoDeslocamento = tempoDeslocamento
        
        sprite!.position = CGPointMake(0, 0)
        sprite!.anchorPoint = CGPointMake(0, 0)
        self.addChild(sprite)
        
        self.contentSize = sprite!.boundingBox().size
        
        self.physicsBody = CCPhysicsBody(rect: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height), cornerRadius: 0)
        self.physicsBody.type = .Kinematic
        self.physicsBody.collisionType = "Tiro"
        self.physicsBody.collisionCategories = ["tiro"]
        self.physicsBody.collisionMask = ["pirata"]
        self.physicsBody.mass = 100
        
        
    }
    
    func lancar() {
        
        let actionSpin:CCActionRotateBy = CCActionRotateBy.actionWithDuration(1.5, angle:360) as! CCActionRotateBy
        let repeatSpin:CCActionRepeatForever = CCActionRepeatForever.actionWithAction(actionSpin) as! CCActionRepeatForever
        self.runAction(repeatSpin)
        
        
        let sequence:CCActionSequence = CCActionSequence.actionOne(CCActionMoveTo.actionWithDuration(CCTime(tempoDeslocamento!), position: self.alvo!) as! CCActionFiniteTime, two:  CCActionCallBlock.actionWithBlock({ () -> Void in
            self.removeFromParentAndCleanup(true)
        }) as! CCActionFiniteTime) as! CCActionSequence
         self.runAction(sequence)
    
    }
    
    
    override init!() {
        super.init()
    }
    
    
}
