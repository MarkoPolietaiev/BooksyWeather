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
    func locationFound(_ location: Location)
}

class MainViewModel {
    
    var mainViewModelDelegate: MainViewModelDelegate?
    
    var location: Location?
    
    init(location: Location?) {
        self.location = location
    }
    
    func setLocationByCoordinates(_ lat: Double, lon: Double) {
        
    }
    
    func getLocationByCoordinates(_ longtitude: Double, latitude: Double) {
        NetworkManager.shared().getWeatherByLocation(longtitude: longtitude, latitude: latitude) { (location, error) in
             if let error = error {
                 //display error
                 print(error)
             } else if let location = location {
                 if let savedLocations = UserDefaults.standard.object(forKey: "savedLocations") as? Data {
                     let decoder = JSONDecoder()
                     if let loadedLocations = try? decoder.decode([Location].self, from: savedLocations) {
                         var newArray = loadedLocations
                         newArray[0] = location
                         let encoder = JSONEncoder()
                         if let encoded = try? encoder.encode(newArray) {
                             let userDefaults = UserDefaults.standard
                             userDefaults.set(encoded, forKey: "savedLocations")
                         }
                     }
                 } else {
                     let array:[Location] = [location]
                     let encoder = JSONEncoder()
                     if let encoded = try? encoder.encode(array) {
                         let userDefaults = UserDefaults.standard
                         userDefaults.set(encoded, forKey: "savedLocations")
                     }
                 }
                self.mainViewModelDelegate?.locationFound(location)
             }
         }
    }
}
