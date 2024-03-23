//
//  ListVC+TableView.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 20.03.2024.
//

import UIKit

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeekTableViewCell = tableView.dequeue(cellForRowAt: indexPath)
        cell.configure(with: WeekdayWeather(weekday: .friday, temperature: 32.34))
        return cell
    }
}
