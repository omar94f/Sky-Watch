//
//  DayEnum.swift
//  TheSky
//
//  Created by Omar Farooq on 9/15/21.
//

enum DayEnum: String {
    case mon
    case tue
    case wed
    case thu
    case fri
    case sat
    case sun

    var name: String {
        return self.rawValue.capitalized
    }

}
