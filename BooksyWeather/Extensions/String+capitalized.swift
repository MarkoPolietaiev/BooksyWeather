//
//  String+capitalized.swift
//  BooksyWeather
//
//  Created by Marko Polietaiev on 08.12.2019.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
