//
//  WeatherViewController.swift
//  Weather Forecast
//
//  Created by Thu Hien on 24/10/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var configurator = WeatherConfiguratorImplementation()
    var presenter: WeatherPresenter!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.register(DailyWeatherCell.self, forCellReuseIdentifier: DailyWeatherCell.identifier)
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.updateHeight(height: 48)
        searchController.searchBar.searchTextField.placeholder = "Search City Name..."
        searchController.searchBar.setShowsCancelButton(false, animated: true)
        return searchController
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(weatherViewController: self)
        setupView()
    }
    
    private func setupView() {
        title = "Daily Weather"
        tableView.prepareForConstraints()
        tableView.pinEdges(to: view, equalTo: .all(0))
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        navigationItem.searchController = searchController
        hideKeyboardWhenTappedAround()
    }
}

// MARK: - SearchBar Delegate
extension WeatherViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty, searchText.count > 2 else {
            self.presenter.showInvalidInput()
            return
        }
        self.presenter.fetchDailyWeather(with: WeatherQuery(query: searchText))
    }
}

// MARK: - TableView DataSource
extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.numberOfDays
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherCell.identifier,
                                                       for: indexPath) as? DailyWeatherCell else {
            return UITableViewCell()
        }
        cell.dailyWeather = presenter.weather(day: indexPath.row)
        return cell
    }
}

// MARK: - Presenter
extension WeatherViewController: WeatherView {
    func displayWeather() {
        tableView.reloadData()
    }
    
    func display(error: String) {
        tableView.reloadData()
        showAlert(title: "Error!", message: error)
    }
    
    func showLoading() {
        self.view.showLoading()
    }
    
    func hiddenLoading() {
        self.view.stopLoading()
    }

}

// MARK: - Process Keyboard
extension WeatherViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(WeatherViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        searchController.searchBar.searchTextField.endEditing(true)
    }
}
