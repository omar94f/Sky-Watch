//
//  AnimatableViewType.swift
//  TheSky
//
//  Created by Omar Farooq on 9/14/21.
//

import UIKit


protocol CanvasAnimationType: UIView {

    var gradientColors: [CGColor] { get }

    func setupForCanvas()
    func present()
    func dismiss()
}

