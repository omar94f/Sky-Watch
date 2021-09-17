//
//  WeatherViewType.swift
//  TheSky
//
//  Created by Omar Farooq on 9/15/21.
//

import UIKit

protocol IconViewType: UIView {
    func setupViewAsIcon()
    func animateGrow()
    func animateShrink()
}
