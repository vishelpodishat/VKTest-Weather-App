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
        case .invalidURL:
            title = "Invalid URL Components"
            message = "The URL components are invalid."
        case .requestFailed:
            title = "Invalid Request Components"
            message = "The Request components are invalid."
        case .networkFailed:
            title = "Network Error"
            message = "The Network are invalid."
        case .decodingFailed:
            title = "Invalid Decoding Try"
            message = "The Decoding error"
        case .dataFailed:
            title = "Invalid Data Components"
            message = "The Data components are invalid."
        }

        let alertController =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        let errorAction = UIAlertAction(title: "Error", style: .default, handler: nil)
        alertController.addAction(errorAction)
        present(alertController, animated: true, completion: nil)
    }
}


