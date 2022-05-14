//
//  WeatherModel.swift
//  Weather
//
//  Created by MacOS on 13/05/2022.
//

import Foundation

struct WeatherModel{
    
    var temp: String
    var description: String
    var hour: String
    var conditionId: Int
    
    //var hourlyData: [WeatherData] = []
    
    var imageName: String{
        switch conditionId{
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
