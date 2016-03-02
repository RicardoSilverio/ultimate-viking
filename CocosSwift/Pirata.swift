//
//  Pirata.swift
//  CocosSwift
//
//  Created by Ricardo Silverio de Souza on 28/02/16.
//  Copyright © 2016 Flameworks. All rights reserved.
//

protocol PirataDelegate {
    func powerUPGerado()
    func powerUPConsumido()
}

import Foundation
class Pirata : CCNode {
    
    private var speed:Int?
    private var health:Int?
    private var scoreGenerated:Int?
    private var sprite:CCSprite?

    
    private var isPowerUP = false
    private var isAlive = true
    
    var delegate:PirataDelegate?
    
    convenience init(imageNamed imageName: String!, aQtdFrames:Int, initialSpeed:Int, initialHealth:Int, scoreGenerated:Int) {
        self.init()
        self.speed = initialSpeed
        self.health = initialHealth
        self.scoreGenerated = scoreGenerated
        
        self.sprite = gerarAnimacaoSpriteWithName(imageName, aQtdFrames: aQtdFrames)
        self.sprite!.position = CGPointMake(0, 0)
        self.sprite!.anchorPoint = CGPointMake(0, 0)
        self.sprite!.scale = Device.getAssetDimensionByKey("pirata:Game")
        self.addChild(self.sprite, z: 3)
        
        self.userInteractionEnabled = true
        self.contentSize = (sprite?.boundingBox().size)!
        
        self.physicsBody = CCPhysicsBody(rect: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height), cornerRadius: 0)
        self.physicsBody.type = .Kinematic
        self.physicsBody.collisionType = "Pirata"
        self.physicsBody.collisionCategories = ["pirata"]
        self.physicsBody.collisionMask = ["tiro"]
        self.physicsBody.mass = 100

    }
    
    override init!() {
        super.init()
    }
    
    private func gerarAnimacaoSpriteWithName(aSpriteName:String, aQtdFrames:Int) -> CCSprite {
        // Carrega os frames da animacao dentro do arquivo passado dada a quantidade de frames
        var animFrames:Array<CCSpriteFrame> = Array()
        for (var i = 1; i <= aQtdFrames; i++) {
            let name:String = i < 10 ? "\(aSpriteName)0\(i).png" : "\(aSpriteName)\(i).png"
            animFrames.append(CCSpriteFrameCache.sharedSpriteFrameCache().spriteFrameByName(name))
        }
        // Cria a animacao dos frames montados
        let animation:CCAnimation = CCAnimation(spriteFrames: animFrames, delay: 0.1)
        // Cria a acao com a animacao dos frames
        let animationAction:CCActionAnimate = CCActionAnimate(animation: animation)
        // Monta a repeticao eterna da animacao
        let actionForever:CCActionRepeatForever = CCActionRepeatForever(action: animationAction)
        // Monta o sprite com o primeiro quadro
        var spriteRet:CCSprite = CCSprite(imageNamed: "\(aSpriteName)01.png")
        // Executa a acao da animacao
        spriteRet.runAction(actionForever)
        // Retorna o sprite para controle na classe
        return spriteRet
    }
    
    func mover(destino:CGPoint) {
        let action = CCActionSequence(one: CCActionMoveTo(duration: CCTime(10 - speed!), position: destino),
            two: CCActionCallBlock(block: { () -> Void in
                self.sprite!.stopAllActions()
                self.removeFromParentAndCleanup(true)
            }
        ))
        self.runAction(action)
    }
    
    func receberDano(dano:Int, podeGerarPowerUP:Bool) -> Int {
        if(isAlive) {
            health! -= dano
            if(health! <= 0) {
                isAlive = false
                
                sprite!.stopAllActions()
                self.stopAllActions()
                
                let indicePowerUP = arc4random_uniform(10) + 1
                if(podeGerarPowerUP && indicePowerUP == 10) {
                    isPowerUP = true
                    sprite!.removeFromParentAndCleanup(true)
                    sprite = CCSprite(imageNamed: SpriteMap.PowerUp.rawValue)
                    sprite!.position = CGPointMake(0, 0)
                    sprite!.anchorPoint = CGPointMake(0, 0)
                    sprite!.scale = Device.getAssetDimensionByKey("tiro:Game")
                    self.addChild(self.sprite, z: 3)
                    
                    self.physicsBody.collisionMask = []
                    self.physicsBody.collisionCategories = []
                    
                    self.delegate?.powerUPGerado()
                } else {
                    sprite!.visible = false
                    DelayHelper.sharedInstance.callBlock({ () -> Void in
                        self.removeFromParentAndCleanup(true)
                    }, withDelay: 2)

                }
                return scoreGenerated!
            }
            
        }
        
        return 0
    }
    
    func getAlive() -> Bool {
        return isAlive
    }
    
    override func touchBegan(touch: UITouch!, withEvent event: UIEvent!) {
        
        if(!isAlive && isPowerUP) {
            sprite!.visible = false
            self.removeFromParentAndCleanup(true)
            delegate?.powerUPConsumido()
        }
        
    }
    
}