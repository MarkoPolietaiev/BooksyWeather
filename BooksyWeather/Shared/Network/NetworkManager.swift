//
//  NetworkManager.swift
//  BooksyWeather
//
//  Created by Marko Polietaiev on 04.12.2019.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    private enum NetworkPath: String {
        case city
        case location
        
        static let baseURL: String = "http://api.openweathermap.org/data/2.5/weather"
        static let apiKey: String = "6633138b3f5fa2f95efd7ac4246baa2f"
        
        var url: String {
            return NetworkPath.baseURL + self.rawValue + NetworkPath.apiKey
        }
    }
    
    func getWeather(city: String) {
        let weatherRequestURL = "\(NetworkPath.baseURL)?APPID=\(NetworkPath.apiKey)&q=\(city)"
        AF.request(weatherRequestURL).response { response in
            guard let data = response.data else { return }
            do {
                print("Raw data:\n\(data)\n")
                let dataString = String(data: data, encoding: String.Encoding.utf8)
                print("Human-readable data:\n\(dataString ?? "")")
            } catch let error {
                print(error)
            }
        }
    }
}
