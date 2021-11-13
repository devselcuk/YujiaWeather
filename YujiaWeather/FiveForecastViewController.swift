//
//  FiveForecastViewController.swift
//  YujiaWeather
//
//  Created by MacMini on 27.09.2021.
//

import UIKit

class FiveForecastViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
      
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(forecast?.DailyForecasts.count)
        if forecast?.DailyForecasts.count == 0 || forecast?.DailyForecasts.count == nil {
            let alert = UIAlertController(title: "Need Location", message: "Please go to Current screen first, after you fetch current conditions you can come back and see forecasts ", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    


}



extension FiveForecastViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        forecast?.DailyForecasts.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "day") as! DayTableViewCell
        
        if let daily = forecast?.DailyForecasts[indexPath.section] {
            cell.configure(with: daily)
        }
       
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        215
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let daily = forecast?.DailyForecasts[section] {
            return daily.EpochDate.date()
        } else {
           return  nil
        }
    }
    
    
    
}
