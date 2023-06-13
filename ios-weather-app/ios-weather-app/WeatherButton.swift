//
//  WeatherButton.swift
//  ios-weather-app
//
//  Created by Fabrizio Liani on 13/06/2023.
//

import SwiftUI

struct WeatherButtonView: View {
    
    var title: String
    var textColour: Color
    var backgroundColour: Color
    
    var body: some View {
            Text(title)
                .frame(width: 280, height: 50)
                .foregroundColor(textColour)
                .background(backgroundColour)
                .font(.system(size: 20, weight: .bold, design: .default))
                .cornerRadius(10)
        }
    }
