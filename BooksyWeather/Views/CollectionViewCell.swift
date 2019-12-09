//
//  CollectionViewCell.swift
//  BooksyWeather
//
//  Created by Marko Polietaiev on 09.12.2019.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var list: List? {
        didSet {
            timeLabel.text = getProperDateString(list?.dt_txt)
            weatherIcon.load(url: URL.init(string: "http://openweathermap.org/img/w/" + (list?.weather[0].icon)! + ".png")!)
            tempLabel.text = "\(list?.main.temp.rounded() ?? 0)º"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var timeLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.tintColor = .label
        label.textAlignment = .center
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
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.tintColor = .label
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func getProperDateString(_ dateText: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateText!)!
        dateFormatter.dateFormat = "HH:SS"
        return dateFormatter.string(from: date)
    }
    
    private func setupView() {
        addSubview(timeLabel)
        addSubview(weatherIcon)
        addSubview(tempLabel)
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weatherIcon.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5),
            weatherIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weatherIcon.heightAnchor.constraint(equalToConstant: 35),
            weatherIcon.widthAnchor.constraint(equalToConstant: 35),
            tempLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 5),
            tempLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    override class var requiresConstraintBasedLayout: Bool {
      return true
    }
}
