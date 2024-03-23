//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 21.03.2024.
//

import UIKit
import CoreLocation

final class WeatherViewModel: NSObject, CLLocationManagerDelegate {

    // MARK: - Data
    private var weatherData: WeatherData?

    private let networkService = NetworkService.service
    let locationManager = CLLocationManager()
    weak var delegate: WeatherManagerDelegate?

    init(weatherData: WeatherData) {
        self.weatherData = weatherData
    }

//    func fetchWeatherForCurrentLocation() {
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
//    }

    func updateWeatherData(_ data: WeatherData) {
        weatherData = data
    }

    func updateWeatherView(_ weatherView: WeatherView) {
        weatherView.citylabel.text = "City: \(getCityName() ?? "")"
        weatherView.temperaturelabel.text = "Temperature: \(getFormattedTemperature() ?? "")"
        weatherView.conditionlabel.text = getFormattedCondition()
        weatherView.maxTemplabel.text = getFormattedMaxTemperature()
        weatherView.minTemplabel.text = getFormattedMinTemperature()
        weatherView.humiditylabel.text = getFormattedHumidity()
        weatherView.windSpeedlabel.text = getFormattedWindSpeed()
    }

    func getCityName() -> String? {
        return weatherData?.name
    }

    func getFormattedTemperature() -> String? {
        if let temp = weatherData?.main.temp {
            return "\(temp)°C"
        }
        return nil
    }

    func getFormattedCondition() -> String? {
        if let conditionID = weatherData?.weather.first?.id{
            return "Condition: \(conditionID)"
        }
        return nil
    }

    func getFormattedMaxTemperature() -> String? {
        if let maxTemp = weatherData?.main.tempMax {
            return "Max Temp: \(maxTemp)°C"
        }
        return nil
    }

    func getFormattedMinTemperature() -> String? {
        if let minTemp = weatherData?.main.tempMin {
            return "Min Temp: \(minTemp)°C"
        }
        return nil
    }

    func getFormattedHumidity() -> String? {
        if let humidity = weatherData?.main.humidity {
            return "Humidity: \(humidity)%"
        }
        return nil
    }

    func getFormattedWindSpeed() -> String? {
        if let windSpeed = weatherData?.wind.speed {
            return "Wind Speed: \(windSpeed) m/s"
        }
        return nil
    }

    // MARK: - CLLocationManagerDelegate
    func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
}

extension WeatherViewModel: WeatherManagerDelegate {
    func didUpdateWeather(_ weather: WeatherModel) {
        delegate?.didUpdateWeather(weather)
    }

    func didFailWithError(_ error: Error) {
        delegate?.didFailWithError(error)
    }
}
