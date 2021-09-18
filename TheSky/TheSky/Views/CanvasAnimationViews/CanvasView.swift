//
//  AnimationCanvasView.swift
//  TheSky
//
//  Created by Omar Farooq on 9/16/21.
//

import UIKit


class CanvasView: UIView {

    var currentAnimation: CanvasAnimationType?

    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        return gradient
    }()

    func setupLayout() {
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }

    func addCanvasAnimation(animation: CanvasAnimationType){
        currentAnimation?.dismiss()
        gradient.colors = animation.gradientColors
        checkAndAddAnimation(animation: animation)
    }

    // Check weather new animation already exists in the hierarchy and if it does
    // prevent the view from removing itself
    private func checkAndAddAnimation(animation: CanvasAnimationType) {
        let result = subviews.filter { (view) -> Bool in
            return type(of: view) == type(of: animation)
        }
        guard result.isEmpty else {
            let anim = (result[0] as? CanvasAnimationType)
            anim?.retain()
            currentAnimation = anim
            return
            
        }
        addSubview(animation)
        currentAnimation = animation
        currentAnimation?.setupForCanvas()
        currentAnimation?.present()
    }

    func removeCurrentAnimation() {
        currentAnimation?.dismiss()
    }
}
