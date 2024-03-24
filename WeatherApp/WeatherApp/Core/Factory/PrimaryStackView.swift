//
//  PrimaryStackView.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 25.03.2024.
//

import UIKit

class MinMaxTemperatureFocusComponent: UIStackView {

    enum TypeEnum {
        case min
        case max
    }

    public private(set) var temperatureText: String
    public private(set) var type: TypeEnum
    private var temperatureLabel: UILabel


    init(temperatureLabel: String, type: TypeEnum) {
        self.temperatureText = temperatureLabel
        self.type = type
        self.temperatureLabel = UILabel()

        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false

        let image = self.configureImage()
        self.temperatureLabel = self.configureTemperatureLabel()

        self.addArrangedSubview(image)
        self.addArrangedSubview((self.temperatureLabel))

        self.alignment = .leading
        self.axis = .horizontal
        self.spacing = 4
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureImage() -> UIImageView {
        var imageSystemName = ""

        switch self.type {
        case .max:
            imageSystemName = "arrow.up"
        case .min:
            imageSystemName = "arrow.down"
        }
        let image = UIImage(systemName: imageSystemName)?.scalePreservingAspectRatio(targetSize: CGSize(width: 20, height: 20)).withTintColor(AppColors.primary)
        let imageView = UIImageView(image: image)

        return imageView
    }

    private func configureTemperatureLabel() -> UILabel {
        let uiLabel = UILabel()

        uiLabel.text = self.temperatureText
        uiLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        uiLabel.textColor = AppColors.primary

        return uiLabel
    }

    public func updateTemperatureText(_ temperatureText: String) {
        self.temperatureLabel.text = temperatureText
    }
}


class Utils {
    public static func createStackView(items: [UIView], axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment, distribution: UIStackView.Distribution, spacing: CGFloat) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = axis
        stack.alignment = alignment
        stack.distribution = distribution
        stack.spacing = spacing

        items.forEach { view in
            stack.addArrangedSubview(view)
        }

        return stack
    }
}
