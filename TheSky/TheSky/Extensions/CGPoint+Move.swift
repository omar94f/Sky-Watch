//
//  CGPoint+Move.swift
//  TheSky
//
//  Created by Omar Farooq on 9/17/21.
//

import UIKit

extension CGPoint {

    func moveBy(x: CGFloat, y: CGFloat) -> CGPoint {
        return applying(CGAffineTransform(translationX: x, y: y))
    }
}
