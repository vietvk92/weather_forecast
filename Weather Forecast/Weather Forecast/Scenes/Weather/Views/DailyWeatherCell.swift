//
//  DailyWeatherCell.swift
//  Weather Forecast
//
//  Created by Thu Hien on 24/10/2021.
//

import UIKit

class DailyWeatherCell: UITableViewCell {
    
    static let identifier = "DailyWeatherCell"
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.prepareForConstraints()
        stackView.axis = .vertical
        stackView.spacing = 16.0
        return stackView
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        dateLabel.numberOfLines = 0
        return dateLabel
    }()
    
    private lazy var tempLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    private lazy var pressureLabel: UILabel = {
        let pressureLabel = UILabel()
        pressureLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        pressureLabel.numberOfLines = 0
        return pressureLabel
    }()
    
    private lazy var humidityLabel: UILabel = {
        let humidityLabel = UILabel()
        humidityLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        humidityLabel.numberOfLines = 0
        return humidityLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    private lazy var weatherImage: ImageLoader = {
        let weatherImage = ImageLoader()
        weatherImage.prepareForConstraints()
        return weatherImage
    }()
    
    var dailyWeather: DailyWeather? {
        didSet {
            configureCell()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(tempLabel)
        stackView.addArrangedSubview(pressureLabel)
        stackView.addArrangedSubview(humidityLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.pinEdges(to: contentView, equalTo: .init(top: 20, left: 20, bottom: 20))
        
        weatherImage.pinEdges(to: contentView, equalTo: .init(right: 20))
        weatherImage.center(.vertically, in: stackView)
        weatherImage.constraintTo(width: 60, height: 60)
        weatherImage.chain(.horizontally, to: stackView, with: 20)
    }
    
    private func configureCell() {
        guard let weather = self.dailyWeather else { return }
        pressureLabel.text = "Pressure: \(weather.pressure ?? 0)"
        humidityLabel.text = "Humidity: \(weather.humidity ?? 0)%"
        dateLabel.text = "Date: \((weather.date ?? 0).convertToFormat())"
        descriptionLabel.text = "Description: " + (weather.description ?? "")
        tempLabel.text = "Average Temperature: \(weather.avgTemparature ?? 0)°C"
        guard let iconUrl = weather.iconUrl else {return}
        weatherImage.loadImageWithUrl(iconUrl)
        applyAccessibility(weather)
    }
}

// MARK: - Accessibility
extension DailyWeatherCell {
    func applyAccessibility(_ weather: DailyWeather) {
        self.isAccessibilityElement = true
        self.accessibilityLabel = "The weather date \((weather.date ?? 0).convertToFormat()) \(weather.description ?? ""), average temperature is \(weather.pressure ?? 0), pressure is \(weather.pressure ?? 0) and humidity is \(weather.humidity ?? 0)"

        pressureLabel.font = UIFont.preferredFont(forTextStyle: .body)
        pressureLabel.adjustsFontForContentSizeCategory = true

        humidityLabel.font = UIFont.preferredFont(forTextStyle: .body)
        humidityLabel.adjustsFontForContentSizeCategory = true

        dateLabel.font = UIFont.preferredFont(forTextStyle: .body)
        dateLabel.adjustsFontForContentSizeCategory = true

        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.adjustsFontForContentSizeCategory = true

        tempLabel.font = UIFont.preferredFont(forTextStyle: .body)
        tempLabel.adjustsFontForContentSizeCategory = true
    }
}
