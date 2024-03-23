//
//  WeekTableViewCell.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 21.03.2024.
//

import UIKit

final class WeekTableViewCell: UITableViewCell {

    // MARK: - UI
    private let weekLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup
extension WeekTableViewCell {
    // MARK: - Setup Views
    private func setupViews() {
        [weekLabel, temperatureLabel].forEach(addSubview)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            weekLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            weekLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),

            temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: leadingAnchor, constant: -10),
        ])
    }
}


// MARK: - Configure
extension WeekTableViewCell {
    func configure(with model: WeekdayWeather) {
        weekLabel.text = "\(model.weekday.rawValue)"
        temperatureLabel.text = "\(String(format: "%.0f", model.temperature))°C"
    }
}
