//
//  CloudView.swift
//  TheSky
//
//  Created by Omar Farooq on 9/17/21.
//

import UIKit

class CloudView: UIView {

    let cloudColour: UIColor
    let cloudOpacity: Float

    private let moveUpKeyName = "moveUP"
    private let moveDownKeyName = "moveDown"

    private lazy var cloud: CAShapeLayer = {
        let cloud = CAShapeLayer()
        cloud.frame = bounds
        cloud.fillColor = cloudColour.cgColor
        cloud.opacity = cloudOpacity

        let path = UIBezierPath()
        let margin: CGFloat = 10
        path.move(to: CGPoint(x: margin, y: bounds.height - margin))
        let point0 = CGPoint(x: bounds.width - margin, y: bounds.height - margin)
        path.addLine(to: point0)
        let point1 = point0.moveBy(x: 0, y: -30)
        path.addCurve(to: point1,
                      controlPoint1: point0.moveBy(x: 20, y: 0),
                      controlPoint2: point1.moveBy(x: 20, y: 0))
        let point2 = point1.moveBy(x: -30, y: -10)
        path.addCurve(to: point2,
                      controlPoint1: point1.moveBy(x: 0, y: -20),
                      controlPoint2: point2.moveBy(x: 10, y: -10))
        let point3 = point2.moveBy(x: -60, y: 0)
        path.addCurve(to: point3,
                      controlPoint1: point2.moveBy(x: -10, y: -30),
                      controlPoint2: point3.moveBy(x: 10, y: -30))
        let point4 = point3.moveBy(x: -30, y: 0)
        path.addCurve(to: point4,
                      controlPoint1: point3.moveBy(x: -5, y: -10),
                      controlPoint2: point4.moveBy(x: 5, y: -10))
        let point5 = point4.moveBy(x: -50, y: 0)
        path.addCurve(to: point5,
                      controlPoint1: point4.moveBy(x: -10, y: -20),
                      controlPoint2: point5.moveBy(x: 10, y: -20))
        let point6 = point5.moveBy(x: -40, y: 20)
        path.addCurve(to: point6,
                      controlPoint1: point5.moveBy(x: -10, y: -20),
                      controlPoint2: point6.moveBy(x: -10, y: -30))
        let point7 = point6.moveBy(x: -10, y: 20)
        path.addCurve(to: point7,
                      controlPoint1: point6.moveBy(x: -20, y: -10),
                      controlPoint2: point7.moveBy(x: -10, y: 0))

        cloud.path = path.cgPath

        return cloud
    }()

    init(frame: CGRect = .zero, cloudOpacity: Float = 1, sunColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) {
        self.cloudColour = sunColor
        self.cloudOpacity = cloudOpacity
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayer() {
        layer.addSublayer(cloud)
        layer.borderColor = UIColor.red.cgColor
        cloud.transform = CATransform3DMakeScale(1, 1.2, 1)
    }
}

extension CloudView: CanvasViewType {

    func setupForCanvas() {
        setupLayer()
    }

    func presentAnimation() {
        guard let superFrame = superview?.frame else { return}
        let finalFrame = frame.applying(CGAffineTransform(translationX: 0, y: -superFrame.quarterHeight*1.7))
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: .curveEaseOut) {
            self.frame = finalFrame
        }
    }

    func dismissAnimation(completion: CanvasAnimationCompletion) {

        guard let superFrame = superview?.frame else { return}
        let finalFrame = CGRect(x: frame.minX, y: superFrame.height, width: frame.width, height: frame.height)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.frame = finalFrame
        }) { _ in
            completion?()
        }
        
    }
}
