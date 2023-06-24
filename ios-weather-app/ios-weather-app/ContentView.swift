//
//  ContentView.swift
//  ios-weather-app
//
//  Created by Fabrizio Liani on 13/06/2023.
//

import SwiftUI
import Foundation
import Alamofire
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var responseData: ResponseData?
    
    func fetchWeatherData(loc: String) {
        AF.request("https://api.weatherapi.com/v1/forecast.json?key=4c276720c55044a2a16215704231506&q=\(loc)&days=1&aqi=no&alerts=no").responseDecodable(of: ResponseData.self) { response in
            
            switch response.result {
            case .success(let responseData):
                self.responseData = responseData
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.last != nil {
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle location retrieval error
        print("Failed to retrieve location: \(error.localizedDescription)")
    }
}

struct ContentView: View {
    
    @StateObject private var weatherViewModel = WeatherViewModel()
    
        
    let dayArray = ["MON", "TUE", "WED", "THUR", "FRI"]
    let weather = ["cloud.sun.fill", "cloud.fill", "cloud.fill", "sun.max.fill", "sun.max.fill"]
    let temperature = [23, 21, 24, 30, 32]
    
    @State private var responseData: ResponseData?
    
    var body: some View {
        ZStack {
            GradientView()
            VStack {
                CityView(cityName: weatherViewModel.responseData?.location.name ?? "", country: weatherViewModel.responseData?.location.country ?? "")
                
                BigWeatherView(weather: weatherViewModel.responseData?.current.condition.text ?? "", temperature: weatherViewModel.responseData?.current.temp_c ?? 0)
                
                WeekWeatherView(weekDay: dayArray, weekWeather: weather, temperature: temperature)
                
                Spacer()
                        
            }
        }
        .onAppear {
            weatherViewModel.fetchWeatherData(loc: "Stevenage")
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
    struct WeatherDayView: View {
        
        var dayOfWeek: String
        var imageName: String
        var temperature: Int
        
        var body: some View {
            VStack {
                Text(dayOfWeek)
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundColor(.white)
                Image(systemName: imageName)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                Text("\(temperature)")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(.white)
            }
        }
    }
    
    struct GradientView: View {
                
        var body: some View {
            LinearGradient(gradient: Gradient(colors: [.blue, Color("lightBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all, edges: .all)
        }
    }
    
    struct CityView: View {
        
        var cityName: String
        var country: String
        
        var body: some View {
            Text("\(cityName), \(country)")
                .font(.system(size: 32, weight: .medium, design: .default))
                .foregroundColor(.white)
                .padding()
        }
    }
    
    struct BigWeatherView: View {
        
        var weather: String
        var temperature: Double
        
        var body: some View {
            VStack(spacing: 10) {
                
                switch weather {
                case "Sunny":
                    Image(systemName:"sun.max.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 180)
                case "Partly cloudy":
                    Image(systemName:"cloud.sun.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 180)
                case "Cloudy":
                    Image(systemName:"cloud.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 180)
                case "Overcast":
                    Image(systemName:"cloud.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 180)
                        .foregroundColor(.gray)
                case "Mist":
                    Image(systemName:"cloud.fog.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 180)
                case "Patchy rain possible":
                    Image(systemName:"cloud.sun.rain.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 180)
                case "Patchy snow possible":
                    Image(systemName:"snowflake")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 180)
                case "Patchy sleet possible":
                    Image(systemName:"cloud.sleet.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 180)
                    
                default:
                    Image(systemName: "cloud.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 180)
                }
                
                Text("\(Int(temperature))°")
                    .font(.system(size: 70, weight: .medium))
                    .foregroundColor(.white)
            }
            .padding(.bottom, 40)
        }
    }
    
    struct WeekWeatherView: View {
        
        let weekDay: Array<String>
        let weekWeather: Array<String>
        let temperature: Array<Int>
        
        var body: some View {
            HStack(spacing: 20) {
                WeatherDayView(dayOfWeek: weekDay[0],
                               imageName: weekWeather[0],
                               temperature: temperature[0])
                WeatherDayView(dayOfWeek: weekDay[1],
                               imageName: weekWeather[1],
                               temperature: temperature[1])
                WeatherDayView(dayOfWeek: weekDay[2],
                               imageName: weekWeather[2],
                               temperature: temperature[2])
                WeatherDayView(dayOfWeek: weekDay[3],
                               imageName: weekWeather[3],
                               temperature: temperature[3])
                WeatherDayView(dayOfWeek: weekDay[4],
                               imageName: weekWeather[4],
                               temperature: temperature[4])
            }
        }
    }
}
