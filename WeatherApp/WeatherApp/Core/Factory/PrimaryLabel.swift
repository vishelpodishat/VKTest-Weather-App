//
//  PrimaryLabel.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 25.03.2024.
//

import UIKit

final class UILabelComponent: UILabel {

    enum FontColor {
        case primary
        case secondary
    }

    public private(set) var labelText: String
    public private(set) var fontSize: CGFloat
    public private(set) var fontWeight: UIFont.Weight
    public private(set) var fontColor: FontColor

    init(labelText: String, fontSize: CGFloat, fontWeight: UIFont.Weight, fontColor: FontColor) {
        self.labelText = labelText
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.fontColor = fontColor

        super.init(frame: .zero)
        self.configureLabelColor()
        self.configureLabelStyle()

        self.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSMutableAttributedString(string: labelText)
        self.attributedText = attributedString
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLabelColor() {
        switch self.fontColor {
        case .primary:
            self.textColor = AppColors.primary
        case .secondary:
            self.textColor = AppColors.secondary
        }
    }

    private func configureLabelStyle() {
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        self.lineBreakMode = .byTruncatingTail
        self.textAlignment = .center
    }
}
