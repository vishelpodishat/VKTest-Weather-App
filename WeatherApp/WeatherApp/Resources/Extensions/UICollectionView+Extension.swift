//
//  UICollectionView+Extension.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 25.03.2024.
//

import UIKit

public extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(cellForItemAt indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath) as! T
    }

    func register<T: UICollectionViewCell>(ofType type: T.Type) {
        register(T.self, forCellWithReuseIdentifier: "\(T.self)")
    }
}
