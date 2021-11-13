//
//  DayTableViewCell.swift
//  YujiaWeather
//
//  Created by MacMini on 27.09.2021.
//

import UIKit

class DayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var blueView: UIView!
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var weatherTextLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet var smallViews: [SmallView]!
    
    @IBOutlet weak var qualityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        blueView.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with daily : Daily) {
        
        
        iconView.image = UIImage(named: "\(daily.Day.Icon)")
        weatherTextLabel.text = daily.Day.ShortPhrase
        tempLabel.text = daily.Temperature.Maximum.convertFormFtoC()
        
        smallViews[0].valueLabel.text = "%\(daily.Day.RainProbability)"
        smallViews[1].valueLabel.text = "%\(daily.Day.SnowProbability)"
        smallViews[2].valueLabel.text = "%\(daily.Day.ThunderstormProbability)"
        
        if #available(iOS 13.0, *) {
            smallViews[0].iconView.image = UIImage(systemName: "cloud.rain")
            smallViews[1].iconView.image = UIImage(systemName: "snow")
            smallViews[2].iconView.image = UIImage(systemName: "tropicalstorm")
        } else {
            // Fallback on earlier versions
        }
        
        
        smallViews[0].nameLabel.text = "Rain"
        smallViews[1].nameLabel.text = "Snow"
        smallViews[2].nameLabel.text = "Storm"
        
        qualityLabel.text = "Air quality is \(daily.AirAndPollen.first?.Category ?? "")"
        
        
    }

}
