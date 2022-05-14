//
//  ViewController.swift
//  Weather
//
//  Created by MacOS on 12/05/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var manager = WeatherManager()
    var hourlyForecast = [WeatherModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        
        manager.performRequest(with: "https://api.openweathermap.org/data/2.5/forecast?q=london&appid=639a60b1b7177be0be3f47585cdc8538&units=metric")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CityRowCell.nib(), forCellReuseIdentifier: CityRowCell.identifier)
        
    }
}


extension HomeViewController: WeatherManagerDelegate{
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: [WeatherModel]) {
        DispatchQueue.main.async {
            for hourForecast in weather{
                self.hourlyForecast.append(hourForecast)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    
    }
    
    func didFailWithError(error: Error) {
        //
    }
    
    
}


//MARK: - TableView Methods

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityRowCell.identifier, for: indexPath) as! CityRowCell
        
        cell.configure(with: hourlyForecast)
        print("hourly forecast is ---- \(hourlyForecast)")
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
