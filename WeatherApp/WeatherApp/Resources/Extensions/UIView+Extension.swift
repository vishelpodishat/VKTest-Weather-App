//
//  UIView+Extension.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 25.03.2024.
//

import UIKit

extension UIView {
    func insertGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let fromColor = AppColors.backgroundOne.cgColor
        let toColor = AppColors.backgroundTwo.cgColor

        gradientLayer.frame = bounds
        gradientLayer.colors = [fromColor, toColor]
        gradientLayer.locations = [0.5, 1.0]
        gradientLayer.startPoint = .zero
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
