//
//  UIViewController+Extension.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 22.03.2024.
//

import UIKit

// MARK: - TextField
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Alert Errors
extension UIViewController {
    func showAlert(for error: NetworkError) {
        let title: String
        let message: String

        switch error {
        case .invalidURLComponents:
            title = "Invalid URL Components"
            message = "The URL components are invalid."
        case .invalidURL:
            title = "Invalid URL"
            message = "The URL is invalid."
        case .weatherNotFound:
            title = "Weather Not Found"
                        message = "The weather data was not found."
        case .unableToParseJSON:
            title = "Unable to Parse JSON"
                       message = "The JSON data could not be parsed."
        }

        let alertController =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        let errorAction = UIAlertAction(title: "Error", style: .default, handler: nil)
        alertController.addAction(errorAction)
        present(alertController, animated: true, completion: nil)
    }
}


