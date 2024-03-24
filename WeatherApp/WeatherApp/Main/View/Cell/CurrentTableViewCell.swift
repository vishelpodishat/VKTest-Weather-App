//
//  CurrentTableViewCell.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 25.03.2024.
//

import UIKit

final class CurrentTableViewCell: UITableViewCell {

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

    let weatherImageView: UIImageView = {
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
extension CurrentTableViewCell {
    // MARK: - Setup Views
    private func setupViews() {
        [citylabel, temperaturelabel, weatherImageView, conditionlabel,
         tempStackView, humiditylabel, windSpeedlabel].forEach(addSubview)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            citylabel.topAnchor.constraint(equalTo: topAnchor),
            citylabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            temperaturelabel.topAnchor.constraint(equalTo: citylabel.bottomAnchor, constant: 10),
            temperaturelabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            weatherImageView.centerYAnchor.constraint(equalTo: temperaturelabel.centerYAnchor),
            weatherImageView.trailingAnchor.constraint(equalTo: temperaturelabel.leadingAnchor, constant: -20),
            weatherImageView.widthAnchor.constraint(equalToConstant: 75),
            weatherImageView.heightAnchor.constraint(equalToConstant: 75),

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
