//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 22.03.2024.
//

import UIKit

final class WeatherView: UIView {

    // MARK: - Properties
    var viewModel: WeatherViewModel? {
        didSet {
            updateUI()
        }
    }

    // MARK: - Service
    private let networkService = NetworkService.service

    // MARK: - UI
    let citylabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let temperaturelabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let conditionlabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let maxTemplabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let minTemplabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var tempStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [maxTemplabel, minTemplabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let humiditylabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let windSpeedlabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Setup
extension WeatherView {
    // MARK: - Setup Views
    private func setupViews() {
        [citylabel, temperaturelabel, imageView, conditionlabel,
         tempStackView, humiditylabel, windSpeedlabel].forEach(addSubview)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            citylabel.topAnchor.constraint(equalTo: topAnchor),
            citylabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            temperaturelabel.topAnchor.constraint(equalTo: citylabel.bottomAnchor, constant: 10),
            temperaturelabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            imageView.centerYAnchor.constraint(equalTo: temperaturelabel.centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: temperaturelabel.leadingAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalToConstant: 75),
            imageView.heightAnchor.constraint(equalToConstant: 75),

            conditionlabel.topAnchor.constraint(equalTo: temperaturelabel.bottomAnchor, constant: 10),
            conditionlabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            tempStackView.topAnchor.constraint(equalTo: conditionlabel.bottomAnchor, constant: 10),
            tempStackView.trailingAnchor.constraint(equalTo: trailingAnchor),

            humiditylabel.topAnchor.constraint(equalTo: tempStackView.bottomAnchor, constant: 10),
            humiditylabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            windSpeedlabel.topAnchor.constraint(equalTo: humiditylabel.bottomAnchor, constant: 10),
            windSpeedlabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}

// MARK: - Configure
extension WeatherView {

    private func updateUI() {
        if let viewModel = viewModel {
            citylabel.text = "City: \(viewModel.getCityName() ?? "")"
            temperaturelabel.text = "Temperature: \(viewModel.getFormattedTemperature() ?? "")"
            conditionlabel.text = viewModel.getFormattedCondition()
            maxTemplabel.text = viewModel.getFormattedMaxTemperature()
            minTemplabel.text = viewModel.getFormattedMinTemperature()
            humiditylabel.text = viewModel.getFormattedHumidity()
            windSpeedlabel.text = viewModel.getFormattedWindSpeed()
        }
    }


//    func fetchWeather(for city: String) {
//        service.fetchWeather(for: city) { [weak self] result in
//            switch result {
//            case .success(let weather):
//                DispatchQueue.main.async {
//                    self?.citylabel.text = "City: \(weather.cityName)"
//                    self?.temperaturelabel.text = "Temperature: \(weather.temperature)°C"
//                    self?.conditionlabel.text = "Condition: \(weather.conditionID)"
//                    self?.maxTemplabel.text = "Max Temp: \(weather.maxTemperature)°C"
//                    self?.minTemplabel.text = "Min Temp: \(weather.minTemperature)°C"
//                    self?.humiditylabel.text = "Humidity: \(weather.humidity)%"
//                    self?.windSpeedlabel.text = "Wind Speed: \(weather.windSpeedString) m/s"
//                }
//            case .failure(let failure):
//                print("Error fetching weather: \(failure)")
//            }
//        }
//    }
}
