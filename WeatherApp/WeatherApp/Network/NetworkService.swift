//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 21.03.2024.
//

import UIKit

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ networkService: NetworkService, weather: WeatherModel)
    func didFailWithError(error: Error)
}

final class NetworkService {
    private let service = NetworkService()

    var delegate: WeatherManagerDelegate?

    private let apiKey = "d2da00195ccc1c907eaa5e9ff848e91a"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather?&appid"

    func fetchWeater(for city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }
    }
}
