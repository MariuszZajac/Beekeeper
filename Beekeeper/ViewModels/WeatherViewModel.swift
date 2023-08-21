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
        fetchWeatherData(for: apiary.apiaryLocation)
    }

    func fetchWeatherData(for apiaryLocation: ApiaryLocation?) {
        guard let location = apiaryLocation else { return }

        weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude) { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    self.weather = weatherResponse
                }
            case .failure(let error):
                print("Błąd podczas pobierania danych pogodowych: \(error)")
            }
        }
    }
}
