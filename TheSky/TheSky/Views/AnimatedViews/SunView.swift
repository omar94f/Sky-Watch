//
//  SunView.swift
//  TheSky
//
//  Created by Omar Farooq on 9/14/21.
//

import UIKit


class SunView: UIView {

    private let growKeyName = "grow"
    private let shrinkKeyName = "shrink"


    private lazy var growAnimation: CABasicAnimation = {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.toValue = 1.5
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.damping = 8
        animation.stiffness = 100
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        return animation
    }()


    private lazy var shrinkAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self
    
        return animation
    }()

    private var isAnimating: Bool = false
    private var layers = [CALayer]()

    let circlesCount: CGFloat
    let sunColor: UIColor
    var centralCircleOpacity: Float = 1
    var sunRaysOpacity: Float = 0.1

    init(frame: CGRect = .zero, circlesCount: CGFloat = 3, sunColor: UIColor = #colorLiteral(red: 1, green: 0.7939321151, blue: 0.3174000984, alpha: 1)) {
        self.circlesCount = circlesCount
        self.sunColor = sunColor
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayers(radiusCalculator: (CGFloat, CGFloat) -> CGFloat = {return $0 + $1 * 1.2}) {
        layoutIfNeeded()
        let circleRadius = min(bounds.width, bounds.height)/circlesCount/2

        for i: CGFloat in stride(from: 1.0, to: circlesCount + 1, by: 1.0) {

            let shape = CAShapeLayer()
            shape.frame = bounds

            let radius = radiusCalculator(circleRadius, i)

            let startAngle: CGFloat = 0.0
            let endAngle = CGFloat.pi * 2

            let circlePath = UIBezierPath(arcCenter: frameCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            shape.path = circlePath.cgPath

            shape.fillColor = sunColor.cgColor
            shape.opacity = i == 1 ? centralCircleOpacity : sunRaysOpacity

            layers.append(shape)
        }
        // reversed to add biggest circle first

        layers.reversed().forEach { (layer) in
            self.layer.addSublayer(layer)
        }
    }

    private func removeAllCircleLayers() {
        layers.forEach { (layer) in
            layer.removeFromSuperlayer()
        }
    }


}

extension SunView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        isAnimating = !flag
        
    }
}


extension SunView: CanvasViewType {


    func setupForCanvas() {

        setupLayers { (radiusDivision, iterator) -> CGFloat in
            return radiusDivision*iterator
        }
        let centreCircle = layers[0]
        centreCircle.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        centreCircle.shadowRadius = 6
        centreCircle.shadowOpacity = 0.8
        centreCircle.shadowOffset = .zero

        layers.forEach { layer in
            layer.transform = CATransform3DMakeScale(0, 0, 0)
        }
    }

    func presentAnimation() {
        
        guard !isAnimating else {
            return
        }
        isAnimating = true

        var delayDifference = 0.1
        growAnimation.toValue = 1.5
        for i in stride(from: 0, to: Int(circlesCount), by: 1) {
            layers.reversed()[i].addAnimationWithDelay(animation: growAnimation, forKey: growKeyName, delay: delayDifference)
            delayDifference+=0.2
        }
    }

    func dismissAnimation(completion: CanvasAnimationCompletion) {

        guard !layers.isEmpty else {
            return
        }

        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion?()
        }
        isAnimating = false
        var delayDifference = 0.0
        shrinkAnimation.toValue = 0
        shrinkAnimation.duration = 0.2
        for i in stride(from: 0, to: Int(circlesCount), by: 1) {
            layers[i].addAnimationWithDelay(animation: shrinkAnimation, forKey: shrinkKeyName, delay: delayDifference)
            delayDifference+=0.1
        }
        CATransaction.commit()
    }
}


extension SunView: IconViewType {

    var scalingFactor: CGFloat {
        return 1.1
    }

    var scalingIncrement: CGFloat {
        return 0.3
    }

    func setupViewAsIcon() {
        sunRaysOpacity = 0.2
        setupLayers()
    }

    func animateGrow() {
        guard !layers.isEmpty else {
            return
        }
       
        var delayDifference = 0.1
        var sizeDifference = scalingFactor + scalingIncrement*circlesCount
        for i in stride(from: 0, to: Int(circlesCount-1), by: 1) {
            growAnimation.toValue = sizeDifference
            layers.reversed()[i].addAnimationWithDelay(animation: growAnimation, forKey: growKeyName, delay: delayDifference)
            sizeDifference-=scalingIncrement+0.2
            delayDifference+=0.1
        }
    }

    func animateShrink() {
        guard !layers.isEmpty else {
            return
        }
        var counter = 0.1
        shrinkAnimation.toValue = 1
        shrinkAnimation.duration = 0.2
        for i in stride(from: 1, to: Int(circlesCount), by: 1) {
            layers[i].addAnimationWithDelay(animation: shrinkAnimation, forKey: shrinkKeyName, delay: counter)
            counter+=0.1
        }
    }
}



