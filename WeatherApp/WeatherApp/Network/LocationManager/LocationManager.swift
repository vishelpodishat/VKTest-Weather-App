//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 24.03.2024.
//

import UIKit
import CoreLocation
import MapKit

protocol LocationManagerDelegate: AnyObject {
    func updateUserLocation()
    func updateUserCityName(_ cityName: String)
}

class LocationManager: NSObject {

    static let shared = LocationManager()

    weak var delegate: LocationManagerDelegate?

    private lazy var cllocationManager = CLLocationManager()
    private lazy var completer = MKLocalSearchCompleter()
    private lazy var searchResults: [(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D?)] = []
    private var searchCompletion: (([(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D?)]) -> Void)?
    var userLocationCoordinate: CLLocationCoordinate2D? {
        didSet {
            delegate?.updateUserLocation()
        }
    }


    private override init() {}

    //    MARK: - Public Methods
    public func requestUserLocationManager() {
        cllocationManager.delegate = self

        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                switch CLLocationManager.authorizationStatus() {
                case .authorizedAlways, .authorizedWhenInUse:
                    self.cllocationManager.startUpdatingLocation()
                    break
                case .denied:
                    self.userLocationCoordinate = CLLocationCoordinate2D(latitude: -23.533773, longitude: -46.625290)
                    self.userLocationUpdated(self.userLocationCoordinate!)
                    break
                case .notDetermined:
                    self.cllocationManager.requestWhenInUseAuthorization()
                    break
                default:
                    break
                }
            }
        }
    }

    public func searchAddressesForText(_ text: String,
                                       completion: @escaping
                                       ([(title: String?,
                                          subtitle: String?,
                                          coordinate: CLLocationCoordinate2D?)
                                       ]) -> Void ) {
        completer.delegate = self
        completer.queryFragment = text

        if let userRegionCoordinate = self.userLocationCoordinate {
            let region = MKCoordinateRegion(center: userRegionCoordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            completer.region = region
            completer.resultTypes = .address
        }

        searchCompletion = completion
    }

    public func userLocationUpdated(_ coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location) {[weak self] placemark, error in
            let cityName = placemark?.first?.locality ?? "-"
            self?.delegate?.updateUserCityName(cityName)
            self?.userLocationCoordinate = coordinate
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            cllocationManager.startUpdatingLocation()
            break;
        default:
            break;
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.first?.coordinate {
            cllocationManager.stopUpdatingLocation()
            userLocationUpdated(coordinate)        }
    }

    func searchCoordinatesForAddress(_ address: (title: String, subtitle: String),
                                     completion: @escaping ((title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D?)?) -> Void) {
        let searchRequest = MKLocalSearch.Request()
        let entireAdddress = address.title + " " + address.subtitle
        searchRequest.naturalLanguageQuery = entireAdddress

        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            if let response = response,
               let firstPlacemark = response.mapItems.first?.placemark {
                let coordinate = firstPlacemark.coordinate
                completion((title: address.title, subtitle: address.subtitle, coordinate: coordinate))
            } else {
                completion(nil)
            }
        }
    }

    func cancelSearchAddresses() {
        if completer.isSearching {
            completer.cancel()
        }
    }
}

extension LocationManager: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results.compactMap({ result in
            let street = result.title
            let subtitle = result.subtitle
            let searchRequest = MKLocalSearch.Request(completion: result)
            let coordinate = searchRequest.region.center

            if(!street.contains("-")){
                return nil
            }

            return (title: street, subtitle: subtitle, coordinate: coordinate)
        })

        searchCompletion?(searchResults)
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        searchResults = []
        searchCompletion?(searchResults)
    }
}
