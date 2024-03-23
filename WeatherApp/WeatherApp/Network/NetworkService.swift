//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 21.03.2024.
//

import UIKit
import CoreLocation

protocol WeatherManagerDelegate: AnyObject {
//    func didUpdateWeather(_ networkService: NetworkService, weather: WeatherModel)
    func didUpdateWeather(_ weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

final class NetworkService {
    static let service = NetworkService()

    var delegate: WeatherManagerDelegate?

    private let apiKey = "d2da00195ccc1c907eaa5e9ff848e91a"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather?&appid"

       func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherData {
           var urlComponents = URLComponents(string: baseURL)
           urlComponents?.queryItems = [
               URLQueryItem(name: "lat", value: String(latitude)),
               URLQueryItem(name: "lon", value: String(longitude)),
               URLQueryItem(name: "appid", value: apiKey),
               URLQueryItem(name: "units", value: "metric")
           ]

           guard let url = urlComponents?.url else {
               throw NetworkError.invalidURL
           }

           let (data, response) = try await URLSession.shared.data(from: url)

           guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
               throw NetworkError.weatherNotFound
           }

           let decoder = JSONDecoder()
           do {
               let weatherData = try decoder.decode(WeatherData.self, from: data)
               return weatherData
           } catch {
               throw NetworkError.unableToParseJSON
           }
       }

//    func fetchWeatherCity(cityName: String){
//        let weatherURL = "\(baseURL)=\(apiKey)&q=\(cityName)&units=metric"
//        performRequest(with: weatherURL)
//    }
//    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
//        let weatherURL = "\(baseURL)=\(apiKey)&lat=\(lat)&lon=\(lon)&units=metric"
//        performRequest(with: weatherURL)
//    }
//
//    // MARK: - Request
//    func performRequest(with urlString: String) {
//        if let url = URL(string: urlString) {
//            let session = URLSession(configuration: .default)
//
//            let task = session.dataTask(with: url) { data, response, error in
//                if error != nil {
//                    self.delegate?.didFailWithError(error!)
//                    return
//                }
//
//                if let safeData = data {
//                    if let weather = self.parseJSON(weatherData: safeData) {
//                        self.delegate?.didUpdateWeather(weather)
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//
//    // MARK: - Parsing JSON
//    func parseJSON(weatherData: Data) -> WeatherModel? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            let weather = WeatherModel(description: decodedData.weather[0].description,
//                                       cityName: decodedData.name,
//                                       conditionID: decodedData.weather[0].id,
//                                       temperature: decodedData.main.temp,
//                                       maxTemperature: decodedData.main.tempMax,
//                                       minTemperature: decodedData.main.tempMin,
//                                       humidity: decodedData.main.humidity,
//                                       wind: decodedData.wind.speed)
//            return weather
//        } catch {
//            delegate?.didFailWithError(error)
//            return nil
//        }
//    }
}

