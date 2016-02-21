//
//  HomeScene.swift
//  CocosSwift
//
//  Created by Thales Toniolo on 10/09/14.
//  Copyright (c) 2014 Flameworks. All rights reserved.
//
import Foundation

class HomeScene : CCScene {

	override init() {
		super.init()

        let background = CCSprite(imageNamed: Device.getAssetByKey("bgCenario"))
        background.anchorPoint = CGPointMake(0.5, 0.5)
        background.position = CGPointMake(Device.screenSize.width / 2, Device.screenSize.height / 2)
        self.addChild(background)
        
        let labelTitle = CCLabelTTF(string: "The Ultimate Viking", fontName: "Marker Felt", fontSize: CGFloat(Device.getAssetDimensionByKey("title:Home")))
        labelTitle.anchorPoint = CGPointMake(0.5, 0.5)
        labelTitle.position = CGPointMake(Device.screenSize.width / 2, Device.screenSize.height - (Device.screenSize.height * 0.25))
        labelTitle.color = CCColor.blackColor()
        self.addChild(labelTitle, z: 2)
        
        let spriteViking = CCSprite(imageNamed: Device.getAssetByKey("player"))
        spriteViking.anchorPoint = CGPointMake(0.5, 0.5)
        spriteViking.position = CGPointMake(Device.screenSize.width * 0.25, Device.screenSize.height / 2)
        spriteViking.scale = Device.getAssetDimensionByKey("viking:Home")
        self.addChild(spriteViking, z: 2)
        
        let spritePirataPerneta = CCSprite(spriteFrame: CCSpriteFrameCache.sharedSpriteFrameCache().spriteFrameByName("Pirata 10001.png"))
        spritePirataPerneta.anchorPoint = CGPointMake(0.5, 0.5)
        spritePirataPerneta.position = CGPointMake(Device.screenSize.width - (Device.screenSize.width * 0.1), spriteViking.position.y + (spriteViking.position.y * 0.25))
        spritePirataPerneta.scale = Device.getAssetDimensionByKey("pirataPerneta:Home")
        self.addChild(spritePirataPerneta, z: 2)
        
        let spritePirataPeixe = CCSprite(spriteFrame: CCSpriteFrameCache.sharedSpriteFrameCache().spriteFrameByName("Pirata 20001.png"))
        spritePirataPeixe.anchorPoint = CGPointMake(0.5, 0.5)
        spritePirataPeixe.position = CGPointMake(Device.screenSize.width - (Device.screenSize.width * 0.25), spriteViking.position.y - (spriteViking.position.y * 0.25))
        spritePirataPeixe.scale = Device.getAssetDimensionByKey("pirataPeixe:Home")
        self.addChild(spritePirataPeixe, z: 2)
        
        let toGameButton:CCButton = CCButton(title: "[ Start ]", fontName: "Verdana", fontSize: Device.getAssetDimensionByKey("button:Home"))
        toGameButton.position = CGPointMake(Device.screenSize.width/2.0, Device.screenSize.height/2.0)
        toGameButton.anchorPoint = CGPointMake(0.5, 0.5)
        toGameButton.color = CCColor.blackColor()
        toGameButton.block = {_ in

        }
        self.addChild(toGameButton, z:2)
        
        let highScore = NSUserDefaults.standardUserDefaults().valueForKey("highScore")
        let labelHighScore = CCLabelTTF(string: "High Score: \(highScore!)", fontName: "Verdana", fontSize: CGFloat(Device.getAssetDimensionByKey("highScore:Home")))
        labelHighScore.anchorPoint = CGPointMake(0.5, 0.5)
        labelHighScore.position = CGPointMake(Device.screenSize.width / 2, Device.screenSize.height - (Device.screenSize.height * 0.80))
        labelHighScore.color = CCColor.blackColor()
        self.addChild(labelHighScore, z: 2)
        
        
        //CCSpriteFrameCache.sharedSpriteFrameCache().spriteFrameByName(name)
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
