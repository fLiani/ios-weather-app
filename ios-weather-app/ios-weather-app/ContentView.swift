//
//  ContentView.swift
//  ios-weather-app
//
//  Created by Fabrizio Liani on 13/06/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight = false
    
    let dayArray = ["MON", "TUE", "WED", "THUR", "FRI"]
    let weather = ["cloud.sun.fill", "cloud.fill", "cloud.fill", "sun.max.fill", "sun.max.fill"]
    let temperature = [23, 21, 24, 30, 32]
    
    var body: some View {
        ZStack {
            GradientView(isNight: $isNight)
            VStack {
                CityView(cityName: "Lancaster, UK")
                
                BigWeatherView(weather: "cloud.sun.fill", temperature: 29)
                                
                WeekWeatherView(weekDay: dayArray, weekWeather: weather, temperature: temperature)
                
                Spacer()
                
                Button{
                    isNight.toggle()
                } label: {
                    WeatherButtonView(title: "Change Day Time",
                                      textColour: .blue,
                                      backgroundColour: .white)
                }
                
                Spacer()
            }
        }
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
    
    @Binding var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea(.all, edges: .all)
    }
}

struct CityView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct BigWeatherView: View {
    
    var weather: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: weather)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(temperature)")
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
