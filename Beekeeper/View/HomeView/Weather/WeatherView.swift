//
//  WeatherView.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 16/08/2023.
//
import SwiftUI
struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel

    init(apiary: Apiary) {
        _viewModel = StateObject(wrappedValue: WeatherViewModel(apiary: apiary))
    }

    var body: some View {
        NavigationView {
            VStack {
                if let weatherList = viewModel.weather?.list.prefix(1) {
                    ForEach(weatherList, id: \.dt) { weather in
                        NavigationLink(destination: WeatherDetailView(weatherList: Array(weatherList), apiaryName: viewModel.apiaryName)) {
                            DailyWeatherView(weather: weather, apiaryName: viewModel.apiaryName)
                        }
                    }
                } else {
                    Text("Loading weather data...")
                }
            }
            .padding()
            .onAppear {
                viewModel.fetchWeatherData(for: viewModel.apiaryLocation)
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleApiaryLocation = ApiaryLocation(id: UUID(), longitude: 23.23, latitude: 55.23)
        let sampleApiary = Apiary(id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440000")!,
                                  apiaryName: "Sample Apiary",
                                  apiaryLocation: sampleApiaryLocation,
                                  apiaryOwner: "John Doe")
        
        return WeatherView(apiary: sampleApiary)
    }
}

struct WeatherDetailView: View {
    var weatherList: [WeatherData]
    var apiaryName: String
    var body: some View {
        VStack {
            Text(apiaryName)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            ForEach(weatherList, id: \.dt) { weather in
                ScrollView(.horizontal) {
                    Text(Date(timeIntervalSince1970: TimeInterval(weather.dt)).formatted(date: .abbreviated, time: .omitted))
                        .font(.title3)
                        .bold()
                    Spacer()
                    Text(weather.weather.first?.description ?? "N/A")
                    Image(systemName: "cloud.sun.fill") // Tu można użyć odpowiedniej ikony
                    Text("\(String(format: "%.1f", weather.main.temp))°C")
                        .font(.subheadline)
                        .bold()
                    Text("\(String(format: "%.1f", weather.main.temp))°C")
                }
            
                .foregroundColor(.white)
                .padding()
                .background(Color.blue.opacity(0.4))
                .cornerRadius(10)
            }
            
        }
        .padding()
           }
       }
        struct DailyWeatherView: View {
            var weather: WeatherData
            var apiaryName: String
            
            var body: some View {
                VStack {
                    VStack {
                        HStack {
                            Text(weather.weather.first?.description ?? "N/A")
                            //add image correct to weather??
                            Image(systemName: "cloud.sun.fill")
                                .font(.title2)
                                .padding(.bottom, 20)
                        }
                        
                        VStack {
                            Text("\(String(format: "%.1f", weather.main.temp))°C")
                                .bold()
                                .font(.title)
                            
                            HStack{
                                Text("\(String(format: "%.1f", weather.main.temp_max))°C / \(String(format: "%.1f", weather.main.temp_min))°C")
                            }
                            
                            Text("\(weather.main.pressure) hPa")
                            
                            HStack{
                                WeatherRow(logo: "wind", name: "Wind speed", value: "\(String(format: "%.1f", weather.wind.speed))m/s")
                                Spacer()
                                WeatherRow(logo: "humidity.fill", name: "Hum", value: "\(weather.main.humidity) %")
                            }
                            
                            
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue.opacity(0.4))
                    .cornerRadius(10)
                    .frame(width: 220, height: 300)
                }
            }
        }
        
        
