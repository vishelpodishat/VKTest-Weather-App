//
//  WeekdayModel.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 23.03.2024.
//

import UIKit

enum WeekdayModel: Int, Codable {
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7

    var titleColor: UIColor {
        switch self {
        case .monday, .tuesday, .wednesday, .thursday, .friday:
            return .black
        case .saturday, .sunday:
            return .red
        }
    }
}

struct WeekdayWeather: Codable {
    let coord: Coord
    let main: Main
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

