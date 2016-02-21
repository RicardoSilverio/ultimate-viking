//
//  HelloWorldScene.swift
//  CocosSwift
//
//  Created by Usuário Convidado on 03/02/16.
//  Copyright © 2016 Flameworks. All rights reserved.
//

import UIKit

class HelloWorldScene: CCScene {
    
    var label:CCLabelTTF?
    var label2:CCLabelBMFont?
    
    var imgButton:CCButton?
    
    var player:CCSprite?
    
    var rotate:CCAction?
    var jumpBy:CCAction?
    var scaleAction:CCAction?
    
    var paralaxNode:CCParallaxNode?
    var planoFundo:CCSprite?
    var planoFundo2:CCSprite?
    
    var fire:CCParticleSystem?
    var smoke:CCParticleSystem?
    
    // Drag n Drop do player
    var touchEnabled:Bool = false
    
    var physics:CCPhysicsNode?
    var piso:CCNode?
    var funilEsquerdo:CCNode?
    var funilDireito:CCNode?
    
    override init() {
        
        super.init()
        
        self.userInteractionEnabled = true
        
        physics = CCPhysicsNode()
        
        // Gravidade da Terra - Fisica Newtoniana
        physics?.gravity = CGPointMake(0, -980.65)
        self.addChild(physics, z:2)
        
        
        label = CCLabelTTF(string: "Hello World", fontName: "Arial", fontSize: 32.0)
        label!.color = CCColor.whiteColor()
        // Label invisivel
        label?.visible = false
        
        
        label2 = CCLabelBMFont(string: "Welcome to Cocos2D", fntFile: "myFont.fnt")
        label2?.position = CGPointMake(600, 500)

        
        let alert:UIAlertController = UIAlertController(title: "Hello World", message: "Welcome to Cocos2D", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        imgButton = CCButton(title: "", spriteFrame: CCSprite.spriteWithImageNamed("Playbutton.png").spriteFrame)
        imgButton!.block = {(sender:AnyObject!) -> Void in
            CCDirector.sharedDirector().presentViewController(alert, animated: true, completion: nil)
            (sender as! CCButton).runAction(self.scaleAction)
        }
        imgButton?.position = CGPointMake(400, 400)
        

        player = CCSprite(imageNamed: "player.png")
        player?.anchorPoint = CGPointMake(0 , 0)
        player?.position = CGPointMake(100, 300)
        player?.userInteractionEnabled = true

        
        print("bb1: \(player?.boundingBox().size.width), \(player?.boundingBox().height)")
        print("cb1: \(player?.contentSize.height), \(player?.contentSize.height)")
        
        player?.scale = 0.5
       
        print("bb2: \(player?.boundingBox().size.width), \(player?.boundingBox().height)")
        print("cb2: \(player?.contentSize.height), \(player?.contentSize.height)")
        
        
        paralaxNode = CCParallaxNode()
        planoFundo = CCSprite(imageNamed: "background.png")
        planoFundo?.position = CGPointMake(0, 0)
        planoFundo?.anchorPoint = CGPointMake(0, 0)
        planoFundo2 = CCSprite(imageNamed: "background.png")
        planoFundo2?.position = CGPointMake(0, 0)
        planoFundo2?.anchorPoint = CGPointMake(0, 0)
        
        self.paralaxNode?.position = CGPointMake(0, 0)
        self.paralaxNode?.anchorPoint = CGPointMake(0, 0)
        self.paralaxNode?.addChild(planoFundo, z: 1, parallaxRatio: CGPointMake(0.2, 0.0), positionOffset: CGPointMake(0.0, 0.0))
        self.paralaxNode?.addChild(planoFundo2, z: 1, parallaxRatio: CGPointMake(0.2, 0.0), positionOffset: CGPointMake((planoFundo?.contentSize.width)! - 10, 0))
        
        fire = CCParticleFireworks(totalParticles: 80)
        fire?.texture = CCSprite.spriteWithImageNamed("fire.png").texture
        fire?.position = CGPointMake(400, 200)
        fire?.autoRemoveOnFinish = true
        fire?.startColor = CCColor.redColor()
        fire?.endColor = CCColor.redColor()
        self.addChild(fire, z: 2)
        
        smoke = CCParticleSmoke(totalParticles: 400)
        smoke?.texture = CCSprite.spriteWithImageNamed("fire.png").texture
        smoke?.position = CGPointMake(800, 200)
        smoke?.autoRemoveOnFinish = true
        self.addChild(smoke, z: 2)
        
        piso = CCNode()
        piso?.physicsBody = CCPhysicsBody(rect: CGRectMake(0, 0, 1024, 5), cornerRadius: 0)
        piso?.physicsBody.type = .Static
        piso?.physicsBody.collisionCategories = ["borda"]
        piso?.physicsBody.collisionMask = ["pedra"]
        
        /*
        funilEsquerdo = CCSprite(imageNamed: "player.png")
        funilEsquerdo?.physicsBody = CCPhysicsBody(rect: CGRectMake(0, 768, 1024, 5), cornerRadius: 0)
        funilEsquerdo?.rotation = Float(-0.25 * M_PI)
        funilEsquerdo?.physicsBody.type = .Static
        funilEsquerdo?.physicsBody.collisionCategories = ["borda"]
        funilEsquerdo?.physicsBody.collisionMask = ["pedra"]
        
        funilDireito = CCSprite(imageNamed: "player.png")
        funilDireito?.physicsBody = CCPhysicsBody(rect: CGRectMake(1024, 768, 1024, 5), cornerRadius: 0)
        funilDireito?.rotation = -225
        funilDireito?.physicsBody.type = .Static
        funilDireito?.physicsBody.collisionCategories = ["borda"]
        funilDireito?.physicsBody.collisionMask = ["pedra"]
        */
        
        physics?.addChild(piso)
        //physics?.addChild(funilDireito)
        //physics?.addChild(funilEsquerdo)
        
        OALSimpleAudio.sharedInstance().preloadBg("bgMusic.mp3")
        OALSimpleAudio.sharedInstance().preloadEffect("fxSound.mp3")
        OALSimpleAudio.sharedInstance().bgVolume = 1.0
        OALSimpleAudio.sharedInstance().effectsVolume = 1.0
       
    }
    
    override func onEnter() {
        // Chamar a funcao no super eh obriogatorio para funcionar as animacoes
        super.onEnter()
        
        // Invisivel
        self.addChild(label, z: 2)

        
        self.addChild(label2, z:2)

       
        self.addChild(imgButton, z: 2)
        
        
        self.addChild(paralaxNode, z: 1)
        
        
        
        self.addChild(player, z: 2)
        
        
        rotate = CCActionRepeat.actionWithAction(CCActionRotateBy.actionWithDuration(3, angle: 360) as! CCActionInterval, times: 1) as? CCAction
        
        
        jumpBy = CCActionJumpBy.actionWithDuration(4, position: CGPointMake(0, 0), height: 200, jumps: 10) as? CCAction
        
        
        scaleAction = CCActionScaleBy.actionWithDuration(0.3, scale: 0) as? CCAction
        
        
        player!.runAction(rotate)
        label2?.runAction(jumpBy)
        
        OALSimpleAudio.sharedInstance().playBg()
        
      
    }
    
    override func update(delta: CCTime) {
        
        // Movimentacao do fundo no paralax node
        // Definindo a velocidade (para a esquerda por ser negativo)
        let backgroundScrollVel:CGPoint = CGPointMake(-500, 0)
        
        // Soma os pontos para realizar o deslocamento
        // No eixo x...
        let pt1:CGFloat = CGFloat(backgroundScrollVel.x * CGFloat(delta))
        // Eixo x e y (que fica igual nesse exemplo)
        let multiDelta:CGPoint = CGPointMake(pt1, backgroundScrollVel.y)
        // Seta nova posicao do paralax, movendo os seus conteúdos de acordo com o offset
        self.paralaxNode?.position = CGPointMake((self.paralaxNode?.position.x)! + multiDelta.x, 0.0)
        
        // Trata o offset dos elementos, resetando a posicao do paralax de acordo com a necessidade
        // O paralax se desloca numa velocidade muito maior que o planoFundo dentro dele, de forma que o primeiro fundo só vai esgotar quando o paralax tiver se deslocado 10x mais que o seu comprimento
        if(((self.paralaxNode?.convertToWorldSpace((self.planoFundo?.position)!).x)! * -1) > self.planoFundo?.contentSize.width){
            self.paralaxNode!.position = CGPointMake(0.0, 0.0)
        }
      
        
        
    }
    
    override func touchBegan(touch: UITouch!, withEvent event: UIEvent!) {
        
        /*
        
        Drag n Drop do player
        
        if(CGRectContainsPoint((player?.boundingBox())!, CCDirector.sharedDirector().convertTouchToGL(touch))) {
            touchEnabled = true
        }

        */
        
        
        if(physics!.children != nil) {
            for child in physics!.children {
                if(child.isKindOfClass(CCSprite) && child.name == "pedra") {
                    if(CGRectContainsPoint(child.boundingBox(), CCDirector.sharedDirector().convertTouchToGL(touch))) {
                        return
                    }
                }
            }
        }
        
        
        
        let pedra:CCSprite = CCSprite(imageNamed: "pedra.png")
        pedra.name = "pedra"
        pedra.anchorPoint = CGPointMake(0.5, 0.5)
        pedra.position = CCDirector.sharedDirector().convertTouchToGL(touch)
        
        pedra.physicsBody = CCPhysicsBody(rect: CGRectMake(0, 0, pedra.contentSize.width, pedra.contentSize.height), cornerRadius: 0)
        pedra.physicsBody.type = .Dynamic
        pedra.physicsBody.friction = 1
        pedra.physicsBody.elasticity = 0.5
        pedra.physicsBody.collisionCategories = ["pedra"]
        pedra.physicsBody.collisionMask = ["pedra", "borda"]
        pedra.physicsBody.mass = 100
        
        physics?.addChild(pedra, z:2)
        
        
        
        OALSimpleAudio.sharedInstance().playEffect("fxSound.mp3")

    }
    
    override func touchMoved(touch: UITouch!, withEvent event: UIEvent!) {
        
        /*
        
        Drag n Drop
        
        if(touchEnabled) {
            player?.position = CCDirector.sharedDirector().convertTouchToGL(touch)
        }


        */
    }
    
    override func touchEnded(touch: UITouch!, withEvent event: UIEvent!) {
        /*

        Drag n Drop
        touchEnabled = false

        */
    }
    
    
    override func onExit() {
        super.onExit()
        CCTextureCache.sharedTextureCache().removeAllTextures()
    }

}
