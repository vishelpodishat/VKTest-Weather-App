//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 25.03.2024.
//

import UIKit

final class ForecastCollectionViewDataSource<CELL: UICollectionViewCell, T>: NSObject, UICollectionViewDataSource {
    private var cellIdentifier: String!
    private var items: [T]!
    var configureCell: (CELL, T) -> () = {_,_ in }


    init(cellIdentifier: String!, items: [T]!, configureCell: @escaping (CELL, T) -> Void) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CELL
        let item = self.items[indexPath.item]
        self.configureCell(cell, item)
        return cell
    }
}
