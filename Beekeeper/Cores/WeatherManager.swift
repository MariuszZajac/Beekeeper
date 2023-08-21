//
//  WeatherManager.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 17/08/2023.
//

import Foundation
import CoreLocation

class WeatherManager {
    
    let apiKey = "2cf58968364dce8a18154518e855ae80"
    
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            if let data = data {
                do {
                    let decodedWeatherData = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    completion(.success(decodedWeatherData))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NetworkError.noData))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
}


