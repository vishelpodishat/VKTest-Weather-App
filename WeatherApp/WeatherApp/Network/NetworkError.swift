//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 23.03.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURLComponents
    case invalidURL
    case weatherNotFound
    case unableToParseJSON
}
