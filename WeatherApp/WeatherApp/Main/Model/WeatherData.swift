//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 21.03.2024.
//

import Foundation

struct WeatherForecastModel: Codable {
    var list: [WeatherForecast]
    var singleDays: [WeatherForecast] {
        var uniqueDays = [Int]()
        return list.filter { current in
            let date = Date(timeIntervalSince1970: current.dt)
            let day = Calendar.current.dateComponents([.day], from: date).day
            guard let _day = day else { return false }

            if !uniqueDays.contains(_day) {
                uniqueDays.append(_day)
                return true
            }

            return false
        }
    }

    var city: City
}

struct WeatherForecast: Codable {
    var dt: Double
    var main: Main
    var weather: [Weather]
    var wind: Wind
    var pop: Double
}

struct Main: Codable {
    var temp: Double
    var tempMin: Double
    var tempMax: Double
    var humidity: Double

    private enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}

struct Weather: Codable {
    var id: Int
    var description: String
    var icon: String
    var iconUrl: String {
        return "https://openweathermap.org/img/wn/\(icon)@2x.png"
    }
}

struct Wind: Codable {
    var speed: Double
}

struct City: Codable {
    var name: String
}


