//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 20.03.2024.
//

import UIKit
import CoreLocation
import MapKit

final class WeatherViewController: UIViewController {
    // MARK: - Properties
    private let networkService = NetworkService()
    private var completer = MKLocalSearchCompleter()
    private var weatherData: WeatherData?

    // MARK: - Async
    private var weatherTask: Task<Void, Never>? = nil

    let latitude = 37.7749 // Example latitude (San Francisco)
    let longitude = -122.4194

    // MARK: - ViewModel
    private var viewModel: WeatherViewModel?

    // MARK: - UI
    private lazy var weatherSearchBar: WeatherSearchBar = {
        let searchBar = WeatherSearchBar()
        searchBar.placeholder = "Поиск"
        searchBar.delegate = self
        return searchBar
    }()

    private lazy var weatherView: WeatherView = {
        let view = WeatherView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ofType: WeekTableViewCell.self)
        tableView.backgroundColor = .systemBackground
        tableView.estimatedRowHeight = 65
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .red
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        setupRightBarButtonItem()
        updateUI()
        weatherView.viewModel = viewModel
    }
}


// MARK: - Setup
extension WeatherViewController {
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        [weatherView, tableView].forEach(view.addSubview)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            weatherView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                 constant: 12),
            weatherView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                  constant: -12),
            weatherView.heightAnchor.constraint(equalToConstant: 200),

            tableView.topAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: 100),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                               constant: 12),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -12),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }

    private func setupRightBarButtonItem() {
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(didTapSettingsButton))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    // MARK: - Action
    @objc private func didTapSettingsButton() {
        let settingsViewController = SearchViewController()
        present(settingsViewController, animated: true, completion: nil)
    }
}


// MARK: - Update UI
extension WeatherViewController {
    private func updateUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let viewModel = self.viewModel else { return }
            viewModel.updateWeatherView(self.weatherView)
        }
    }

    private func fetchWeatherForLocation(_ location: CLLocation) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude

        Task {
            do {
                let weatherData = try await networkService.fetchWeather(latitude: latitude, longitude: longitude)
                self.weatherData = weatherData
                updateUI()
            } catch {
                // Handle error
            }
        }
    }

    func didUpdateWeather(_ networkService: NetworkService, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.weatherView.citylabel.text = weather.cityName
            self.weatherView.temperaturelabel.text = (weather.temperatureString)
            self.weatherView.imageView.image = UIImage(systemName: weather.conditionName)
            self.weatherView.conditionlabel.text = weather.description
            self.weatherView.maxTemplabel.text = weather.formattedMaxTemperature
            self.weatherView.minTemplabel.text = weather.formattedMinTemperature
            self.weatherView.humiditylabel.text = weather.humidityString
            self.weatherView.windSpeedlabel.text = weather.windSpeedString
        }
    }

    func didFailWithError(error: any Error) {
        print(error)
    }
}

// MARK: - SearchBar
extension WeatherViewController: UISearchBarDelegate {

}


// MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            viewModel?.locationManager.delegate = self
            viewModel?.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            viewModel?.locationManager.requestWhenInUseAuthorization()
            viewModel?.locationManager.startUpdatingLocation()
        } else {
            showAlert(for: .weatherNotFound)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        fetchWeatherForLocation(location)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle location manager error
    }
}


extension WeatherViewController: MKLocalSearchCompleterDelegate {

}
