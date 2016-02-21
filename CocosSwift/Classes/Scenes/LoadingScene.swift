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
        
        CCFileUtils.sharedFileUtils().setiPadRetinaDisplaySuffix("")
        CCFileUtils.sharedFileUtils().setiPadSuffix("")
        CCFileUtils.sharedFileUtils().setiPhoneRetinaDisplaySuffix("")
        
        
        OALSimpleAudio.sharedInstance().stopEverything()
        
        if(Device.isHDResolution()) {
            Device.putAssetKey("bgCenario", withValue: "bgCenario-ipadhd.png")
            
            Device.putAssetKey("player", withValue: "player-ipadhd.png")
            Device.putAssetKey("tiro", withValue: "tiro-ipadhd.png")
            
            Device.putAssetKey("PirataPeixe", withValue: "PirataPeixe-ipadhd.plist")
            Device.putAssetKey("PirataPerneta", withValue: "PirataPerneta-ipadhd.plist")
            
            Device.putAssetKey("energiaVerde", withValue: "energiaVerde-ipadhd.png")
            Device.putAssetKey("energiaAmarela", withValue: "energiaAmarela-ipadhd.png")
            Device.putAssetKey("energiaVermelha", withValue: "energiaVermelha-ipadhd.png")
            
            Device.putAssetKey("powerUP", withValue: "powerUP-ipadhd.png")
            Device.putAssetKey("fire", withValue: "fire-ipadhd.png")
            
            
        } else {
            Device.putAssetKey("bgCenario", withValue: "bgCenario-ipad.png")
            
            Device.putAssetKey("player", withValue: "player-ipad.png")
            Device.putAssetKey("tiro", withValue: "tiro-ipad.png")
            
            Device.putAssetKey("PirataPeixe", withValue: "PirataPeixe-ipad.plist")
            Device.putAssetKey("PirataPerneta", withValue: "PirataPerneta-ipad.plist")
            
            Device.putAssetKey("energiaVerde", withValue: "energiaVerde-ipad.png")
            Device.putAssetKey("energiaAmarela", withValue: "energiaAmarela-ipad.png")
            Device.putAssetKey("energiaVermelha", withValue: "energiaVermelha-ipad.png")
            
            Device.putAssetKey("powerUP", withValue: "powerUP-ipad.png")
            Device.putAssetKey("fire", withValue: "fire-ipad.png")
        }
        
        CCSpriteFrameCache.sharedSpriteFrameCache().addSpriteFramesWithFile(Device.getAssetByKey("PirataPeixe"))
        CCSpriteFrameCache.sharedSpriteFrameCache().addSpriteFramesWithFile(Device.getAssetByKey("PirataPerneta"))
        
        switch(Device.getDeviceType()) {
            case DeviceType.iPad :
                Device.putAssetDimensionKey("title:Home", withValue: 72)
                Device.putAssetDimensionKey("button:Home", withValue: 38)
                Device.putAssetDimensionKey("highScore:Home", withValue: 38)
                Device.putAssetDimensionKey("viking:Home", withValue: 2.5)
                Device.putAssetDimensionKey("pirataPerneta:Home", withValue: 2.5)
                Device.putAssetDimensionKey("pirataPeixe:Home", withValue: 2.5)
            case DeviceType.iPhone5 :
                Device.putAssetDimensionKey("title:Home", withValue: 35)
                Device.putAssetDimensionKey("button:Home", withValue: 24)
                Device.putAssetDimensionKey("highScore:Home", withValue: 24)
                Device.putAssetDimensionKey("viking:Home", withValue: 1)
                Device.putAssetDimensionKey("pirataPerneta:Home", withValue: 1)
                Device.putAssetDimensionKey("pirataPeixe:Home", withValue: 1)
            default :
                Device.putAssetDimensionKey("title:Home", withValue: 35)
                Device.putAssetDimensionKey("button:Home", withValue: 24)
                Device.putAssetDimensionKey("highScore:Home", withValue: 24)
                Device.putAssetDimensionKey("viking:Home", withValue: 1)
                Device.putAssetDimensionKey("pirataPerneta:Home", withValue: 1)
                Device.putAssetDimensionKey("pirataPeixe:Home", withValue: 1)
        }
        
        
        Device.putAssetKey("music", withValue: "MusicInGame.mp3")
        Device.putAssetKey("tap", withValue: "SoundFXButtonTap.mp3")
        Device.putAssetKey("puf", withValue: "SoundFXPuf.mp3")
        
        OALSimpleAudio.sharedInstance().preloadBg(Device.getAssetByKey("music"))
        OALSimpleAudio.sharedInstance().preloadEffect(Device.getAssetByKey("tap"))
        OALSimpleAudio.sharedInstance().preloadEffect(Device.getAssetByKey("puf"))
        
        if(NSUserDefaults.standardUserDefaults().valueForKey("highScore") == nil) {
            NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "highScore")
        }
        
        OALSimpleAudio.sharedInstance().playEffect(Device.getAssetByKey("tap"))
        StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade: true)
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