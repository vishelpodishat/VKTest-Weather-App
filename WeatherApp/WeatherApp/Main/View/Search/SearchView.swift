//
//  SearchView.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 25.03.2024.
//

import UIKit

final class SearchScreenView: UIView {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .clear
        tableView.alwaysBounceVertical = false
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        addSubview(tableView)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
        ])
    }

    public func setupDelegates(dataSource: UITableViewDataSource, tableDelegate: UITableViewDelegate) {
        self.tableView.dataSource = dataSource
        self.tableView.delegate = tableDelegate
    }
}
