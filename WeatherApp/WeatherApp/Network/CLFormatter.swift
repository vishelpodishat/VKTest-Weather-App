//
//  CLFormatter.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 23.03.2024.
//

import Foundation
import CoreLocation

class CLFormatter {
    static let shared = CLFormatter()

    private let geocoder = CLGeocoder()

    func cityName(location: CLLocation) async throws -> String {
        let placemark  = try await geocoder.reverseGeocodeLocation(location)
        if let locality = placemark.first?.locality {
            return locality
        } else {
            return ""
        }
    }
}

class CustomDateFormatter {
    static let shared = CustomDateFormatter()

    private let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.timeZone = .current
       return formatter
    }()

    func weekDayNumber(from string: String) -> Int {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: string) {
            let weekDay = Calendar.current.component(.weekday, from: date)
            return weekDay
        } else {
            return 2
        }
    }

    func dayOfTheWeek(from string: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: string) {
            let _ = Calendar.current.component(.weekday, from: date)
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: date)
        } else {
            return "День недели"
        }
    }

    func formattedString(from string: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: string) {
            dateFormatter.dateFormat = "MMMM d"
            return dateFormatter.string(from: date)
        } else {
            return "Месяц число"
        }
    }
}
