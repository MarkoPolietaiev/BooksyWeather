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
    
    private static let sharedInstance: NetworkManager = {
        let instanse = NetworkManager()
        return instanse
    }()
    
    static func shared() -> NetworkManager {
        return sharedInstance
    }
    
    let baseURL: String = "http://api.openweathermap.org/data/2.5/forecast"
    let apiKey: String = "6633138b3f5fa2f95efd7ac4246baa2f"
    

}

//MARK: Requests
extension NetworkManager {
    
    typealias WebServiceResponse = (Location?, Error?) -> Void
    
    func getWeatherByCity(city: String, completion: @escaping WebServiceResponse) {
        let weatherRequestURL = "\(baseURL)?APPID=\(apiKey)&q=\(city)&units=metric"
        var location: Location?
        AF.request(weatherRequestURL).validate().response {
            response in
            if let error = response.error {
                completion(nil, error)
            } else {
                guard let data = response.data else { return }
                            let decoder = JSONDecoder()
                do {
                    location = try decoder.decode(Location.self, from: data)
                    completion(location, nil)
                }  catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                    completion(nil, error)
                }
            }
        }
    }
    
    func getWeatherByLocation(longtitude: Double, latitude: Double, completion: @escaping WebServiceResponse){
        let weatherRequestURL = "\(baseURL)?lat=\(latitude)&lon=\(longtitude)&cnt=1\(apiKey)&APPID=\(apiKey)"
        var location: Location?
        AF.request(weatherRequestURL).validate().response {
            response in
            if let error = response.error {
                completion(nil, error)
            } else {
                guard let data = response.data else { return }
                            let decoder = JSONDecoder()
                do {
                    location = try decoder.decode(Location.self, from: data)
                    completion(location, nil)
                }  catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                    completion(nil, error)
                }
            }
        }
    }
}
