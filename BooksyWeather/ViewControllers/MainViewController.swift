//
//  ViewController.swift
//  BooksyWeather
//
//  Created by Marko Polietaiev on 03.12.2019.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class MainViewController: UIViewController, CLLocationManagerDelegate {
    
    var viewModel: MainViewModel! {
        didSet {
            navigationItem.title = viewModel.location.city.name
            weatherView.temperatureLabel.text = "\(viewModel.location.list[0].main.temp.rounded())º"
            weatherView.cloudnessLabel.text = viewModel.location.list[0].weather[0].description.capitalizingFirstLetter()
            //...
        }
    }
    
    let weatherView = PresentWeatherView()
    let tableView = UITableView()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .lightGray
        return cv
    }()
    var safeArea: UILayoutGuide!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .systemBackground
        viewModel.mainViewModelDelegate = self
        setupNavigation()
        setupViews()
    }
    
    func setupWeatherView() {
        view.addSubview(weatherView)
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        weatherView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 25).isActive = true
        weatherView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        collectionView.backgroundColor = .gray
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 15).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "tableCellId")
    }
    
    fileprivate func setupViews() {
        setupWeatherView()
        setupCollectionView()
        setupTableView()
    }
    
    fileprivate func setupNavigation() {
        let chooseLocationBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "list"), style: .done, target: self, action: #selector(chooseLocationClicked))
        let settingsBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "settings"), style: .done, target: self, action: #selector(settingsClicked))
        navigationItem.setLeftBarButton(chooseLocationBarButtonItem, animated: true)
        navigationItem.setRightBarButton(settingsBarButtonItem, animated: true)
        navigationController?.navigationBar.backgroundColor = .systemBackground
    }
    
    @objc fileprivate func chooseLocationClicked() {
        viewModel.locationsClicked()
    }
    
    @objc fileprivate func settingsClicked() {
        viewModel.settingsClicked()
    }
}

extension MainViewController: MainViewModelDelegate {
    func didClickedLocationsButton(_ viewController: UIViewController) {
        let viewController = LocationsViewController()
        viewController.modalPresentationStyle = .pageSheet
        viewController.modalTransitionStyle = .coverVertical
        present(viewController, animated: true, completion: nil)
    }
    
    func didClickedSettingsButton(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellId", for: indexPath) as? TableViewCell else { fatalError("Unable to create cell!") }
        cell.list = viewModel.location.list[indexPath.row*8]
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //return first 8 items from list
    }
    
    
}
