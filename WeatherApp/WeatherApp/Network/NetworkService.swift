//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 21.03.2024.
//

import UIKit
import CoreLocation

class NetworkService {
    static let service = NetworkService()

    static func getWeatherForecastJson(completionHandler: @escaping (
        _ result: Result<WeatherForecastModel, Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "forecast", withExtension: "json")
        else { return completionHandler(.failure(NetworkError.invalidURL))}

        do {
            let data = try Data(contentsOf: url)
            let forecast = try JSONDecoder().decode(WeatherForecastModel.self, from: data)
            completionHandler(.success(forecast))
        } catch {
            completionHandler(.failure(NetworkError.decodingFailed))
        }
    }

    static func getWeatherForecast(_ latitude: Double, _ longitude: Double ,completionHandler: @escaping (_ result: Result<WeatherForecastModel, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(Constants.apiKey)&lang=pt_br&units=metric"
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(NetworkError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            DispatchQueue.main.async {
                if error == nil,
                   let data = dataResponse,
                   let resultData = try? JSONDecoder().decode(WeatherForecastModel.self, from: data) {
                    completionHandler(.success(resultData))
                } else {
                    completionHandler(.failure(NetworkError.dataFailed))
                }}
        }.resume()
    }
}

