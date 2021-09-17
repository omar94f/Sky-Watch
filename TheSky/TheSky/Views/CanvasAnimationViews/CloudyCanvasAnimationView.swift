//
//  CloudyCanvasAnimationView.swift
//  TheSky
//
//  Created by Omar Farooq on 9/16/21.
//

import UIKit

class CloudyCanvasAnimationView: UIView {

    var gradientColors: [CGColor]  {
        return [#colorLiteral(red: 0.5106197965, green: 0.6298287445, blue: 0.9937505265, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.6453928186, blue: 0.9686274529, alpha: 1)].map{ $0.cgColor}
    }

    private lazy var sunView: CanvasViewType = {
        let frame = CGRect(x: bounds.midX - bounds.quarterWidth,
                           y: bounds.midY ,
                           width: bounds.quarterWidth,
                           height: bounds.quarterWidth)

        let sunview = SunView(frame: frame, circlesCount: 3, sunColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        return sunview
    }()

    private lazy var cloudRight: CanvasViewType = {
        let cloudHeight = bounds.height * 0.15
        let cloudWidth = bounds.width * 0.6
        let frame = CGRect(x: bounds.width*0.4,
                           y: bounds.height,
                           width: cloudWidth,
                           height: cloudHeight)
        let cloud = CloudView(frame: frame, cloudOpacity: 1, sunColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        return cloud
    }()

    private lazy var cloudLeft: CanvasViewType = {
        let cloudHeight = bounds.height * 0.15
        let cloudWidth = bounds.width * 0.6
        let frame = CGRect(x: 0,
                           y: bounds.height - 10,
                           width: cloudWidth,
                           height: cloudHeight)
        let cloud = CloudView(frame: frame, cloudOpacity: 0.7, sunColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))

        return cloud
    }()

}

extension CloudyCanvasAnimationView: CanvasAnimationType {

    func setupForCanvas() {
        sunView.setupForCanvas()
        addSubview(sunView)

        cloudRight.setupForCanvas()
        cloudLeft.setupForCanvas()
        cloudLeft.transform = CGAffineTransform(scaleX: -1, y: 1)
        addSubview(cloudRight)
        addSubview(cloudLeft)
    }

    func present() {
        sunView.presentAnimation()
        cloudRight.presentAnimation()
        cloudLeft.presentAnimation()
    }

    func dismiss() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        cloudLeft.dismissAnimation {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        cloudRight.dismissAnimation {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        sunView.dismissAnimation {
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.removeFromSuperview()
        }
    }

}
