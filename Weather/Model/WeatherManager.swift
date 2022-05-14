//
//  WeatherManager.swift
//  Weather
//
//  Created by MacOS on 13/05/2022.
//

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: [WeatherModel])
    func didFailWithError(error: Error)
}

struct WeatherManager{
    
    let hourFormatter: DateFormatter = {
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "ha"
        return hourFormatter
    }()
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?appid=639a60b1b7177be0be3f47585cdc8538&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    
    
//MARK: - Getting Data
    
    func fetchWeather(for cities: [String]){
        for city in cities{
            
            let urlString = "\(weatherURL)&q=\(city)"
            performRequest(with: urlString, city: city)
        }
    }
    
    func performRequest(with urlString: String, city: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    
                    return
                }
                if let safeData = data{
                    if let forecast = self.parseJSON(safeData, city: city){
                        delegate?.didUpdateWeather(self, weather: forecast)
                    }
                }
            }
            task.resume()
        }
    }
    
//MARK: - Decoding Data
    func parseJSON(_ data: Data, city: String) -> [WeatherModel]?{
        let decoder = JSONDecoder()
        var hourlyForecast: [WeatherModel] = []
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            for index in 0...7{
                
                let hourlyDate = Date(timeIntervalSince1970: decodedData.list[index].dt)
                let hour = hourFormatter.string(from: hourlyDate)
                
                
                let description = decodedData.list[0].weather[0].description
                let conditionsId = decodedData.list[index].weather[0].id
                let hourlyTemperature = decodedData.list[index].main.temp.rounded()
                let temperature = String(format: "%.0f", hourlyTemperature)
                
                
                let hourlyWeather = WeatherModel(cityName: city, temp: temperature, description: description, hour: hour, conditionId: conditionsId)
                hourlyForecast.append(hourlyWeather)
            }
            
            return hourlyForecast
        }catch{
            delegate?.didFailWithError(error: error)
            print("DEBUG GOT ERROR \(error)")
            return nil
        }
    }
}
