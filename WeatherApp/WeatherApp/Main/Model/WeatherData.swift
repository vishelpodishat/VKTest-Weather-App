//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 21.03.2024.
//

import Foundation

// MARK: - Welcome
struct WeatherData: Codable, Hashable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let name: String
}

// MARK: - Main
struct Main: Codable, Hashable {
    let temp, tempMin, tempMax: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}

// MARK: - Weather
struct Weather: Codable, Hashable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
struct Wind: Codable, Hashable {
    let speed: Double
}
