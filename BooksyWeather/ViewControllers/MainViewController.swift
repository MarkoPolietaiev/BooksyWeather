//
//  ViewController.swift
//  BooksyWeather
//
//  Created by Marko Polietaiev on 03.12.2019.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class MainViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        startTest()
        view.addSubview(PresentWeatherView(frame: CGRect(x: self.view.center.x - 100, y: 10, width: 200, height: 200)))
    }
}

extension MainViewController {
    func startTest() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        getWeatherByLocation()
    }
    
    func getWeatherByLocation() {
        guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
        AF.request("http://api.openweathermap.org/data/2.5/find?lat=\(locValue.latitude)&lon=\(locValue.longitude)&cnt=1&appid=6633138b3f5fa2f95efd7ac4246baa2f").response { responde in
            guard let data = responde.data else { return }
            do {
                let dataString = String(data: data, encoding: String.Encoding.utf8)
                print("Human-readable data:\n\(dataString ?? "")")
            } catch let error {
                print(error)
            }
        }
    }
}

