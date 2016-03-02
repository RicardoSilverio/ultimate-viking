//
//  GameScene.swift
//  CocosSwift
//
//  Created by Ricardo Silverio de Souza on 20/02/16.
//  Copyright © 2016 Flameworks. All rights reserved.
//

import Foundation
class GameScene : CCScene, PirataDelegate, CCPhysicsCollisionDelegate {
    
    private var canPlay = true
    private var isPaused = false
    private var canThrowAxe = true
    
    private var labelScore:CCLabelTTF?
    
    private var powerUPVisivel = false
    private var powerUPAtivo = false
    
    private var player:CCSprite?
    private var linhaEnergia:CCSprite?
    
    private var delayGeracaoPiratas:Double = 4
    private var physicsWorld = CCPhysicsNode()
    private var score = 0
    
    private var cor:CCColor?
    
    
    private var btnPause:CCButton?
    private var btnQuit:CCButton?
    
    
    
    override init() {
        super.init()
        
        physicsWorld.collisionDelegate = self
        
        labelScore = CCLabelTTF(string: "Score: \(score)", fontName: "Verdana", fontSize: CGFloat(Device.getAssetDimensionByKey("score:Game")))
        labelScore!.anchorPoint = CGPointMake(0.5, 0.5)
        labelScore!.position = CGPointMake(Device.screenSize.width / 2, Device.screenSize.height - (Device.screenSize.height * 0.05))
        labelScore!.color = CCColor.blackColor()
        self.addChild(labelScore, z: 5)
        
        let label:CCLabelTTF = CCLabelTTF(string:"Game Over - Tap to back to menu", fontName:"Verdana", fontSize:42.0)
        label.color = CCColor.redColor()
        label.shadowColor = CCColor.blackColor()
        label.shadowOffset = CGPointMake(2.0, -2.0)
        label.position = CGPointMake(self.screenSize.width/2, self.screenSize.height/2)
        label.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(label, z: 4)

        
        btnPause = CCButton(title: "[ Pause ]", fontName: "Verdana", fontSize: Device.getAssetDimensionByKey("button:Game"))
        btnPause!.position = CGPointMake(Device.screenSize.width - (Device.screenSize.width * 0.15), Device.screenSize.height - (Device.screenSize.height * 0.05))
        btnPause!.anchorPoint = CGPointMake(0.5, 0.5)
        btnPause!.color = CCColor.blackColor()
        btnPause!.block = {_ in
            CCDirector.sharedDirector().pause()
            self.canPlay = false
            self.isPaused = true
            self.btnPause!.visible = false
            self.btnQuit!.visible = false
        }
        self.addChild(btnPause, z:5)
        
        btnQuit = CCButton(title: "[ Quit ]", fontName: "Verdana", fontSize: Device.getAssetDimensionByKey("button:Game"))
        btnQuit!.position = CGPointMake(Device.screenSize.width - (Device.screenSize.width * 0.05), Device.screenSize.height - (Device.screenSize.height * 0.05))
        btnQuit!.anchorPoint = CGPointMake(0.5, 0.5)
        btnQuit!.color = CCColor.blackColor()
        btnQuit!.block = {_ in
            StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade: false)
        }
        self.addChild(btnQuit, z:5)
        
        let background = CCSprite(imageNamed: Device.getAssetByKey("cenario"))
        background.anchorPoint = CGPointMake(0.5, 0.5)
        background.position = CGPointMake(Device.screenSize.width / 2, Device.screenSize.height / 2)
        self.addChild(background)
        
        player = CCSprite(imageNamed: SpriteMap.Player.rawValue)
        cor = player!.color
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
        
        self.userInteractionEnabled = true
        
        
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
        if(canThrowAxe) {
            canThrowAxe = false
            var point = CCDirector.sharedDirector().convertTouchToGL(touch)
            let finalHeight = (point.y > player!.position.y) ? Device.screenSize.height - player!.position.y :  player!.position.y
            let distance = ccpDistance(player!.position, point)
            var pointY = point.y
            var atirouPraCima = false
            if(point.y > player!.position.y) {
                atirouPraCima = true
                pointY = point.y -  player!.position.y
            } else {
                pointY = player!.position.y - point.y
            }
        
            point = CGPointMake(point.x - player!.position.x, pointY)
            let finalX = getFinalX(point, distance: distance, finalHeight: finalHeight)
            print("Final X: \(finalX + player!.position.x)")
            
            let alvo = CGPointMake(finalX + player!.position.x, atirouPraCima ? Device.screenSize.height : 0)
            let tempoDeslocamento = getTempoDeslocamento(player!.position, fim: alvo, velocidadePorSegundo: Device.screenSize.width * 0.8)
            
            let tiro = Tiro(imageNamed: SpriteMap.Tiro.rawValue,
                alvo: alvo, tempoDeslocamento: tempoDeslocamento)
            tiro.anchorPoint = CGPointMake(0.5, 0.5)
            tiro.position = CGPointMake(player!.position.x + tiro.contentSize.width / 2, player!.position.y)
            tiro.scale = Device.getAssetDimensionByKey("tiro:Game")
            
            physicsWorld.addChild(tiro, z:4)
            tiro.lancar()
            DelayHelper.sharedInstance.callBlock({ () -> Void in
                self.canThrowAxe = true
            }, withDelay: 0.3)
        }
    }
    
    func getTempoDeslocamento(inicio:CGPoint, fim:CGPoint, velocidadePorSegundo:CGFloat) -> CGFloat {
        let tempo = CGFloat(ccpDistance(inicio, fim) / velocidadePorSegundo)
        return tempo
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
    
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, Tiro tiro:Tiro!, Pirata pirata:Pirata!) -> Bool {
        if(pirata.getAlive()) {
            score += pirata.receberDano(powerUPAtivo ? 3 : 1, podeGerarPowerUP: !powerUPVisivel && !powerUPAtivo)
            labelScore!.string = "Score: \(score)"
            tiro.stopAllActions()
            tiro.removeFromParentAndCleanup(true)
            if(!pirata.getAlive()) {
                gerarParticulas(pirata.position)
            }
        }
        return true
    }
    
    private func gerarParticulas(position:CGPoint) {
        let splash = CCParticleExplosion(totalParticles: 20)
        splash.texture = CCSprite.spriteWithImageNamed(SpriteMap.Fire.rawValue).texture
        splash.position = position
        splash.startColor = CCColor.orangeColor()
        splash.endColor = CCColor.redColor()
        splash.anchorPoint = CGPointMake(0, 0)
        splash.autoRemoveOnFinish = true
        self.addChild(splash, z: 4)
    }
    
    func powerUPGerado() {
        powerUPVisivel = true
    }
    
    func powerUPConsumido() {
        powerUPVisivel = false
        powerUPAtivo = true
        player!.color = CCColor.redColor()
        DelayHelper.sharedInstance.callFunc("desativarPowerUP", onTarget: self, withDelay: 10)
    }
    
    func desativarPowerUP() {
        powerUPAtivo = false
        player!.color = cor
    }

    override func update(delta: CCTime) {
        
    }
    
    override func onExit() {
        super.onExit()
    }
    
    deinit {
        CCTextureCache.sharedTextureCache().removeAllTextures()
    }
    
}