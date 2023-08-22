//
//  WeatherData.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 16/08/2023.
//

import Foundation
struct WeatherResponse: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [WeatherData]
}
struct WeatherData: Codable {
        struct Main: Codable {
            let temp: Double
            let feels_like: Double
            let temp_min: Double
            let temp_max: Double
            let pressure: Int
            let sea_level: Int
            let grnd_level: Int
            let humidity: Int
            let temp_kf: Double
        }
        
        struct Weather: Codable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
        
        struct Clouds: Codable {
            let all: Int
        }
        
        struct Wind: Codable {
            let speed: Double
            let deg: Int
            let gust: Double
        }
        
        struct Sys: Codable {
            let pod: String
        }
        
        let dt: Int
        let main: Main
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let visibility: Int
        let pop: Double
        let sys: Sys
        let dt_txt: String
    }

    

    


//    //    let lat: String = "51.816282"
//    let lon: String = "51.816282 23.011893"
//    let url = "api.openweathermap.org/data/2.5/forecast?lat=51.816282&lon=23.011893&appid=2cf58968364dce8a18154518e855ae80"
