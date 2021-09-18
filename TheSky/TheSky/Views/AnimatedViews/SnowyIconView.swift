//
//  SnowyIconView.swift
//  TheSky
//
//  Created by Omar Farooq on 9/18/21.
//

import UIKit

class SnowyIconView: UIView {

    let spinKeyName = "spin"
    let growKeyName = "grow"
    let shrinkKeyName = "shrink"

    private lazy var gradient: CAGradientLayer = {
        let flakeGradient = CAGradientLayer()
        flakeGradient.frame = bounds
        flakeGradient.startPoint = CGPoint(x: 0, y: 0)
        flakeGradient.endPoint = CGPoint(x: 1, y: 1)
        flakeGradient.colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.3988808, green: 0.742267171, blue: 0.9686274529, alpha: 1)].map{ $0.cgColor}
        return flakeGradient
    }()

    private lazy var replicatorLayer:CAReplicatorLayer = {

        // instance layer
        let crownLine = CAShapeLayer()
        let lineHeight = bounds.height * 0.25
        let crownWidth = lineHeight/3
        let crownheight = lineHeight * 0.5
        crownLine.frame = CGRect(x: 0, y: 0, width: crownWidth, height: lineHeight)
        // Path
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: lineHeight))
        path.move(to: CGPoint(x: -crownWidth, y: 0))
        path.addLine(to: CGPoint(x: 0, y: crownheight))
        path.addLine(to: CGPoint(x: crownWidth, y: 0))
        crownLine.fillColor = UIColor.clear.cgColor
        crownLine.path = path.cgPath
        crownLine.lineWidth = 3
        crownLine.lineCap = .square
        crownLine.lineJoin = .bevel
        crownLine.strokeColor = UIColor.white.cgColor
        crownLine.transform = CATransform3DMakeScale(1, -1, 1)

        // replicator layer
        let replicator = CAReplicatorLayer()
        replicator.position = CGPoint(x: bounds.midX, y: bounds.midY)
        replicator.instanceCount = 6
        replicator.instanceTransform = CATransform3DMakeRotation(.pi*2/6, 0, 0, 1)
        replicator.addSublayer(crownLine)
        return replicator
    }()

    private func constructSnowFlake() {
        layer.addSublayer(gradient)
        layer.mask = replicatorLayer
    }
}

extension SnowyIconView: IconViewType {

    func setupViewAsIcon() {
        constructSnowFlake()
    }

    func animateGrow() {
        let anim = CASpringAnimation(keyPath: "transform.rotation")
        anim.duration = 10
        anim.damping = 10
        anim.stiffness = 100
        anim.toValue = CGFloat.pi/2
        anim.isRemovedOnCompletion = false
        anim.fillMode = .forwards
        replicatorLayer.add(anim, forKey: spinKeyName)

        let anim2 = CASpringAnimation(keyPath: "transform.scale")
        anim2.duration = 2
        anim2.toValue = 1.2
        anim2.damping = 6
        anim2.isRemovedOnCompletion = false
        anim2.fillMode = .forwards
        replicatorLayer.add(anim2, forKey: nil)
    }

    func animateShrink() {
        let anim2 = CASpringAnimation(keyPath: "transform.scale")
        anim2.duration = 2
        anim2.toValue = 1
        anim2.damping = 6
        anim2.isRemovedOnCompletion = false
        anim2.fillMode = .forwards
        replicatorLayer.add(anim2, forKey: nil)
    }
}
