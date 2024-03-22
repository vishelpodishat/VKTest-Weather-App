//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 22.03.2024.
//

import UIKit

final class WeatherView: UIView {

    // MARK: - UI
    private let citylabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let temperaturelabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .brokenClouds)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let conditionlabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let maxTemplabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let minTemplabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var tempStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [maxTemplabel, minTemplabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let humiditylabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let windSpeedlabel: UILabel = {
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
    public func configure(with model: WeatherModel) {
        citylabel.text = model.cityName
        temperaturelabel.text = "\(model.temperatureString)"
        if let icon = model.icon {
            let iconId = "https://openweathermap.org/img/wn/\(icon)@2x.png"
            if let iconURL = URL(string: iconId) {
                self.imageView.load(url: iconURL)
            }
        }
    }
}
