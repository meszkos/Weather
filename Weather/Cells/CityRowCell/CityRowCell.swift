//
//  CityRowCell.swift
//  Weather
//
//  Created by MacOS on 12/05/2022.
//

import UIKit

class CityRowCell: UITableViewCell, UICollectionViewDelegateFlowLayout {
    
    var models = [WeatherModel]()
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    static let identifier = "CityRowCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "CityRowCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(WeatherCell.nib(), forCellWithReuseIdentifier: WeatherCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with models: [WeatherModel]){
        self.models = models
    }
}

//MARK: - CollectionView Methods

extension CityRowCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.identifier, for: indexPath) as! WeatherCell
        
        cell.configure(with: models[indexPath.row])
        
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        <#code#>
//    }
}
