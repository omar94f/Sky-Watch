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
        currentAnimation = animation
        gradient.colors = animation.gradientColors
        addSubview(animation)
        currentAnimation?.setupForCanvas()
        currentAnimation?.present()
    }

    func removeCurrentAnimation() {
        currentAnimation?.dismiss()
    }
}
