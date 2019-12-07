//
//  MainViewModel.swift
//  BooksyWeather
//
//  Created by Marko Polietaiev on 07.12.2019.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewModelDelegate {
    func didClickedSettingsButton(_ viewController: UIViewController)
    func didClickedLocationsButton(_ viewController: UIViewController)
}

class MainViewModel {
    
    var mainViewModelDelegate: MainViewModelDelegate?
    
    let location: Location
    
    init(location: Location) {
        self.location = location
    }
    
    func settingsClicked() {
        let viewController = SettingsViewController() as UIViewController
        mainViewModelDelegate?.didClickedSettingsButton(viewController)
    }
    
    func locationsClicked() {
        let viewController = LocationsViewController() as UIViewController
        mainViewModelDelegate?.didClickedLocationsButton(viewController)
    }
    
}
