//
//  City.swift
//  BooksyWeather
//
//  Created by Marko Polietaiev on 08.12.2019.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import Foundation

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}
