//
//  LocationsViewController.swift
//  BooksyWeather
//
//  Created by Marko Polietaiev on 07.12.2019.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import UIKit

class LocationsViewController: UIViewController {
    
    var viewModel: LocationsViewModel!
    
    let addButton = UIButton()
    let tableView = UITableView()
    
    var safeArea: UILayoutGuide!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
        safeArea = view.layoutMarginsGuide
        viewModel.locationsViewModelDelegate = self
        setupViews()
    }
    
    fileprivate func setupButton() {
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 15).isActive = true
        addButton.trailingAnchor.constraint(equalTo: self.safeArea.trailingAnchor, constant: 10).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        addButton.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
    }
    
    fileprivate func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = false
        tableView.showsVerticalScrollIndicator = false
         tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "tableCellId")
        tableView.backgroundColor = .clear
        tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.safeArea.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.safeArea.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.safeArea.bottomAnchor).isActive = true
    }
    
    fileprivate func setupViews() {
        setupButton()
        setupTableView()
    }
    
    @objc func addButtonClicked() {
        
    }
}

extension LocationsViewController: LocationsViewModelDelegate {
    
}

extension LocationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension LocationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellId", for: indexPath) as? LocationTableViewCell else {
            fatalError("Unable to create cell!")
        }
        if indexPath.row == 0 {
            cell.isCurrentLocation = true
        }
        cell.location = viewModel.locations[indexPath.row]
        return cell
    }
    
    
}
