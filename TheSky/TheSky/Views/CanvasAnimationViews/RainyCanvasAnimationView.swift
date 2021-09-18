//
//  RainyCanvasAnimationView.swift
//  TheSky
//
//  Created by Omar Farooq on 9/18/21.
//

import UIKit


class RainyCanvasAnimationView: UIView {

    var gradientColors: [CGColor]  {
        return [#colorLiteral(red: 0.490050183, green: 0.6859143806, blue: 0.792872958, alpha: 1), #colorLiteral(red: 0.2095845228, green: 0.403395012, blue: 0.6734380265, alpha: 1)].map{ $0.cgColor}
    }

    private var shouldRemove = true

    private lazy var rainCell: CAEmitterCell = {
        let cell = CAEmitterCell()
        cell.birthRate = 100
        cell.lifetime = 1
        cell.lifetimeRange = 0
        cell.velocity = 650
        cell.velocityRange = 150
        cell.emissionLongitude = .pi
        cell.scale = 1
        cell.scaleRange = 0.5
        cell.color = UIColor.white.cgColor

        let rectangle = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 5))
        rectangle.layer.backgroundColor = UIColor.white.cgColor
        rectangle.layer.opacity = 0.3
        cell.contents = rectangle.asImage().cgImage

        return cell
    }()

    private lazy var cloud: CanvasViewType = {
        let cloudHeight = bounds.height * 0.15
        let cloudWidth = bounds.midX
        let frame = CGRect(x: bounds.quarterWidth + bounds.quarterWidth/3,
                           y: bounds.minY + 0,
                           width: cloudWidth,
                           height: cloudHeight)
        let cloud = CloudView(frame: frame, cloudOpacity: 0.8, sunColor: #colorLiteral(red: 0.5710252259, green: 0.6179517671, blue: 0.6833361779, alpha: 1))
        return cloud
    }()

    private lazy var emitter: CAEmitterLayer = {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.frame = bounds
        emitterLayer.emitterPosition = CGPoint(x: bounds.midX, y: layoutMargins.top)
        emitterLayer.emitterSize = CGSize(width: bounds.width, height: 1)
        emitterLayer.emitterShape = .line
        emitterLayer.masksToBounds = true

        emitterLayer.emitterCells = [rainCell]
        return emitterLayer
    }()

    func setupLayers() {

        layer.addSublayer(emitter)
    }

}

extension RainyCanvasAnimationView: CanvasAnimationType {

    func setupForCanvas() {
        setupLayers()
        cloud.setupForCanvas()
        cloud.layer.transform = CATransform3DMakeScale(1.7, -1.5, 1)
        addSubview(cloud)
    }

    func present() {
        emitter.beginTime = CACurrentMediaTime()
        emitter.birthRate = 1
        
    }
    func retain() {
        shouldRemove = false
        alpha = 1
    }

    func dismiss() {
//        emitter.birthRate = 0
        UIView.animate(withDuration: 1) {
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
