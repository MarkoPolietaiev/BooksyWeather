//
//  LocationsViewModel.swift
//  BooksyWeather
//
//  Created by Marko Polietaiev on 07.12.2019.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import Foundation

protocol LocationsViewModelDelegate {
    func didSelectLocation()
    func didClickAddLocation(title: String, message: String)
    func deletedLocation(indexPath: IndexPath)
    func reloadTableData()
}

class LocationsViewModel {
    
    var locationsViewModelDelegate: LocationsViewModelDelegate?
    
    var locations: [Location] = []
    
    init(locations: [Location]) {
        if let savedLocations = UserDefaults.standard.object(forKey: "savedLocations") as? Data {
            let decoder = JSONDecoder()
            if let loadedLocations = try? decoder.decode([Location].self, from: savedLocations) {
                self.locations = loadedLocations
            }
        }
    }
    
    func didSelectLocation(_ at: IndexPath) {
        if let savedLocations = UserDefaults.standard.object(forKey: "savedLocations") as? Data {
            let decoder = JSONDecoder()
            if let loadedLocations = try? decoder.decode([Location].self, from: savedLocations) {
                let selectedLocation = loadedLocations[at.row]
                // pass selected location to main VC
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateLocation"), object: nil, userInfo: ["location" : selectedLocation])
                self.locationsViewModelDelegate?.didSelectLocation()
            }
        }
    }
    
    func addLocation() {
        let title: String = "Add City By Its Name :)"
        let message: String = "Examples: Warszawa, Zbarz."
        self.locationsViewModelDelegate?.didClickAddLocation(title: title, message: message)
    }
    
    func searchForLocationByCity(_ name: String) {
        let networkManager = NetworkManager.shared()
        networkManager.getWeatherByCity(city: name) { (location, error) in
            if let error = error {
                print(error)
            } else if let location = location {
                if let savedLocations = UserDefaults.standard.object(forKey: "savedLocations") as? Data {
                    let decoder = JSONDecoder()
                    if let loadedLocations = try? decoder.decode([Location].self, from: savedLocations) {
                        var locations = loadedLocations
                        locations.append(location)
                        let encoder = JSONEncoder()
                        if let encoded = try? encoder.encode(locations) {
                            let userDefaults = UserDefaults.standard
                            userDefaults.set(encoded, forKey: "savedLocations")
                            self.locations = locations
                            self.locationsViewModelDelegate?.reloadTableData()
                        }
                    }
                }
            }
        }
    }
    
    func deleteLocation(_ indexPath: IndexPath) {
        let index = indexPath.row
        self.locations.remove(at: index)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self.locations) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(encoded, forKey: "savedLocations")
            self.locationsViewModelDelegate?.deletedLocation(indexPath: indexPath)
            self.locationsViewModelDelegate?.reloadTableData()
        }
    }

}
