//
//  ComponentView.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 25.03.2024.
//

import UIKit

final class ComponentView: UIView {

    enum AditionalInfoTypeEnum: String {
        case rain = "cloud.rain"
        case wind = "wind"
        case humidity = "humidity"
    }

    public private(set) var iconType: AditionalInfoTypeEnum
    public private(set) var iconSize: CGSize
    public private(set) var descriptionText: String

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var descriptionLabel = UILabelComponent(
        labelText: "",
        fontSize: 14,
        fontWeight: .regular,
        fontColor: .secondary
    )

    init(iconName: AditionalInfoTypeEnum, iconSize: CGSize, descriptionText: String) {
        self.iconType = iconName
        self.iconSize = iconSize
        self.descriptionText = descriptionText

        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        configure()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        self.imageView.image = UIImage(
            systemName: self.iconType.rawValue
        )?.scalePreservingAspectRatio(
            targetSize: self.iconSize
        ).withTintColor(
            AppColors.secondary
        )
        self.descriptionLabel.text = self.descriptionText
        self.contentStackView.addArrangedSubview(imageView)
        self.contentStackView.addArrangedSubview(descriptionLabel)
        addSubview(self.contentStackView)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            self.contentStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

    public func updateData(descriptionText: String) {
        self.descriptionText = descriptionText
        self.descriptionLabel.text = self.descriptionText
    }

}
