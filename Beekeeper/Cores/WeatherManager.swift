//
//  WeatherManager.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 17/08/2023.
//

import Foundation
import CoreLocation

class WeatherManager {
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherResponse {
        
        let ApiKey = "2cf58968364dce8a18154518e855ae80"
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(ApiKey)&units=metric") else {fatalError("Missing URL")}
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error fetching weather data")}
        
        let decodedWeatherData = try JSONDecoder().decode(WeatherResponse.self, from: data)
        
        return decodedWeatherData
    }
}

