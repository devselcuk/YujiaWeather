//
//  TopCitiesViewController.swift
//  YujiaWeather
//
//  Created by MacMini on 27.09.2021.
//

import UIKit

class TopCitiesViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var cities : [City] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        AccuClient().executeTopCities { result in
            switch result {
                
            case .success( let cities):
                self.cities = cities
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }

        // Do any additional setup after loading the view.
    }
    


    
    

}


extension TopCitiesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "city")!
        let city = cities[indexPath.row]
        if #available(iOS 14.0, *) {
            var config = cell.defaultContentConfiguration()
            config.image = UIImage(named: "\(city.WeatherIcon)")
            config.text = city.EnglishName
            config.secondaryText = city.WeatherText
            
            let label = UILabel()
            label.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
            label.text = "\(city.Temperature.Metric.Value)˚C"
            cell.accessoryView = label
            
            cell.contentConfiguration = config
        } else {
            // Fallback on earlier versions
        }
      
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        cities.first?.EpochTime.date() ?? ""
    }
    
    
    
}
