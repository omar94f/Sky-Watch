//
//  RainyIconView.swift
//  TheSky
//
//  Created by Omar Farooq on 9/18/21.
//

import UIKit

class RainyIconView: UIView {

    let growKeyName = "grow"
    let shrinkKeyName = "shrink"

    private lazy var containerLayer: CALayer = {
        let layer = CALayer()
        let width = bounds.width - bounds.quarterWidth
        layer.frame = CGRect(x: bounds.quarterWidth,
                             y: frameCenter.y - bounds.quarterHeight,
                             width: width,
                             height: bounds.midY)
        return layer
    }()


    func setupLayers() {

        let cloud = CAShapeLayer()
        cloud.fillColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor

        let cloudWidth = containerLayer.bounds.midX
        let cloudHeight = containerLayer.bounds.midX * 0.9

        cloud.frame = CGRect(x: 0,
                             y: 0,
                             width: cloudWidth,
                             height: cloudHeight)
        let path = UIBezierPath(ovalIn: cloud.bounds)
        cloud.path = path.cgPath

        let cloud2 = CAShapeLayer()
        cloud2.fillColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor

        let cloud2Width = cloud.bounds.width * 0.8
        cloud2.frame = CGRect(x: cloud.bounds.width * 0.6,
                              y:  cloud.bounds.height * 0.1 ,
                              width: cloud2Width,
                              height: cloud.bounds.height * 0.85)
        let path2 = UIBezierPath(ovalIn: cloud2.bounds)
        cloud2.path = path2.cgPath
//        cloud2.opacity = 0.6

        let rainDropCount: CGFloat = 3
        let rainDropDistance: CGFloat = containerLayer.bounds.width/rainDropCount - 4
        let rainDropHeight: CGFloat = containerLayer.bounds.height/5
        let replicator = CAReplicatorLayer()
        replicator.frame = CGRect(x: 4,
                                  y: containerLayer.bounds.height * 0.8,
                                  width: containerLayer.bounds.width,
                                  height: rainDropHeight)
        replicator.instanceCount = 3
        replicator.instanceTransform = CATransform3DMakeTranslation(rainDropDistance, 0, 0)


        let rainDrop = CALayer()
        rainDrop.frame = CGRect(x: 0, y: 0, width: 1, height: rainDropHeight)
        rainDrop.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor
        rainDrop.transform = CATransform3DMakeRotation(.pi/8, 0, 0, 1)

        replicator.addSublayer(rainDrop)

        containerLayer.addSublayer(cloud)
        containerLayer.addSublayer(cloud2)
        containerLayer.addSublayer(replicator)
//        containerLayer.borderWidth = 1
        layer.addSublayer(containerLayer)
    }
}

extension RainyIconView: IconViewType {

    func setupViewAsIcon() {
        setupLayers()
    }

    func animateGrow() {

        let anim2 = CASpringAnimation(keyPath: "transform.scale")
        anim2.duration = 1
        anim2.toValue = 1.2
        anim2.damping = 10
        anim2.isRemovedOnCompletion = false
        anim2.fillMode = .forwards

        containerLayer.add(anim2, forKey: growKeyName)
    }

    func animateShrink() {

        let anim2 = CASpringAnimation(keyPath: "transform.scale")
        anim2.duration = 1
        anim2.toValue = 1
        anim2.damping = 10
        anim2.isRemovedOnCompletion = false
        anim2.fillMode = .forwards

        containerLayer.add(anim2, forKey: shrinkKeyName)
        
    }

}
