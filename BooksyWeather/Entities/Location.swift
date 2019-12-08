//
//  Location.swift
//  BooksyWeather
//
//  Created by Marko Polietaiev on 05.12.2019.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import Foundation
import CoreLocation

struct Location: Codable {
    
    let cod: String
    let message: Int
    let cnt: Int
    let list: [List]
    let city: City
}
