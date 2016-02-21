//
//  DelayHelper.swift
//  CocosSwift
//
//  Created by Usuário Convidado on 19/02/16.
//  Copyright © 2016 Flameworks. All rights reserved.
//

import Foundation
class DelayHelper {
    
    public class var sharedInstance:DelayHelper {
        struct Static {
        static var instance: DelayHelper?
        static var token: dispatch_once_t = 0
        }
        dispatch_once(&Static.token) {
        Static.instance = DelayHelper()
        }
        return Static.instance!
    }
    
    public func callFunc(aFunc:Selector, onTarget:AnyObject,
            withDelay:CCTime) {
            // Monta o metodo com o delay informado
            let delayAction:CCActionSequence = CCActionSequence(
            one:
            (CCActionDelay.actionWithDuration(withDelay) as!
            CCActionFiniteTime),
            two:
            (CCActionCallFunc.actionWithTarget(onTarget, selector:aFunc) as!
            CCActionFiniteTime))
            // Invoca pelo director
            CCDirector.sharedDirector().actionManager.addAction(delayAction,
            target:self, paused:false)
    }
    
    public func callBlock(aBlock:(() -> Void), withDelay:CCTime) {
            // Monta o bloco com o delay informado
            let delayAction:CCActionSequence = CCActionSequence(
            one:(CCActionDelay.actionWithDuration(withDelay) as!
            CCActionFiniteTime),
            two:(CCActionCallBlock.actionWithBlock(aBlock) as!
            CCActionFiniteTime))
            // Invoca pelo director
            CCDirector.sharedDirector().actionManager.addAction(delayAction,
            target:self, paused:false)
    }
    
}