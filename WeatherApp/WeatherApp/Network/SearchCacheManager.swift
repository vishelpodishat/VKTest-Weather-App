//
//  SearchCacheManager.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 23.03.2024.
//

import Foundation


struct SearchResult: Codable {
    let title: String
    let subtitle: String

    var description: String {
        return title + " " + subtitle
    }
}


class SearchCache {

    static let shared = SearchCache()

    private(set) var searchResults: [SearchResult] = []

    func addAndSaveNewResult(_ result: SearchResult) {
        if !searchResults.contains(where: { $0.title == result.title }) {
            searchResults.insert(result, at: 0)
        }

        if searchResults.count > 5 {
            searchResults.removeLast()
        }
        saveAllresults()
    }

    private func saveAllresults(to file: String = "searchResults")  {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                          in: .userDomainMask).first!
        let archieveURL = documentsDirectory.appendingPathComponent("search_results").appendingPathExtension("plist")
        let propertyListEncoder = PropertyListEncoder()
        let encodedPlaces = try? propertyListEncoder.encode(searchResults)

        try? encodedPlaces?.write(to: archieveURL, options: .noFileProtection)
    }

    func loadAllSearchPlaces(from file: String = "searchResults") {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                          in: .userDomainMask).first!
        let archieveURL = documentsDirectory.appendingPathComponent("search_results").appendingPathExtension("plist")
        let propertyListDecoder = PropertyListDecoder()

        if let retrievedNotesData = try? Data.init(contentsOf: archieveURL), let decodedPlaces = try? propertyListDecoder.decode(Array<SearchResult>.self, from: retrievedNotesData) {
            self.searchResults = decodedPlaces
        }
    }
}
