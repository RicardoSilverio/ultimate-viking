//
//  StateMachine.swift
//  CocosSwift
//
//  Created by Usuário Convidado on 19/02/16.
//  Copyright © 2016 Flameworks. All rights reserved.
//

import Foundation

enum StateMachineScenes {
    case LoadingScene
    case HomeScene
    case GameScene
}


class StateMachine {
    
    class var sharedInstance:StateMachine {
        struct Static {
            static var instance: StateMachine?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Static.token) {
            Static.instance = StateMachine()
        }
        return Static.instance!
    }
    
    private func retrieveScene(scene:StateMachineScenes) -> CCScene
    {
        switch (scene) {
        case StateMachineScenes.LoadingScene:
            return LoadingScene()
        case StateMachineScenes.HomeScene:
            return HomeScene()
        case StateMachineScenes.GameScene:
            return GameScene()
        default:
            return CCScene()
        }
    }
    
    private func checkAndInitializeScene(scene:StateMachineScenes) -> CCScene {
                // Interrope todas as acoes do director
                CCDirector.sharedDirector().actionManager.removeAllActions()
                // Recupera a cena atual
                let currentScene:CCScene = CCDirector.sharedDirector().runningScene
                // Configura a proxima cena a ser executada
                let newScene:CCScene = retrieveScene(scene)
                return newScene
    }
    
    func changeScene(scene:StateMachineScenes, isFade:Bool) {
            let newScene:CCScene = checkAndInitializeScene(scene)
            // Controle do director
            if (CCDirector.sharedDirector().runningScene == nil) {
            CCDirector.sharedDirector().runWithScene(newScene)
        } else {
            if (isFade) {
            CCDirector.sharedDirector().replaceScene(newScene, withTransition:CCTransition(fadeWithDuration: 0.4))
        } else {
            CCDirector.sharedDirector().replaceScene(newScene)
            }
            } }
}

