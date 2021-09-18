//
//  SnowyCanvasAnimationView.swift
//  TheSky
//
//  Created by Omar Farooq on 9/18/21.
//

import UIKit

class SnowyCanvasAnimationView: UIView {

    var gradientColors: [CGColor]  {
        return [#colorLiteral(red: 0.6142063775, green: 0.8596935612, blue: 0.9937505265, alpha: 1), #colorLiteral(red: 0.4843137264, green: 0.74807785, blue: 0.9686274529, alpha: 1)].map{ $0.cgColor}
    }

    private lazy var snowCell: CAEmitterCell = {
        let cell = CAEmitterCell()
        cell.birthRate = 5
        cell.lifetime = 30.0

        cell.velocity = 30
        cell.velocityRange = 20
        cell.emissionLongitude = .pi
        cell.emissionRange = .pi / 8
        cell.scale = 0.4
        cell.scaleRange = 0.5
        cell.color = UIColor.white.cgColor

        let circleView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        circleView.layer.cornerRadius = 2.5
        circleView.layer.backgroundColor = UIColor.white.cgColor

        cell.contents = circleView.asImage().cgImage

        return cell
    }()

    

    private lazy var emitter: CAEmitterLayer = {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.frame = bounds
        emitterLayer.emitterPosition = CGPoint(x: bounds.midX, y: layoutMargins.top)
        emitterLayer.emitterSize = CGSize(width: bounds.width, height: 1)
        emitterLayer.emitterShape = .line
        emitterLayer.masksToBounds = true

        emitterLayer.emitterCells = [snowCell]
        return emitterLayer
    }()

    func setupLayers() {

        layer.addSublayer(emitter)
    }

}

extension SnowyCanvasAnimationView: CanvasAnimationType {

    func setupForCanvas() {
        setupLayers()
    }

    func present() {
//        emitter.beginTime = CACurrentMediaTime()
        emitter.birthRate = 1

    }

    func dismiss() {
        emitter.birthRate = 0

        UIView.animate(withDuration: 1) {
            [weak self] in
            self?.alpha = 0
        } completion: { [weak self] _ in
            self?.removeFromSuperview()
        }
    }
}
