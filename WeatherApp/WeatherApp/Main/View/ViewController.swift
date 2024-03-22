//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 20.03.2024.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - ViewModel
    private let viewModel = WeatherViewModel()

    // MARK: - UI
    private lazy var weatherSearchBar: WeatherSearchBar = {
        let searchBar = WeatherSearchBar()
        searchBar.placeholder = "Поиск"
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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        fetchWeather()
    }
}


// MARK: - Setup
extension ViewController {
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        [weatherSearchBar, weatherView, tableView].forEach(view.addSubview)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            weatherSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            weatherSearchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: 12),
            weatherSearchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -12),
            weatherSearchBar.heightAnchor.constraint(equalToConstant: 36),

            weatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            weatherView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            tableView.topAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: 70),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                               constant: 12),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -12),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
}


// MARK: - Fetching Data
private extension ViewController {
    func fetchWeather() {
        let urlSession = URLSession.shared
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=d2da00195ccc1c907eaa5e9ff848e91a") else { return }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        let task = urlSession.dataTask(with: urlRequest) { data, responce, error in
            print("Data", data)
            print("Responce", responce)
            print("Error", error)
        }

        task.resume()
    }
}

