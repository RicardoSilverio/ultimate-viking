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

class Device {
    
    /*
        iPad = 1024x768
        iPhone (4s) = 480x320
        iPhone (5+) = 568x320
    */
    
    static let screenSize:CGSize = CCDirector.sharedDirector().viewSize()
    private static var isHighDefinition:Bool?
    private static var deviceType:DeviceType?
    private static var assetDictionary:[String:String] = [String:String]()
    private static var assetDimensionsDictionary:[String:Float] = [String:Float]()
    
    class func isHDResolution() -> Bool {
        if(isHighDefinition == nil) {
            if(screenSize.width == 1024 && screenSize.height == 768) {
                isHighDefinition = true
            } else {
                isHighDefinition = false
            }
        }
        return false
    }
    
    class func getDeviceType() -> DeviceType {
        if(deviceType == nil) {
            deviceType = (isHDResolution() ? DeviceType.iPad : screenSize.width == 568 ? DeviceType.iPhone5 : DeviceType.iPhone4s)
        }
        return deviceType!
    }
    
    class func putAssetKey(key:String, withValue:String) {
        assetDictionary[key] = withValue;
    }
    
    class func putAssetDimensionKey(key:String, withValue:Float) {
        assetDimensionsDictionary[key] = withValue
    }
    
    class func getAssetByKey(key:String) -> String {
        if let asset = assetDictionary[key] {
            return asset
        } else {
            return ""
        }
    }
    
    class func getAssetDimensionByKey(key:String) -> Float {
        if let assetDimension = assetDimensionsDictionary[key] {
            return assetDimension
        } else {
            return 0
        }
    }
}