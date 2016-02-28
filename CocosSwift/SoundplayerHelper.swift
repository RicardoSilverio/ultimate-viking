//
//  SoundplayerHelper.swift
//  CocosSwift
//
//  Created by Usuário Convidado on 24/02/16.
//  Copyright © 2016 Flameworks. All rights reserved.
//

import Foundation

enum SoundplayHelperEffect : String {
    case Puf = "SoundFXPuf.mp3"
    case Tap = "SoundFXButtonTap.mp3"
}

class SoundplayHelper {
    
    private static let instance:OALSimpleAudio = OALSimpleAudio.sharedInstance()
    static let sharedInstance:SoundplayHelper = SoundplayHelper()
    
    private let music = "MusicInGame.mp3"
    private let effects:[SoundplayHelperEffect] = [SoundplayHelperEffect.Puf, SoundplayHelperEffect.Tap]
    
    private init() {}
    
    func preloadSoundsAndMusic() {
        for effect in effects {
            SoundplayHelper.instance.preloadEffect(effect.rawValue)
        }
        SoundplayHelper.instance.preloadBg(music)
    }
    
    func setMusicDefaultVolume() {
        SoundplayHelper.instance.bgVolume = 0.5
    }
    
    func playMusic() {
        SoundplayHelper.instance.playBg()
    }
    
    func playEffect(effect:SoundplayHelperEffect) {
        SoundplayHelper.instance.playEffect(effect.rawValue)
    }
    
    func stopMusic() {
        SoundplayHelper.instance.stopBg()
    }
    
    func stopEverything() {
        SoundplayHelper.instance.stopEverything()
    }
    
}