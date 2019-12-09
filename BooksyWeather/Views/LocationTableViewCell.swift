//
//  LocationTableViewCell.swift
//  BooksyWeather
//
//  Created by Marko Polietaiev on 09.12.2019.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    var location: Location? {
        didSet {
            if isCurrentLocation {
                geoLabel.text = "Current Location"
            }
            nameLabel.text = location?.city.name
            tempLabel.text = "\(location?.list[0].main.temp.rounded() ?? 0)º"
        }
    }
    
    var isCurrentLocation: Bool = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35, weight: .medium)
        label.tintColor = .label
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        label.tintColor = .label
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var geoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.tintColor = .label
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupView() {
        addSubview(geoLabel)
        addSubview(nameLabel)
        addSubview(tempLabel)
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            
            geoLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor),
            geoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            tempLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
    }
    
    override class var requiresConstraintBasedLayout: Bool {
      return true
    }
}
