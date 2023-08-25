//
//  WeatherView.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 16/08/2023.
//
import SwiftUI
struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    init(apiary: Apiary) {
        _viewModel = ObservedObject(wrappedValue: WeatherViewModel(apiary: apiary))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                let fiveDayForecast = viewModel.getFiveDayForecast()
                if let firstDayWeather = fiveDayForecast.first {
                    NavigationLink(destination: WeatherDetailView(weatherViewModel: viewModel, weatherList: fiveDayForecast, apiaryName: viewModel.apiaryName)) {
                        DailyWeatherView(weather: firstDayWeather, apiaryName: viewModel.apiaryName)
                    }
                } else {
                    Text("Loading weather data...")
                }
            }            .padding()
               // .onAppear {
//                    viewModel.fetchWeatherData()
//                }
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


struct DailyWeatherView: View {
    var weather: WeatherData
    var apiaryName: String
    
    var body: some View {
        
        VStack {
            HStack {
                if let firstWeather = weather.weather.first,
                   let weatherIcon = WeatherIcon(rawValue: firstWeather.icon) {
                    Text(firstWeather.description)
                    Image(systemName: weatherIcon.systemImageName)
                } else {
                    Text("N/A")
                    Image(systemName: "cloud")
                }
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
                    //Spacer()
                    WeatherRow(logo: "humidity.fill", name: "Hum", value: "\(weather.main.humidity) %")
                }
            }
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.blue.opacity(0.4))
        .cornerRadius(10)
        .frame(width: 250, height: 250)
    }
}

struct WeatherDetailView: View {
    
    var weatherViewModel: WeatherViewModel
    var weatherList: [WeatherData]
    var apiaryName: String
    var body: some View {
        VStack {
            Text(apiaryName)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            VStack{ //TODO: forecast to 12:00
                ForEach(weatherList, id: \.dt) { weather in
                    NavigationLink(destination: WeatherDetailHourlyView(weatherListForDay: weatherViewModel.getWeatherForDay(day: Date(timeIntervalSince1970: TimeInterval(weather.dt))), apiaryName: apiaryName)) {
                        HStack {
                            Text(Date(timeIntervalSince1970: TimeInterval(weather.dt)).formattedWithoutYear())
                                .font(.title3)
                                .bold()
                            
                            Spacer()
                            if let firstWeather = weather.weather.first,
                               let weatherIcon = WeatherIcon(rawValue: firstWeather.icon) {
                                Text(firstWeather.description)
                                Image(systemName: weatherIcon.systemImageName)
                            } else {
                                Text("N/A")
                                Image(systemName: "cloud")
                            }
                            Text("\(String(format: "%.1f", weather.main.temp))°C")
                                .font(.subheadline)
                                .bold()
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue.opacity(0.4))
                        .cornerRadius(10)
                        .padding(.vertical, 5)
                    }
                }
            }
        }
        .padding()
        .frame(width: 300)
    }
    
    
}

struct WeatherDetailHourlyView: View {
    var weatherListForDay: [WeatherData]
    var apiaryName: String
    
    var body: some View {
        VStack {
            Text(apiaryName)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            ScrollView(.vertical) {
                if weatherListForDay.isEmpty {
                    Text("Brak danych do wyświetlenia")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.red)
                } else {
                    ForEach(weatherListForDay, id: \.dt) { weather in
                        // TODO: tu ma być prognoza co 3h dla całego dnia ale cos jest nie tak!!
                        HStack {
                            Text(Date(timeIntervalSince1970: TimeInterval(weather.dt)).formatted(.dateTime.hour().minute()))
                                .font(.title3)
                                .bold()
                            
                            Spacer()
                            if let firstWeather = weather.weather.first,
                               let weatherIcon = WeatherIcon(rawValue: firstWeather.icon) {
                                Text(firstWeather.description)
                                Image(systemName: weatherIcon.systemImageName)
                            } else {
                                Text("N/A")
                                Image(systemName: "cloud")
                            }
                            Text("\(String(format: "%.1f", weather.main.temp))°C")
                                .font(.subheadline)
                                .bold()
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue.opacity(0.4))
                        .cornerRadius(10)
                        .padding(.vertical, 5)
                    }
                }
            }
            .padding()
        }
    }
    
}
