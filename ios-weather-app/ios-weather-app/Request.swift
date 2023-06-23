//
//  Request.swift
//  ios-weather-app
//
//  Created by Fabrizio Liani on 23/06/2023.
//

import SwiftUI
import Foundation
import Alamofire

struct ResponseData: Codable {
    let location: Location
    let current: Current
    
    struct Location: Codable {
        let name: String
        let region: String
        let country: String
        let lat: Double
        let lon: Double
        let tz_id: String
        let localtime_epoch: TimeInterval
        let localtime: String
    }
    
    struct Current: Codable {
        let last_updated_epoch: TimeInterval
        let last_updated: String
        let temp_c: Double
        let temp_f: Double
        let is_day: Int
        let condition: Condition
        let wind_mph: Double
        let wind_kph: Double
        let wind_degree: Int
        let wind_dir: String
        let pressure_mb: Double
        let pressure_in: Double
        let precip_mm: Double
        let precip_in: Double
        let humidity: Int
        let cloud: Int
        let feelslike_c: Double
        let feelslike_f: Double
        let vis_km: Double
        let vis_miles: Double
        let uv: Double
        let gust_mph: Double
        let gust_kph: Double
    }
    
    struct Condition: Codable {
        let text: String
        let icon: String
        let code: Int
    }
}

func sendHTTPRequest(loc: String) {
    
    AF.request("https://api.weatherapi.com/v1/forecast.json?key=4c276720c55044a2a16215704231506&q=\(loc)&days=1&aqi=no&alerts=no").responseDecodable(of: ResponseData.self) { response in
        
        switch response.result {
        case .success(let responseData):
            print("Response: \(responseData)")
            
        case .failure(let error):
            print("Error: \(error)")
        }
    }
}
