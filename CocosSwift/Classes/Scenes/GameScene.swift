//
//  GameScene.swift
//  CocosSwift
//
//  Created by Ricardo Silverio de Souza on 20/02/16.
//  Copyright © 2016 Flameworks. All rights reserved.
//

import Foundation
class GameScene : CCScene, PirataDelegate {
    
    private var canPlay:Bool = true
    private var canThrowAxe = true
    
    private var player:CCSprite?
    private var linhaEnergia:CCSprite?
    
    private var delayGeracaoPiratas:Double = 4
    private var physicsWorld = CCPhysicsNode()
    
    
    override init() {
        super.init()
        
        let background = CCSprite(imageNamed: Device.getAssetByKey("cenario"))
        background.anchorPoint = CGPointMake(0.5, 0.5)
        background.position = CGPointMake(Device.screenSize.width / 2, Device.screenSize.height / 2)
        self.addChild(background)
        
        player = CCSprite(imageNamed: SpriteMap.Player.rawValue)
        player!.anchorPoint = CGPointMake(0.5, 0.5)
        player!.position = CGPointMake(CGFloat(Device.getAssetDimensionByKey("viking:margin:Game")), Device.screenSize.height / 2)
        player!.scale = Device.getAssetDimensionByKey("viking:Game")
        physicsWorld.addChild(player, z: 4)
        
        linhaEnergia = CCSprite(imageNamed: Device.getAssetByKey("energiaVerde"))
        linhaEnergia!.anchorPoint = CGPointMake(0, 0)
        linhaEnergia!.position = CGPointMake(0, 0)
        self.addChild(linhaEnergia, z: 2)
        
        self.userInteractionEnabled = true
        addChild(physicsWorld, z:3)
        
    }
    
    func getFinalX(point:CGPoint, distance:CGFloat, finalHeight:CGFloat) -> CGFloat {
        
        /*
        
        Primeiro eh calculado o seno do angulo da posicao do jogador (sen A) dentro do triangulo formado por ele e o toque do usuario:
        
        jogador -> toque = hipotenusa (distancia entre os dois pontos)
        jogador -> (toque.x,jogador.y) = cateto adjacente
        (toque.x,jogador.y) -> toque = cateto oposto
        
        sen A = toque.y / hipotenusa "inicial"
        
        O novo triangulo, formado pelo jogador e pelo ponto final, vai variar na hipotenusa e no cateto adjacente, mas a altura eh conhecida
        e o seno eh constante. Com isso calculamos o valor da hipotenusa "final"
        
        sen A = height / ?
        
        Em posse do valor da hipotenusa "final", voltamos ao coseno do cenario inicial
        
        cos A = toque.x / hipotenusa "inicial"
        
        E entao calculamos o cateto adjacente no novo cenario a partir do coseno de A e da hipotenusa final, calculados anteriormente
        
        cos A = ? / hipotenusa "final"
        
        */
        
        
        print("Calculando movimentacao de disparo...")
        print("Point: \(point)")
        print("Distance: \(distance)")
        print("Final Height: \(finalHeight)")
        
        let hipotenusaInicial = distance
        let seno = point.y / hipotenusaInicial
        let hipotenusaFinal = finalHeight / seno
        
        let coseno = point.x / hipotenusaInicial
        let catetoAdjacenteFinal = hipotenusaFinal * coseno
        return catetoAdjacenteFinal
    }
    
    override func touchBegan(touch: UITouch!, withEvent event: UIEvent!) {
        var point = CCDirector.sharedDirector().convertTouchToGL(touch)
        let finalHeight = (point.y > player!.position.y) ? Device.screenSize.height - player!.position.y :  player!.position.y
        let distance = ccpDistance(player!.position, point)
        var pointY = point.y
        if(point.y > player!.position.y) {
            pointY = point.y -  player!.position.y
        } else {
            pointY = player!.position.y - point.y
        }
        
        point = CGPointMake(point.x - player!.position.x, pointY)
        let finalX = getFinalX(point, distance: distance, finalHeight: finalHeight)
        print("Final X: \(finalX + player!.position.x)")
    }
    
    override func onEnter() {
        
        super.onEnter()
        
        gerarPirata()
    }
    
    func gerarPirata() {
        
        let pirataGerado = arc4random_uniform(10) + 1
        var pirata:Pirata
        if(pirataGerado > 3) {
            pirata = Pirata(imageNamed: SpriteMap.PirataPeixeFrame.rawValue, aQtdFrames: 18, initialSpeed: 6, initialHealth: 3, scoreGenerated: 3)
        } else {
            pirata = Pirata(imageNamed: SpriteMap.PirataPernetaFrame.rawValue, aQtdFrames: 18, initialSpeed: 3, initialHealth: 7, scoreGenerated: 7)
        }
        pirata.anchorPoint = CGPointMake(0.5, 0.5)
        pirata.position = CGPointMake(Device.screenSize.width + pirata.boundingBox().width / 2,
            CGFloat(arc4random_uniform(UInt32((linhaEnergia?.boundingBox().height)!) - UInt32(pirata.boundingBox().width / 2)) + UInt32(pirata.boundingBox().width / 2)))
        pirata.delegate = self
        if(pirata.position.y < player!.position.y) {
            physicsWorld.addChild(pirata, z: 4)
        } else {
            physicsWorld.addChild(pirata, z: 3)
        }
        pirata.mover(CGPointMake(0, pirata.position.y))
        DelayHelper.sharedInstance.callFunc("gerarPirata", onTarget: self, withDelay: delayGeracaoPiratas)
        
    }
    
    func powerUPGerado() {
        
    }
    
    func powerUPConsumido() {
        
    }

    override func update(delta: CCTime) {
        
    }
    
    override func onExit() {
        super.onExit()
    }
    
}