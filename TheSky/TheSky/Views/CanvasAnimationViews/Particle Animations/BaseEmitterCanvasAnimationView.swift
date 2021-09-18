//
//  BaseEmitterCanvasAnimationView.swift
//  TheSky
//
//  Created by Omar Farooq on 9/18/21.
//

import UIKit

class BaseEmitterCanvasAnimationView: UIView {

    private var shouldRemove = true

    lazy var emitter: CAEmitterLayer = {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.frame = bounds
        emitterLayer.emitterPosition = CGPoint(x: bounds.midX, y: layoutMargins.top)
        emitterLayer.emitterSize = CGSize(width: bounds.width, height: 1)
        emitterLayer.emitterShape = .line
        emitterLayer.masksToBounds = true

        return emitterLayer
    }()

    internal func setupLayers() {
        layer.addSublayer(emitter)
    }

    func setupForCanvas() {
        setupLayers()
    }

    func present() {
        emitter.birthRate = 1
    }
    
    func retain() {
        shouldRemove = false
        alpha = 1
    }

    func dismiss() {
        UIView.animate(withDuration: 0.8) {
            [weak self] in
            self?.alpha = 0
        } completion: { [weak self] _ in
            guard let self = self else {return}
            if self.shouldRemove {
                self.removeFromSuperview()
            } else {
                self.shouldRemove = true
            }
        }
    }
}
