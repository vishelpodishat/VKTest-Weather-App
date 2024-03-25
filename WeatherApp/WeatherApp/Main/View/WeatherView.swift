//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 22.03.2024.
//

import UIKit

final class WeatherView: UIView {

    //MARK: - Components
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.style = .large
        indicator.color = .white
        indicator.startAnimating()
        return indicator
    }()

    lazy var temperatureLabel = UILabelComponent(labelText: "", 
                                                 fontSize: 120,
                                                 fontWeight: .bold,
                                                 fontColor: .secondary)
    lazy var temperatureSymbolLabel = UILabelComponent(
        labelText: "°C",
        fontSize: 26,
        fontWeight: .bold,
        fontColor: .primary
    )
    lazy var maxTemperature = MinMaxTemperatureFocusComponent(
        temperatureLabel: "22°",
        type: .max
    )
    lazy var minTemperature = MinMaxTemperatureFocusComponent(
        temperatureLabel: "18°",
        type: .min
    )
    lazy var dayLabel = UILabelComponent(
        labelText: "Понедельник, 25",
        fontSize: 30,
        fontWeight: .regular,
        fontColor: .primary
    )
    lazy var dayDescription = UILabelComponent(
        labelText: "Чистое небо",
        fontSize: 24,
        fontWeight: .light,
        fontColor: .primary
    )

    lazy var temperatureImage: UIImageView = {
        let uiImage = UIImageView()
        uiImage.contentMode = .scaleAspectFit
        uiImage.translatesAutoresizingMaskIntoConstraints = false
        uiImage.image = UIImage(systemName: "sun.max.fill")?.scalePreservingAspectRatio(targetSize: CGSize(width: 120, height: 120)).withTintColor(.white)
        return uiImage
    }()

    lazy var probabilityPrecipitation = ComponentView(
        iconName: .rain,
        iconSize: CGSize(
            width: 30,
            height: 30
        ),
        descriptionText: "50%"
    )
    lazy var windSpeed = ComponentView(
        iconName: .wind,
        iconSize: CGSize(
            width: 30,
            height: 30
        ),
        descriptionText: "16 км/ч"
    )
    lazy var humidity = ComponentView(
        iconName: .humidity,
        iconSize: CGSize(
            width: 30,
            height: 30
        ),
        descriptionText: "50%"
    )

    //MARK: - Stacks Views
    lazy var temperatureMinMaxFocus = Utils.createStackView(
        items: [
            temperatureSymbolLabel,
            maxTemperature,
            minTemperature
        ],
        axis: .vertical,
        alignment: .leading,
        distribution: .equalCentering,
        spacing: 0
    )
    
    lazy var temperatureFocus =  Utils.createStackView(
        items: [
            temperatureLabel,
            temperatureMinMaxFocus
        ],
        axis: .horizontal,
        alignment: .center,
        distribution: .equalCentering,
        spacing: 0
    )
    
    lazy var temperatureDescription = Utils.createStackView(
        items: [
            temperatureImage,
            dayDescription
        ],
        axis: .vertical,
        alignment: .center,
        distribution: .fillProportionally,
        spacing: 10
    )
    
    lazy var aditionalInfoFocus =  Utils.createStackView(
        items: [
            probabilityPrecipitation,
            windSpeed,
            humidity
        ],
        axis: .horizontal,
        alignment: .center,
        distribution: .fillEqually,
        spacing: 64
    )
    
    lazy var container = Utils.createStackView(
        items: [
            temperatureFocus,
            dayLabel,
            temperatureDescription,
            aditionalInfoFocus,
            collectionView
        ],
        axis: .vertical,
        alignment: .center,
        distribution: .fillEqually,
        spacing: 0
    )

    // MARK: - CollectionView
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 1
        return flowLayout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ofType: WeatherCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        self.configureView()
        self.addSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        container.isHidden = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.configConstraints()
    }

    private func addSubViews() {
        self.addSubview(loadingIndicator)
        self.addSubview(container)
    }

    private func configConstraints() {
        NSLayoutConstraint.activate([
            self.loadingIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.loadingIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.temperatureImage.heightAnchor.constraint(lessThanOrEqualToConstant: 100),
            self.temperatureLabel.heightAnchor.constraint(equalToConstant: 100),
            self.temperatureMinMaxFocus.heightAnchor.constraint(equalTo: self.temperatureLabel.heightAnchor),
            self.container.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            self.container.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.container.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.container.trailingAnchor)
        ])
        // Configure Flow Layout
        self.flowLayout.itemSize = CGSize(width: frame.height * 0.15 - 1, height: frame.height * 0.15 - 1)
    }


    public func setupDelegates(collectionViewDelegate: UICollectionViewDelegate, collectionViewDataSource: UICollectionViewDataSource) {
        self.collectionView.delegate = collectionViewDelegate
        self.collectionView.dataSource = collectionViewDataSource
    }

    public func setupInfo(with viewModel: HomeScreenViewModel, index: Int) {
        self.loadingIndicator.stopAnimating()
        self.temperatureLabel.text = viewModel.getTemperature(index)
        self.minTemperature.updateTemperatureText(viewModel.getMinTemperature(index))
        self.maxTemperature.updateTemperatureText(viewModel.getMaxTemperature(index))
        self.dayLabel.text = viewModel.getDayAndDate(index)
        self.temperatureImage.image = viewModel.getTemperatureImage(index)
        self.dayDescription.text = viewModel.getDayDescription(index)
        self.probabilityPrecipitation.updateData(descriptionText: viewModel.getProbabilityPrecipitation(index))
        self.windSpeed.updateData(descriptionText: viewModel.getWindSpeed(index))
        self.humidity.updateData(descriptionText: viewModel.getHumidity(index))

        UIView.transition(
            with: self.container,
            duration: 0.1,
            options: .transitionCrossDissolve,
            animations: nil
        )
    }

    public func showContainer(isHidden: Bool) {
        UIView.transition(
            with: self.container,
            duration: 0.2,
            options: .transitionCrossDissolve,
            animations: {self.container.isHidden = isHidden }
        )
    }
}

