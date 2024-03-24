//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 25.03.2024.
//

import Foundation
import UIKit

enum WeatherIconEnum: String {
    case thunderstorm = "cloud.bolt.rain.fill"
    case drizzle = "cloud.drizzle.fill"
    case rain = "cloud.heavyrain.fill"
    case snow = "cloud.snow.fill"
    case clear = "sun.max.fill"
    case clouds = "cloud.fill"
    case other = "sun.haze.fill"
}

protocol HomeScreenViewModelDelegate: AnyObject {
    func successFetchData()
}

class HomeScreenViewModel: NSObject {

    public weak var delegate: HomeScreenViewModelDelegate?
    private(set) var forecastData: WeatherForecastModel! {
        didSet {
            delegate?.successFetchData()
        }
    }

    override init() {
        super.init()
    }

    func fetchWeatherForecastJSON() {
        NetworkService.getWeatherForecastJson { [weak self] result in
            switch result {
            case .success(let data):
                self?.forecastData = data
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchWeatherForecast(latitude: Double, longitude: Double) {
        NetworkService.getWeatherForecast(latitude, longitude) { [weak self] result in
            switch result {
            case .success(let data):
                self?.forecastData = data
            case .failure(let error):
                print(error)
            }
        }
    }

    public var cityName: String {
        return forecastData.city.name
    }

    public func getTemperature(_ index: Int) -> String {
        return String(format:"%.0f", forecastData.singleDays[index].main.temp)
    }

    public func getMinTemperature(_ index: Int) -> String  {
        return String(format:"%.0f°", forecastData.singleDays[index].main.tempMin)
    }

    public func getMaxTemperature(_ index: Int) -> String {
        return String(format:"%.0f°", forecastData.singleDays[index].main.tempMax)
    }

    public func getDayAndDate(_ index: Int) -> String {
        let date = Date(timeIntervalSince1970: forecastData.singleDays[index].dt)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "EEEE, dd"

        return dateFormatter.string(from: date).capitalized
    }

    public func getTemperatureImage(_ index: Int) -> UIImage {
        let iconName = self.getIconForecast(of: forecastData.singleDays[index].weather[0].id)
        return  UIImage(systemName: iconName)!.scalePreservingAspectRatio(targetSize: CGSize(width: 120, height: 120)).withTintColor(AppColors.secondary)
    }

    public func getDayDescription(_ index: Int) -> String {
        return forecastData.singleDays[index].weather[0].description.capitalized
    }

    public func getProbabilityPrecipitation(_ index: Int) -> String {
        let preciptation = forecastData.singleDays[index].pop * 100
        return String(format: "%.0f%%", preciptation)
    }

    public func getWindSpeed(_ index: Int) -> String {
        let speed = forecastData.singleDays[index].wind.speed * 3.6
        return String(format: "%.0f km/h", speed)
    }

    public func getHumidity(_ index: Int) -> String {
        return String(format: "%.0f%%",forecastData.singleDays[index].main.humidity)
    }

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
