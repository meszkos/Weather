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
    var models = [WeatherModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CityRowCell.nib(), forCellReuseIdentifier: CityRowCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        manager.delegate = self
        
        manager.performRequest(with: "https://api.openweathermap.org/data/2.5/forecast?q=london&appid=639a60b1b7177be0be3f47585cdc8538&units=metric")
        
        models.append(WeatherModel(temp: "25", description: "Rain", hour: "14:00",conditionId: 200))
        models.append(WeatherModel(temp: "25", description: "Rain", hour: "14:00",conditionId: 300))
        models.append(WeatherModel(temp: "25", description: "Rain", hour: "14:00",conditionId: 200))
        models.append(WeatherModel(temp: "25", description: "Rain", hour: "14:00",conditionId: 400))
        
    }

}


extension HomeViewController: WeatherManagerDelegate{
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        //
    }
    
    func didFailWithError(error: Error) {
        //
    }
    
    
}


//MARK: - TableView Methods

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityRowCell.identifier, for: indexPath) as! CityRowCell
        
        cell.configure(with: models)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
