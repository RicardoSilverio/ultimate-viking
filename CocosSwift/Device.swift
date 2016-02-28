//
//  Device.swift
//  CocosSwift
//
//  Created by Ricardo Silverio de Souza on 20/02/16.
//  Copyright © 2016 Flameworks. All rights reserved.
//

import Foundation

enum DeviceType {
    case iPad
    case iPhone4s
    case iPhone5
}

enum ScreenType {
    case iPad
    case iPhonePlus
    case iPhone5
    case iPhone4s
}

enum SpriteMap : String {
    case Cenario = "bgCenario.png"
    case Cenario4s = "bgCenario4s.png"
    case Cenario5 = "bgCenario5.png"
    case CenarioPlus = "bgCenarioPlus.png"
    case Player = "player.png"
    case PirataPeixeSheet = "PirataPeixe.plist"
    case PirataPeixeFrame = "Pirata 100"
    case PirataPernetaSheet = "PirataPerneta.plist"
    case PirataPernetaFrame = "Pirata 200"
    case EnergiaVerde = "energiaVerde.png"
    case EnergiaVerde4s = "energiaVerde4s.png"
    case EnergiaVerde5 = "energiaVerde5.png"
    case EnergiaVerdePlus = "energiaVerdePlus.png"
    case EnergiaAmarela = "energiaAmarela.png"
    case EnergiaAmarela4s = "energiaAmarela4s.png"
    case EnergiaAmarela5 = "energiaAmarela5.png"
    case EnergiaAmarelaPlus = "energiaAmarelaPlus.png"
    case EnergiaVermelha = "energiaVermelha.png"
    case EnergiaVermelha4s = "energiaVermelha4s.png"
    case EnergiaVermelha5 = "energiaVermelha5.png"
    case EnergiaVermelhaPlus = "energiaVermelhaPlus.png"
    case Tiro = "tiro.png"
    case PowerUp = "powerUP.png"
    case Fire = "fire.png"
}

class Device {
    
    /*
        DeviceType -> aquilo que determina distancias e movimentacao
    
        iPad = 1024x768
        iPhone (4s) = 480x320 (scale = 0.46875)
        iPhone (5+) = 568x320 (scale = 0.5546875)
    */
    
    /*
        ScreenType -> aquilo que determina o tamanho dos sprites (as resolucoes dos iPads ja estao otimizadas para carregamento do Cocos de acordo com o                              sufixo da imagem e ficam no mesmo "tamanho" em tela, enquanto a dos iPhones exige 3 diferentes adaptacoes)
    
        iPad = 1024x768 ou 2048x1536
        iPhone 4s = 960x640
        iPhone 5/6 = 1136x640
        iPhone Plus = 1704x960 -> Apesar da resolucao alta, o Cocos interpreta os devices xPlus de uma forma estranha, alem de carregar os sprites sem o sufixo "hd", ao contrario dos iPhones 5 e 6
    */
    
    static let screenSizeInPixels = CCDirector.sharedDirector().viewSizeInPixels()
    static let screenSize:CGSize = CCDirector.sharedDirector().viewSize()
    private static var deviceType:DeviceType?
    private static var screenType:ScreenType?
    private static var assetDictionary:[String:String] = [String:String]()
    private static var assetDimensionsDictionary:[String:Float] = [String:Float]()
    
    class func getDeviceType() -> DeviceType {
        if(deviceType == nil) {
            deviceType = (screenSize.width == 1024 ? DeviceType.iPad : screenSize.width == 568 ? DeviceType.iPhone5 : DeviceType.iPhone4s)
        }
        return deviceType!
    }
    
    class func getScreenType() -> ScreenType {
        if(screenType == nil) {
            if(screenSize.width == 1024) {
                screenType = ScreenType.iPad
            } else if(screenSizeInPixels.width == 960) {
                screenType = ScreenType.iPhone4s
            } else if(screenSizeInPixels.width == 1136) {
                screenType = ScreenType.iPhone5
            } else if(screenSizeInPixels.width == 1704) {
                screenType = ScreenType.iPhonePlus
            }
        }
        return screenType!
    }
    
    class func putAssetDimensionKey(key:String, withValue:Float) {
        assetDimensionsDictionary[key] = withValue
    }
    
    class func putAssetKey(key:String, withValue:SpriteMap) {
        assetDictionary[key] = withValue.rawValue
    }
    
    class func getAssetDimensionByKey(key:String) -> Float {
        if let assetDimension = assetDimensionsDictionary[key] {
            return assetDimension
        } else {
            return 0
        }
    }
    
    class func getAssetByKey(key:String) -> String {
        if let asset = assetDictionary[key] {
            return asset
        } else {
            return ""
        }

    }
}