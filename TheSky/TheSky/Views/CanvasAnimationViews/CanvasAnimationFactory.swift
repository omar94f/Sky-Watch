//
//  CanvasAnimationFactory.swift
//  TheSky
//
//  Created by Omar Farooq on 9/17/21.
//

import UIKit

struct CanvasAnimationFactory {
    static func getAnimation(for weather: WeatherEnum, frame: CGRect) -> CanvasAnimationType {

        switch weather {
        case .sunny:
            return  SunnyCanvasAnimationView(frame: frame)
        case .cloudy:
            return CloudyCanvasAnimationView(frame: frame)
        default:
            return CloudyCanvasAnimationView(frame: frame)
        }
    }
}
