//
//  LoadingScene.swift
//  CocosSwift
//
//  Created by Ricardo Silverio de Souza on 20/02/16.
//  Copyright © 2016 Flameworks. All rights reserved.
//

import Foundation
class LoadingScene : CCScene {
    

    override init() {
        super.init()
        
        let background:CCNodeColor = CCNodeColor(color: CCColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0))
        self.addChild(background)
        
        let label = CCLabelTTF(string: "Loading...", fontName: "Arial", fontSize: 32.0)
        label!.color = CCColor.redColor()
        label.anchorPoint = CGPointMake(0.5, 0.5)
        label.position = CGPointMake(Device.screenSize.width / 2, Device.screenSize.height / 2)
        self.addChild(label)
        
    }
    
    override func onEnter() {
       
        super.onEnter()
        
        SoundplayHelper.sharedInstance.stopEverything()
        
        CCSpriteFrameCache.sharedSpriteFrameCache().addSpriteFramesWithFile(SpriteMap.PirataPeixeSheet.rawValue)
        CCSpriteFrameCache.sharedSpriteFrameCache().addSpriteFramesWithFile(SpriteMap.PirataPernetaSheet.rawValue)
        
        switch(Device.getScreenType()) {
            case ScreenType.iPad:
                Device.putAssetKey("cenario", withValue: SpriteMap.Cenario)
                Device.putAssetKey("energiaVerde", withValue: SpriteMap.EnergiaVerde)
                Device.putAssetKey("energiaAmarela", withValue: SpriteMap.EnergiaAmarela)
                Device.putAssetKey("energiaVermelha", withValue: SpriteMap.EnergiaVermelha)
                Device.putAssetDimensionKey("title:Home", withValue: 72)
                Device.putAssetDimensionKey("button:Home", withValue: 38)
                Device.putAssetDimensionKey("highScore:Home", withValue: 38)
                Device.putAssetDimensionKey("viking:Home", withValue: 2.5)
                Device.putAssetDimensionKey("viking:Game", withValue: 1.2)
                Device.putAssetDimensionKey("viking:margin:Game", withValue: 75)
                Device.putAssetDimensionKey("pirataPerneta:Home", withValue: 2.5)
                Device.putAssetDimensionKey("pirataPeixe:Home", withValue: 2.5)
                Device.putAssetDimensionKey("pirata:Game", withValue: 1)
                Device.putAssetDimensionKey("tiro:Game", withValue: 1)
                Device.putAssetDimensionKey("score:Game", withValue: 20)
                Device.putAssetDimensionKey("button:Game", withValue: 20)
            case ScreenType.iPhonePlus:
                Device.putAssetKey("cenario", withValue: SpriteMap.CenarioPlus)
                Device.putAssetKey("energiaVerde", withValue: SpriteMap.EnergiaVerdePlus)
                Device.putAssetKey("energiaAmarela", withValue: SpriteMap.EnergiaAmarelaPlus)
                Device.putAssetKey("energiaVermelha", withValue: SpriteMap.EnergiaVermelhaPlus)
                Device.putAssetDimensionKey("title:Home", withValue: 35)
                Device.putAssetDimensionKey("button:Home", withValue: 24)
                Device.putAssetDimensionKey("highScore:Home", withValue: 24)
                Device.putAssetDimensionKey("viking:Home", withValue: 1)
                Device.putAssetDimensionKey("viking:Game", withValue: 0.5)
                Device.putAssetDimensionKey("viking:margin:Game", withValue: 35)
                Device.putAssetDimensionKey("pirataPerneta:Home", withValue: 1)
                Device.putAssetDimensionKey("pirataPeixe:Home", withValue: 1)
                Device.putAssetDimensionKey("pirata:Game", withValue: 0.4)
                Device.putAssetDimensionKey("tiro:Game", withValue: 0.5)
                Device.putAssetDimensionKey("score:Game", withValue: 12)
                Device.putAssetDimensionKey("button:Game", withValue: 12)
            case ScreenType.iPhone5:
                Device.putAssetKey("cenario", withValue: SpriteMap.Cenario5)
                Device.putAssetKey("energiaVerde", withValue: SpriteMap.EnergiaVerde5)
                Device.putAssetKey("energiaAmarela", withValue: SpriteMap.EnergiaAmarela5)
                Device.putAssetKey("energiaVermelha", withValue: SpriteMap.EnergiaVermelha5)
                Device.putAssetDimensionKey("title:Home", withValue: 35)
                Device.putAssetDimensionKey("button:Home", withValue: 24)
                Device.putAssetDimensionKey("highScore:Home", withValue: 24)
                Device.putAssetDimensionKey("viking:Home", withValue: 1.8)
                Device.putAssetDimensionKey("viking:Game", withValue: 1)
                Device.putAssetDimensionKey("viking:margin:Game", withValue: 35)
                Device.putAssetDimensionKey("pirataPerneta:Home", withValue: 0.5)
                Device.putAssetDimensionKey("pirataPeixe:Home", withValue: 0.5)
                Device.putAssetDimensionKey("pirata:Game", withValue: 0.25)
                Device.putAssetDimensionKey("tiro:Game", withValue: 1)
                Device.putAssetDimensionKey("score:Game", withValue: 15)
                Device.putAssetDimensionKey("button:Game", withValue: 15)
            default:
                Device.putAssetKey("cenario", withValue: SpriteMap.Cenario4s)
                Device.putAssetKey("energiaVerde", withValue: SpriteMap.EnergiaVerde4s)
                Device.putAssetKey("energiaAmarela", withValue: SpriteMap.EnergiaAmarela4s)
                Device.putAssetKey("energiaVermelha", withValue: SpriteMap.EnergiaVermelha4s)
                Device.putAssetDimensionKey("title:Home", withValue: 35)
                Device.putAssetDimensionKey("button:Home", withValue: 24)
                Device.putAssetDimensionKey("highScore:Home", withValue: 24)
                Device.putAssetDimensionKey("viking:Home", withValue: 1.8)
                Device.putAssetDimensionKey("viking:Game", withValue: 1)
                Device.putAssetDimensionKey("viking:margin:Game", withValue: 35)
                Device.putAssetDimensionKey("pirataPerneta:Home", withValue: 0.5)
                Device.putAssetDimensionKey("pirataPeixe:Home", withValue: 0.5)
                Device.putAssetDimensionKey("pirata:Game", withValue: 0.25)
                Device.putAssetDimensionKey("score:Game", withValue: 15)
                Device.putAssetDimensionKey("button:Game", withValue: 15)
        }
        
        SoundplayHelper.sharedInstance.preloadSoundsAndMusic()
        
        if(NSUserDefaults.standardUserDefaults().valueForKey("highScore") == nil) {
            NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "highScore")
        }
        
        SoundplayHelper.sharedInstance.playEffect(SoundplayHelperEffect.Tap)
        DelayHelper.sharedInstance.callFunc("changeScene", onTarget: self, withDelay: 1)
        
    }
    
    func changeScene() {
        StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade: false)
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