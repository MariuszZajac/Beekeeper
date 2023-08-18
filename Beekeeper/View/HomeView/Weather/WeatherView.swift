//
//  WeatherView.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 16/08/2023.
//
import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel

    var body: some View {
        VStack {
            if let weather = viewModel.weather {
                VStack {
                    Text("Pasieka 1 temporary view ") //apiary name here
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    
                    HStack {
                        Text(weather.list.first?.weather.first?.description ?? "N/A")
                        //add image correct to weather??
                        Image(systemName: "cloud.sun.fill")
                            .font(.title2)
                            .padding(.bottom, 20)
                    }
                   
                    VStack {
                        Text("\(String(format: "%.1f", weather.list.first?.main.temp ?? 0))°C")
                            .bold()
                            .font(.title)
                        
                        HStack{
                            Text("\(String(format: "%.1f", weather.list.first?.main.temp_max ?? 0))°C / \(String(format: "%.1f", weather.list.first?.main.temp_min ?? 0))°C")
                        }
                        
                        Text("\(weather.list.first?.main.pressure ?? 0) hPa")
                        
                        HStack{
                            WeatherRow(logo: "wind", name: "Wind speed", value: "\(String(format: "%.1f", weather.list.first?.wind.speed ?? 0))m/s")
                            Spacer()
                            WeatherRow(logo: "humidity.fill", name: "Hum", value: "\(weather.list.first?.main.humidity ?? 0) %")
                        }
                        
                        
                    }
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)
                .frame(width: 220, height: 300)
            } else {
                Text("Loading weather data...")
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchWeatherData(for: )
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}


//
//import SwiftUI
//import CoreLocationUI
//
//struct WeatherView: View {
//    @StateObject var locationManager = LocationManager()
//    var weatherManager = WeatherManager()
//    @State var weather: WeatherResponse?
//
//    var body: some View {
//        VStack {
//            if let weather = weather {
//                VStack {
//                    Text("Pasieka 1 temporary view ") //apiary name here
//                        .font(.title2)
//                        .fontWeight(.bold)
//                        .padding(.bottom, 10)
//
//                    HStack {
//                        Text(weather.list.first?.weather.first?.description ?? "N/A")
//                        //add image correct to weather??
//                        Image(systemName: "cloud.sun.fill")
//                            .font(.title2)
//                            .padding(.bottom, 20)
//                    }
//
//                    VStack {
//                        Text("\(String(format: "%.1f", weather.list.first?.main.temp ?? 0))°C")
//                            .bold()
//                            .font(.title)
//
//                        HStack{
//                            Text("\(String(format: "%.1f", weather.list.first?.main.temp_max ?? 0))°C / \(String(format: "%.1f", weather.list.first?.main.temp_min ?? 0))°C")
//                        }
//
//                        Text("\(weather.list.first?.main.pressure ?? 0) hPa")
//
//                        HStack{
//                            WeatherRow(logo: "wind", name: "Wind speed", value: "\(String(format: "%.1f", weather.list.first?.wind.speed ?? 0))m/s")
//                            Spacer()
//                            WeatherRow(logo: "humidity.fill", name: "Hum", value: "\(weather.list.first?.main.humidity ?? 0) %")
//                        }
//
//
//                    }
//                }
//                .foregroundColor(.white)
//                .padding()
//                .background(Color.blue.opacity(0.2))
//                .cornerRadius(10)
//                .frame(width: 220, height: 300)
//            } else {
//                Text("Loading weather data...")
//            }
//        }
//        .padding()
//        .task {
//            do { //hardcode now. TODO: lon & lan dla każdej pasieki(Apiary) oddzielnie. pobieranie lokalizacji
//                weather = try await weatherManager.getCurrentWeather(latitude: 51.816282, longitude: 23.011893)
//            } catch {
//                print("Error getting weather \(error)")
//            }
//        }
//    }
//}
//
//struct WeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherView()
//    }
//}
