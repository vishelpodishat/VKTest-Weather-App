//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 21.03.2024.
//

import UIKit
import CoreLocation

class WeatherCollectionViewCellViewModel {
    var weatherForecast: WeatherForecast

    init(weatherForecast: WeatherForecast) {
        self.weatherForecast = weatherForecast
    }

    public var dayOfWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let date = Date(timeIntervalSince1970: weatherForecast.dt)
        if Calendar.current.isDateInToday(date) {
            return "Сегодня" 
        } else {
            return dateFormatter.string(from: date).capitalized
        }
    }


    public var temperatureImage: UIImage {
        let iconName = self.getIconForecast(of: weatherForecast.weather[0].id)
        return  UIImage(
            systemName: iconName
        )!.scalePreservingAspectRatio(
            targetSize: CGSize(
                width: 40,
                height: 40
            )
        ).withTintColor(
            AppColors.secondary
        )
    }

    public var maxTemperature: String {
        return String(format: "%.0f°", weatherForecast.main.tempMax)
    }

    public var minTemperature: String {
        return String(format: "%.0f°", weatherForecast.main.tempMin)
    }



    // Code Icons https://openweathermap.org/weather-conditions
    private func getIconForecast(of id: Int) -> String {
        switch id {
        case 200...232:
            return WeatherIconEnum.thunderstorm.rawValue
        case 300...321:
            return WeatherIconEnum.drizzle.rawValue
        case 500...531:
            return WeatherIconEnum.rain.rawValue
        case 600...622:
            return WeatherIconEnum.snow.rawValue
        case 800:
            return WeatherIconEnum.clear.rawValue
        case 801...804:
            return WeatherIconEnum.clouds.rawValue
        default:
            return WeatherIconEnum.other.rawValue
        }
    }


}
