//
//  WeatherManager.swift
//  Weather
//
//  Created by MacOS on 13/05/2022.
//

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager{
    
    var hourlyWeatherData: [WeatherModel] = []
    
    let hourFormatter: DateFormatter = {
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "ha"
        return hourFormatter
    }()
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?q=london&appid=639a60b1b7177be0be3f47585cdc8538"
    let apiKey = "639a60b1b7177be0be3f47585cdc8538"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(for city: String){
        let urlString = "\(weatherURL)&q=\(city)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    
                    return
                }
                if let safeData = data{
                    print("safe data in")
                    parseJSON(safeData)
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ data: Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            print("DEBUG: \(decodedData)")
            
            for index in 0...7{
                //decodeddata.list.count
                let hourlyDate = Date(timeIntervalSince1970: decodedData.list[index].dt)
                let hour = hourFormatter.string(from: hourlyDate)
                //let hourlyImageName = decodedData.hourly[index].weather[0].icon
                let description = decodedData.list[0].weather[0].description
                let conditionsId = decodedData.list[index].weather[0].id
                let hourlyTemperature = decodedData.list[index].main.temp.rounded()
                
                
                let hourlyWeather = WeatherModel(temp: String(hourlyTemperature), description: description, hour: hour, conditionId: conditionsId)
                
                print(hourlyWeather)
                
            }

        }catch{
            delegate?.didFailWithError(error: error)
            print("DEBUG GOT ERROR \(error)")
        }
    }
}
