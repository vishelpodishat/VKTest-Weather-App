//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 22.03.2024.
//

import Foundation

struct WeatherModel {
    // MARK: - description & city
    let description: String
    let cityName: String

    // MARK: - id and related icon
    let conditionID: Int
    var icon: String?

    // MARK: - max min temperature, humidity and Wind speed
    let temperature: Double
    let maxTemperature: Double
    let minTemperature: Double

    var temperatureString: String {
        return "\(String(format: "%.0f", temperature))°C"
    }

    var formattedMaxTemperature: String {
        return "\(String(format: "%.0f", maxTemperature))°C"
    }

    var formattedMinTemperature: String {
        return "\(String(format: "%.0f", minTemperature))°C"
    }

    let humidity: Int
    var humidityString: String {
        return "\(humidity)%"
    }

    let wind: Double
    var windSpeedString: String {
        String(format: "%0.0fkm/h", wind)
    }
}
