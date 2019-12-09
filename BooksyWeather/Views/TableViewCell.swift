//
//  TableViewCell.swift
//  BooksyWeather
//
//  Created by Marko Polietaiev on 08.12.2019.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var list: List? {
        didSet {
            dateLabel.text = getProperDateString(list?.dt_txt)
            weatherIcon.load(url: URL.init(string: "http://openweathermap.org/img/w/" + (list?.weather[0].icon)! + ".png")!)
            tempLabel.text = "\(list?.main.temp.rounded() ?? 0)º"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.tintColor = .label
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var weatherIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.tintColor = .label
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func getProperDateString(_ dateText: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateText!)!
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    private func setupView() {
        addSubview(dateLabel)
        addSubview(weatherIcon)
        addSubview(tempLabel)
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            dateLabel.widthAnchor.constraint(equalToConstant: 100),
            
            weatherIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            weatherIcon.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 30),
            weatherIcon.heightAnchor.constraint(equalToConstant: 35),
            weatherIcon.widthAnchor.constraint(equalToConstant: 35),
            
            tempLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25)
        ])
    }
    
    override class var requiresConstraintBasedLayout: Bool {
      return true
    }
}
