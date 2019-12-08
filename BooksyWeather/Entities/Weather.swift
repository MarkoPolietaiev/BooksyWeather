//
//  Weather.swift
//  BooksyWeather
//
//  Created by Marko Polietaiev on 08.12.2019.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let description: String
    let icon: String
    let id: Int
    let main: String
}
