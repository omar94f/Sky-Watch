//
//  CanvasViewType.swift
//  TheSky
//
//  Created by Omar Farooq on 9/16/21.
//

import UIKit

typealias CanvasAnimationCompletion = (() -> Void)?

protocol CanvasViewType: UIView {
    func setupForCanvas()
    func presentAnimation()
    func dismissAnimation(completion: CanvasAnimationCompletion)
}
