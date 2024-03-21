//
//  UITableView+Extension.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 20.03.2024.
//

import UIKit

public extension UITableView {
    func dequeue<T: UITableViewCell>(cellForRowAt indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as! T
    }

    func register<T: UITableViewCell>(ofType type: T.Type) {
        register(T.self, forCellReuseIdentifier: "\(T.self)")
    }
}
