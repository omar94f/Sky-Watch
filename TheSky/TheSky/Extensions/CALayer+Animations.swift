//
//  LayerExtension.swift
//  TheSky
//
//  Created by Omar Farooq on 9/14/21.
//

import UIKit

extension CALayer {

    func addAnimationWithDelay(animation: CAAnimation, forKey: String, delay: Double = 0){
        animation.beginTime = CACurrentMediaTime() + delay
        self.add(animation, forKey: forKey)
    }
}
