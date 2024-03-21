//
//  WeatherSearchBar.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 21.03.2024.
//

import UIKit

final class WeatherSearchBar: UISearchBar {

    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views
    private func style() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        layer.cornerRadius = 10
        delegate = self
        barTintColor = .white
        endEditing(true)
        searchTextField.backgroundColor = .white
        searchTextField.font = .systemFont(ofSize: 14, weight: .semibold)
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "",
            attributes: [NSAttributedString.Key.foregroundColor:
                            AppColors.searchBar]
        )
        endEditing(true)
        setImage(UIImage(named: "SearchIcon"), for: .search, state: .normal)
        setImage(UIImage(named: "ClearIcon"), for: .clear, state: .normal)
    }
}

extension WeatherSearchBar: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   shouldChangeTextIn range: NSRange,
                   replacementText text: String) -> Bool {
        let maxLength = 30
        let currentString = (searchTextField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: text)

        return newString.count <= maxLength
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder() // Show keyboard
    }
}
