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
                    Text(viewModel.apiaryName)
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
            viewModel.fetchWeatherData(for: viewModel.apiaryLocation)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleApiary = Apiary(id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440000")!,
                                      apiaryName: "Sample Apiary",
                                      apiaryLocation: ApiaryLocation(id: UUID(), longitude: 55.23, latitude: 23.23),
                                      apiaryOwner: "John Doe")

        return WeatherView(viewModel: WeatherViewModel(apiary: sampleApiary))
    }
}


