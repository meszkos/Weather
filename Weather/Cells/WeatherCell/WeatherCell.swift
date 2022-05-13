//
//  WeatherCell.swift
//  Weather
//
//  Created by MacOS on 12/05/2022.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let identifier = "WeatherCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "WeatherCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    public func configure(with model: WeatherModel){
        self.tempLabel.text = model.temp
        self.descriptionLabel.text = model.description
        self.hourLabel.text = model.hour
        self.weatherImage.image = UIImage(systemName: model.imageName)
    }
    
}
