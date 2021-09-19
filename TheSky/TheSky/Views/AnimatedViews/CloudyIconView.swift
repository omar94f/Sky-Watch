//
//  CloudyIconView.swift
//  TheSky
//
//  Created by Omar Farooq on 9/16/21.
//

import UIKit


class CloudyIconView: UIView {

    private let growKeyName = "grow"
    private let shrinkKeyName = "shrink"
    let color: UIColor

    private lazy var growAnimation: CABasicAnimation = {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.toValue = 1.5
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.damping = 8
        animation.stiffness = 150
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        return animation
    }()

    private lazy var shrinkAnimation: CABasicAnimation = {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.toValue = 1
        animation.duration = 0.5
        animation.damping = 8
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        return animation
    }()

    private lazy var centerCircle: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.frame = bounds
        let radius = bounds.mininumDimension/2 * 0.25
        let startAngle = CGFloat.zero
        let endAngle = CGFloat.pi * 2
        shape.path = UIBezierPath(arcCenter: frameCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        shape.fillColor = color.cgColor
        return shape
    }()

    private lazy var northEastCircle: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.frame = bounds
        let radius = bounds.mininumDimension/2 * 0.25
        let startAngle = CGFloat.zero
        let endAngle = CGFloat.pi * 2
        shape.path = UIBezierPath(arcCenter: frameCenter.applying(CGAffineTransform(translationX: radius*0.5, y: -radius*0.3)), radius: radius*0.3, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        shape.fillColor = color.cgColor
        shape.opacity = 0.3
        return shape
    }()

    private lazy var southEastCircle: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.frame = bounds
        let radius = bounds.mininumDimension/2 * 0.25
        let startAngle = CGFloat.zero
        let endAngle = CGFloat.pi * 2
        shape.path = UIBezierPath(arcCenter: frameCenter.applying(CGAffineTransform(translationX: radius*0.6, y: radius*0.5)), radius: radius*0.5, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        shape.fillColor = color.cgColor
        shape.opacity = 0.3
        return shape
    }()

    init(frame: CGRect = .zero, color: UIColor = #colorLiteral(red: 0.2392156869, green: 0.5199092405, blue: 0.9686274529, alpha: 1)) {
        self.color = color
        super.init(frame: frame)

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        layer.addSublayer(northEastCircle)
        layer.addSublayer(southEastCircle)
        layer.addSublayer(centerCircle)
    }
}

extension CloudyIconView: IconViewType {

    var scalingFactor: CGFloat {
        return 2
    }

    func setupViewAsIcon() {
        setup()
    }

    func animateGrow() {
        growAnimation.toValue = scalingFactor
        centerCircle.addAnimationWithDelay(animation: growAnimation, forKey: growKeyName)
        growAnimation.toValue = scalingFactor * 1.5
        southEastCircle.addAnimationWithDelay(animation: growAnimation, forKey: growKeyName, delay: 0.2)
        northEastCircle.addAnimationWithDelay(animation: growAnimation, forKey: growKeyName, delay: 0.4)
    }

    func animateShrink() {
        northEastCircle.addAnimationWithDelay(animation: shrinkAnimation, forKey: shrinkKeyName)
        southEastCircle.addAnimationWithDelay(animation: shrinkAnimation, forKey: shrinkKeyName, delay: 0.1)
        centerCircle.addAnimationWithDelay(animation: shrinkAnimation, forKey: shrinkKeyName, delay: 0.2)
    }
}
