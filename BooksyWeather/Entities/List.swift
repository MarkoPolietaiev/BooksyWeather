//
//  List.swift
//  BooksyWeather
//
//  Created by Marko Polietaiev on 08.12.2019.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import Foundation

struct List: Codable {
    let dt: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let sys: Sys
    let dt_txt: String
}
