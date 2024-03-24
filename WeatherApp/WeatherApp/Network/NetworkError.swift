//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 23.03.2024.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case requestFailed
    case networkFailed
    case decodingFailed
    case dataFailed
}
