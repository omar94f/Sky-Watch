//
//  SunnyCanvasAnimationView.swift
//  TheSky
//
//  Created by Omar Farooq on 9/16/21.
//

import UIKit

class SunnyCanvasAnimationView: UIView {

    var gradientColors: [CGColor] {
        return [#colorLiteral(red: 0.9686274529, green: 0.8380189354, blue: 0.3041252315, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.4818963642, blue: 0.1921568662, alpha: 1)].map{ $0.cgColor}
    }

    private lazy var sunView: CanvasViewType = {

        let frame = CGRect(x: 0,
                           y: bounds.midY - bounds.quarterHeight/2,
                           width: bounds.width,
                           height: bounds.height)

        let sunview = SunView(frame: frame, circlesCount: 4, sunColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        return sunview
    }()

}

extension SunnyCanvasAnimationView: CanvasAnimationType {

    func setupForCanvas() {
        sunView.setupForCanvas()
        addSubview(sunView)
    }

    func present() {
        sunView.presentAnimation()
    }

    func dismiss() {
        sunView.dismissAnimation(completion: { [weak self] in
            self?.removeFromSuperview()
        })
    }
}
