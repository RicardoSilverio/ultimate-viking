//
//  GameScene.swift
//  CocosSwift
//
//  Created by Ricardo Silverio de Souza on 20/02/16.
//  Copyright © 2016 Flameworks. All rights reserved.
//

import Foundation
class GameScene : CCScene {
    
    private var canPlay:Bool = true
    private var canThrowAxe = true
    
    private var player:CCSprite?
    private var linhaEnergia:CCSprite?
    
    
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
        self.addChild(player, z: 3)
        
        linhaEnergia = CCSprite(imageNamed: Device.getAssetByKey("energiaVerde"))
        linhaEnergia!.anchorPoint = CGPointMake(0, 0)
        linhaEnergia!.position = CGPointMake(0, 0)
        self.addChild(linhaEnergia, z: 2)
        
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
    }
    
    override func update(delta: CCTime) {
        
    }
    
    override func onExit() {
        super.onExit()
    }
    
}