//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 25.03.2024.
//

import Foundation
import CoreLocation

protocol SearchScreenViewModelDelegate: AnyObject {
    func sucessFilterData()
}

class SearchViewModel {

    public weak var delegate: SearchScreenViewModelDelegate?
    private var filteredData: [(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D?)] = []

    var numberOfRows: Int {
        return filteredData.count
    }

    public func loadCurrentData(_ indexPath: IndexPath) -> (title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D?) {
        return filteredData[indexPath.row]
    }

    public func filterData(with text: String) {
        LocationManager.shared.cancelSearchAddresses()
        LocationManager.shared.searchAddressesForText(text) { [weak self]( result: [(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D?)]) in
            self?.filteredData = result
            self?.delegate?.sucessFilterData()
        }
    }
}

