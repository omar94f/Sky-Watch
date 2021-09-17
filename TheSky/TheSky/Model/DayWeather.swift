//
//  DayWeather.swift
//  TheSky
//
//  Created by Omar Farooq on 9/15/21.
//

struct DayWeather {
    var day: DayEnum
    var weather:  WeatherEnum
    var temperatue: Double

    var weatherIcon: IconViewType {
        switch weather {
        case .sunny:
            return SunView()
        case .cloudy:
            return CloudyIconView()
        default:
            return SunView()
        }
    }
}
