//
//  SnowyCanvasAnimationView.swift
//  TheSky
//
//  Created by Omar Farooq on 9/18/21.
//

import UIKit

class SnowyCanvasAnimationView: BaseEmitterCanvasAnimationView, CanvasAnimationType {

    var gradientColors: [CGColor]  {
        return [#colorLiteral(red: 0.6142063775, green: 0.8596935612, blue: 0.9937505265, alpha: 1), #colorLiteral(red: 0.4843137264, green: 0.7297029281, blue: 0.9686274529, alpha: 1)].map{ $0.cgColor}
    }

    private lazy var snowCell: CAEmitterCell = {
        let cell = CAEmitterCell()
        cell.birthRate = 5
        cell.lifetime = 40.0

        cell.velocity = 30
        cell.velocityRange = 20
        cell.emissionLongitude = .pi
        cell.emissionRange = .pi / 8
        cell.scale = 0.4
        cell.scaleRange = 0.3
        cell.color = UIColor.white.cgColor

        let circleView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        circleView.layer.cornerRadius = 2.5
        circleView.layer.backgroundColor = UIColor.white.cgColor


        cell.contents = circleView.asImage().cgImage

        return cell
    }()



    override func setupForCanvas() {
        setupLayers()
        emitter.emitterPosition = CGPoint(x: bounds.midX, y: 0)
        emitter.emitterCells = [snowCell]
    }

}
