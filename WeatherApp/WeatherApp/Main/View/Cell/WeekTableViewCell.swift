//
//  WeekTableViewCell.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 21.03.2024.
//

import UIKit

final class WeekTableViewCell: UITableViewCell {

    // MARK: - UI
    

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


extension WeekTableViewCell {
    // MARK: - Setup Views
    private func setupViews() {
        
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {

    }
}
