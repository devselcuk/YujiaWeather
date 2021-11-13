//
//  TabViewController.swift
//  YujiaWeather
//
//  Created by MacMini on 27.09.2021.
//

import UIKit
import CoreLocation

class TabViewController: UITabBarController {
    
    
    func updateLocation(with location : CLLocation) {
        
        if let navView = viewControllers?.first as? NavViewController {
            if let vc = navView.children.first as? ViewController {
                vc.fetchCityData(for: location)
            }
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedIndex = 2
        tabBar.isTranslucent = false
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
        
        
        
 

        // Do any additional setup after loading the view.
    }
    
    
    



}
