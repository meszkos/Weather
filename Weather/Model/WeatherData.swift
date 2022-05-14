//
//  WeatherData.swift
//  Weather
//
//  Created by MacOS on 13/05/2022.
//

import Foundation

struct WeatherData: Decodable{
    
        var list: [Hourly]
    
    struct Hourly: Codable{
        var main: Main
        var weather: [Weather]
        var dt: Double
        
    }
    struct Main: Codable{
        var temp: Double
        
    }
    
    struct Weather: Codable{
        var description: String
        var icon: String
        var id: Int
    }
}
