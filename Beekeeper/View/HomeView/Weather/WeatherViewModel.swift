//
//  WeatherViewModel.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 18/08/2023.
//

import Foundation
import CoreLocation
import SwiftUI

class WeatherViewModel: ObservableObject {
    private let weatherManager = WeatherManager()
    @Published var selectedWeatherList: [WeatherData] = []
    @Published var weather: WeatherResponse?
    @Published var apiary: Apiary?
    
    var apiaryName: String {
        return apiary?.apiaryName ?? ""
    }
    var apiaryLocation: ApiaryLocation? {
        return apiary?.apiaryLocation
    }
    
    init(apiary: Apiary) {
        self.apiary = apiary
        //  fetchWeatherData(for: apiary.apiaryLocation)
    }
    
    func fetchWeatherData(for apiaryLocation: ApiaryLocation?) {
        guard let location = apiaryLocation else { return }
        
        weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude) { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    self.weather = weatherResponse
                    self.processWeatherData()
                }
            case .failure(let error):
                print("Błąd podczas pobierania danych pogodowych: \(error)")
            }
        }
    }
    func processWeatherData() {
        let weatherList = weather?.list ?? []

        let groupedWeatherList = Dictionary(grouping: weatherList, by: { weatherData in
            return Calendar.current.startOfDay(for: Date(timeIntervalSince1970: TimeInterval(weatherData.dt)))
        })

        selectedWeatherList = Array(groupedWeatherList.values.compactMap { weatherDataList in
            return weatherDataList.first
        }.prefix(5)) // średek dnia prognoza
    }
    
    func getWeatherForDay(day: Date) -> [WeatherData] {
        let calendar = Calendar.current
        return selectedWeatherList.filter { weatherData in
            let weatherDate = Date(timeIntervalSince1970: TimeInterval(weatherData.dt))
            return calendar.isDate(weatherDate, inSameDayAs: day)
        }
    }
    
    
    func getFiveDayForecast() -> [WeatherData] {
        let sortedWeatherList = selectedWeatherList.sorted(by: { $0.dt < $1.dt })
        var fiveDayForecast: [WeatherData] = []
        var uniqueDays: Set<String> = []

        for weatherData in sortedWeatherList {
            let date = Date(timeIntervalSince1970: TimeInterval(weatherData.dt))
            let dayString = date.formatted(date: .abbreviated, time: .omitted)
            
            if uniqueDays.insert(dayString).inserted {
                fiveDayForecast.append(weatherData)
                
            }
        }

        return fiveDayForecast
    }
    
}
extension Date {
    func formattedWithoutYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d" // np. "Sty 23"
        return dateFormatter.string(from: self)
    }
}
