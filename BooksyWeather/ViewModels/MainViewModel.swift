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
    
    var isCurrentLocation: Bool = true
    
    init(location: Location?) {
        self.location = location
    }
    
    func updateLocationData(_ longtitude: Double, latitude: Double, name: String) {
        if self.isCurrentLocation {
            getLocationByCoordinates(longtitude, latitude: latitude)
        } else {
            getLocationByCity(name)
        }
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
    
    func getLocationByCity(_ name: String) {
        NetworkManager.shared().getWeatherByCity(city: name) { (location, error) in
             if let error = error {
                 //display error
                 print(error)
             } else if let location = location {
                //rewrite info about location by city
//                 if let savedLocations = UserDefaults.standard.object(forKey: "savedLocations") as? Data {
//                     let decoder = JSONDecoder()
//                     if let loadedLocations = try? decoder.decode([Location].self, from: savedLocations) {
//                         var newArray = loadedLocations
//                        let oldLocation = newArray.first { (loc) -> Bool in
//                            return loc.city.name == location.city.name
//                        }
//                         let encoder = JSONEncoder()
//                         if let encoded = try? encoder.encode(newArray) {
//                             let userDefaults = UserDefaults.standard
//                             userDefaults.set(encoded, forKey: "savedLocations")
//                         }
//                     }
//                 }
                self.mainViewModelDelegate?.locationFound(location)
             }
         }
    }
}
