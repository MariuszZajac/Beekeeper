//
//  WeatherView.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 16/08/2023.
//

import SwiftUI
import CoreLocationUI

struct WeatherView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: WeatherResponse?
    
    var body: some View {
        VStack {
            if let weather = weather {
                VStack {
                    Text("Weather Forecast")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    
                    HStack {
                        Text("Temperature:")
                        Text("\(weather.list.first?.main.temp ?? 0, specifier: "%.1f")°C")
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text("Description:")
                        Text(weather.list.first?.weather.first?.description ?? "N/A")
                    }
                    .padding(.bottom, 10)
                    
                    Image(systemName: "cloud.sun.fill")
                        .font(.largeTitle)
                        .padding(.bottom, 20)
                    
                    Text("Other Weather Details:")
                        .font(.headline)
                        .padding(.bottom, 10)
                    
                    HStack {
                        Text("Pressure:")
                        Text("\(weather.list.first?.main.pressure ?? 0) hPa")
                    }
                    
                    HStack {
                        Text("Humidity:")
                        Text("\(weather.list.first?.main.humidity ?? 0)%")
                    }
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            } else {
                Text("Loading weather data...")
            }
        }
        .padding()
        .task {
            do { //hardcode now. TODO: lon & lan dla każdej pasieki(Apiary) oddzielnie. pobieranie lokalizacji
                weather = try await weatherManager.getCurrentWeather(latitude: 51.816282, longitude: 23.011893)
            } catch {
                print("Error getting weather \(error)")
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
