//
//  LocationsViewModel.swift
//  BooksyWeather
//
//  Created by Marko Polietaiev on 07.12.2019.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import Foundation

protocol LocationsViewModelDelegate {
//    func didSelectLocation(_ location: Location)
}

class LocationsViewModel {
    
    var locationsViewModelDelegate: LocationsViewModelDelegate?
    
    var locations: [Location] = []
    
    init(locations: [Location]) {
        self.locations = locations
    }
    
    func didSelectLocation() {
//        locationsViewModelDelegate?.didSelectLocation()
    }

}
