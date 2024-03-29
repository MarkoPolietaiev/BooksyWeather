//
//  PresentWeatherView.swift
//  BooksyWeather
//
//  Created by Marko Polietaiev on 05.12.2019.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import UIKit

class PresentWeatherView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(temperatureLabel)
        addSubview(cloudnessLabel)
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            //layout for main Label
            temperatureLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            temperatureLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -30),
            
            //layout for cloudness Label
            cloudnessLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
            cloudnessLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cloudnessLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cloudnessLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    lazy var temperatureLabel: UILabel = {
      let title = UILabel()
      title.font = UIFont.systemFont(ofSize: 45, weight: .medium)
      title.tintColor = .label
      title.text = "0"
      title.textAlignment = .center
      title.translatesAutoresizingMaskIntoConstraints = false
      return title
    }()
    
    lazy var cloudnessLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        title.tintColor = .secondaryLabel
        title.text = "cloudy"
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    override class var requiresConstraintBasedLayout: Bool {
      return true
    }
    
    override var intrinsicContentSize: CGSize {
      //preferred content size, calculate it if some internal state changes
      return CGSize(width: 150, height: 100)
    }
}
