//
//  ViewController.swift
//  Weather
//
//  Created by MacOS on 12/05/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var models = [WeatherModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CityRowCell.nib(), forCellReuseIdentifier: CityRowCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        models.append(WeatherModel(temp: "25", description: "Rain", hour: "14:00",conditionId: 200))
        models.append(WeatherModel(temp: "25", description: "Rain", hour: "14:00",conditionId: 300))
        models.append(WeatherModel(temp: "25", description: "Rain", hour: "14:00",conditionId: 200))
        models.append(WeatherModel(temp: "25", description: "Rain", hour: "14:00",conditionId: 400))
        
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

//MARK: -

//struct Model{
//    var temp: String
//    var description: String
//    var hour: String
//    var imageName: String
//
//    init(temp: String, description: String, hour: String, imageName: String){
//        self.temp = temp
//        self.description = description
//        self.hour = hour
//        self.imageName = imageName
//    }
//}

