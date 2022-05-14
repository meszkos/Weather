//
//  ViewController.swift
//  Weather
//
//  Created by MacOS on 12/05/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cityNames = ["London", "Barcelona", "Paris"]
    
    var manager = WeatherManager()
    var hourlyForecast = [WeatherModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        manager.fetchWeather(for: cityNames )
        tableView.register(CityRowCell.nib(), forCellReuseIdentifier: CityRowCell.identifier)
        
    }
}

//MARK: - Delegate Methods

extension HomeViewController: WeatherManagerDelegate{
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: [WeatherModel]) {
        DispatchQueue.main.async {
            for hourForecast in weather{
                self.hourlyForecast.append(hourForecast)
                self.tableView.reloadData()
            }
        }
    }
    
    func didFailWithError(error: Error) {
        print("DEBUG: Fething weather data failed with error: \(error)")
    }
    
    
}


//MARK: - TableView Methods

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityRowCell.identifier, for: indexPath) as! CityRowCell
        
        switch indexPath.row{
        case 0:
            cell.cityLabel.text = "Paris"
            var parisForecast:[WeatherModel] = []
            if hourlyForecast.count == 24{
                for i in 0...8{
                    parisForecast.append(hourlyForecast[i])
                }
                
                cell.configure(with: parisForecast)
            }
        case 1:
            cell.cityLabel.text = "London"
            var londonForecast:[WeatherModel] = []
            if hourlyForecast.count == 24{
                for i in 8...15{
                    londonForecast.append(hourlyForecast[i])
                }
                
                cell.configure(with: londonForecast)
            }
            
        case 2:
            cell.cityLabel.text = "Barcelona"
            var barcelonaForecast:[WeatherModel] = []
            if hourlyForecast.count == 24{
                for i in 16...23{
                    barcelonaForecast.append(hourlyForecast[i])
                }

                cell.configure(with: barcelonaForecast)
            }
        
            
        default:
            cell.cityLabel.text = ""
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
