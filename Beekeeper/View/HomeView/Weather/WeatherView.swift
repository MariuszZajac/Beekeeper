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
                    Text("Pasieka 1 ") //apiary name here
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    
                    HStack {
                        Text(weather.list.first?.weather.first?.description ?? "N/A")
                        //add image correct to weather??
                        Image(systemName: "cloud.sun.fill")
                            .font(.largeTitle)
                            .padding(.bottom, 20)
                    }
                    .padding(.bottom, 10)
                    VStack {
                        HStack{
                            WeatherRow(logo: "thermometer.sun", name: "Max", value: "\(String(format: "%.1f", weather.list.first?.main.temp_max ?? 0))°C")
                            Spacer()
                            WeatherRow(logo: "thermometer.snowflake", name: "Min", value: "\(String(format: "%.1f", weather.list.first?.main.temp_min ?? 0))°C")
                        }
                        HStack{
                            WeatherRow(logo: "wind", name: "Wind speed", value: "\(String(format: "%.1f", weather.list.first?.wind.speed ?? 0))m/s")
                            Spacer()
                            WeatherRow(logo: "humidity.fill", name: "Humidity", value: "\(weather.list.first?.main.humidity ?? 0) %")
                        }
                        
                        HStack {
                            WeatherRow(logo: "arrow.down", name: "Pressure", value: ("\(weather.list.first?.main.pressure ?? 0) hPa"))
                            
                        }
                    }
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue.opacity(0.2))
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
