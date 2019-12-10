//
//  ViewController.swift
//  BooksyWeather
//
//  Created by Marko Polietaiev on 03.12.2019.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    var viewModel: MainViewModel! {
        didSet {
            navigationItem.title = viewModel.location?.city.name
            weatherView.temperatureLabel.text = "\(viewModel.location?.list[0].main.temp.rounded() ?? 0)º"
            weatherView.cloudnessLabel.text = viewModel.location?.list[0].weather[0].description.capitalizingFirstLetter()
        }
    }
    
    let weatherView = PresentWeatherView()
    let tableView = UITableView()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 80)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .lightGray
        return cv
    }()
    
    var safeArea: UILayoutGuide!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "updateLocation"), object: nil, queue: nil, using: updateViews)
        self.viewModel = MainViewModel(location: nil)
        self.safeArea = self.view.layoutMarginsGuide
        self.viewModel.mainViewModelDelegate = self
        self.view.backgroundColor = .systemBackground
        setupViews()
        setupNavigation()
    }
    
    override func loadView() {
        super.loadView()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        // after showing the permission dialog, the program will continue executing the next line before the user has tap 'Allow' or 'Disallow'
        // if previously user has allowed the location permission, then request location
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways){
            locationManager.requestLocation()
        }
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
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionCellId")
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
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "tableCellId")
    }
    
    fileprivate func setupViews() {
        setupWeatherView()
        setupCollectionView()
        setupTableView()
    }
    
    fileprivate func setupNavigation() {
        let chooseLocationBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "list"), style: .done, target: self, action: #selector(chooseLocationClicked))
        navigationItem.setLeftBarButton(chooseLocationBarButtonItem, animated: true)
        navigationController?.navigationBar.backgroundColor = .systemBackground
    }
    
    @objc fileprivate func chooseLocationClicked() {
        let viewController = LocationsViewController()
        viewController.modalPresentationStyle = .pageSheet
        viewController.modalTransitionStyle = .coverVertical
        let viewModel = LocationsViewModel.init()
        viewController.viewModel = viewModel
        present(viewController, animated: true, completion: nil)
    }
    
    fileprivate func updateViews(notification: Notification) -> Void{
        guard let location = notification.userInfo!["location"] as? Location else {return}
        viewModel.location = location
        self.collectionView.reloadData()
        self.tableView.reloadData()
        navigationItem.title = viewModel.location?.city.name
        weatherView.temperatureLabel.text = "\(viewModel.location?.list[0].main.temp.rounded() ?? 0)º"
        weatherView.cloudnessLabel.text = viewModel.location?.list[0].weather[0].description.capitalizingFirstLetter()
    }
}

//MARK: ViewModelDelegate

extension MainViewController: MainViewModelDelegate {
    func locationFound(_ location: Location) {
        viewModel = MainViewModel(location: location)
        viewModel.mainViewModelDelegate = self
        collectionView.reloadData()
        tableView.reloadData()
        navigationItem.title = viewModel.location?.city.name
        weatherView.temperatureLabel.text = "\(viewModel.location?.list[0].main.temp.rounded() ?? 0)º"
        weatherView.cloudnessLabel.text = viewModel.location?.list[0].weather[0].description.capitalizingFirstLetter()
    }
    
    func updateViews() {
        self.collectionView.reloadData()
        self.tableView.reloadData()
        navigationItem.title = viewModel.location?.city.name
        weatherView.temperatureLabel.text = "\(viewModel.location?.list[0].main.temp.rounded() ?? 0)º"
        weatherView.cloudnessLabel.text = viewModel.location?.list[0].weather[0].description.capitalizingFirstLetter()
    }
}

//MARK: TableView

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellId", for: indexPath) as? TableViewCell else { fatalError("Unable to create cell!") }
        cell.list = viewModel.location?.list[indexPath.row*8]
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

//MARK: CollectionView

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellId", for: indexPath) as? CollectionViewCell else {
            fatalError("Unable to create cell!")
        }
        cell.list = viewModel.location?.list[indexPath.row]
        return cell
    }
}

//MARK: LocationManager

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //updateViews
        viewModel.getLocationByCoordinates(Double(manager.location?.coordinate.longitude ?? 0), latitude: Double(manager.location?.coordinate.latitude ?? 0))
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied:
            fatalError()
        case .authorizedAlways:
            viewModel.getLocationByCoordinates(Double(manager.location?.coordinate.longitude ?? 0), latitude: Double(manager.location?.coordinate.latitude ?? 0))
        case .notDetermined:
            fatalError()
        case .restricted:
            fatalError()
        case .authorizedWhenInUse:
            viewModel.getLocationByCoordinates(Double(manager.location?.coordinate.longitude ?? 0), latitude: Double(manager.location?.coordinate.latitude ?? 0))
        @unknown default:
            fatalError()
        }
    }
}
