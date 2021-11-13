//
//  NewLocViewController.swift
//  YujiaWeather
//
//  Created by MacMini on 27.09.2021.
//

import UIKit
import MapKit

class NewLocViewController: UIViewController {
    
    
    @IBOutlet weak var customView: UIView!
    
    let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        customView.layer.cornerRadius = 16
        customView.clipsToBounds = true
        
        customView.addSubview(mapView)
        mapView.frame = customView.bounds
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.mapType = .hybrid
        
        mapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeGlobalLocation(_:))))
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func changeGlobalLocation( _ tap : UITapGestureRecognizer) {
        let point = tap.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        guard let tabController = navigationController?.tabBarController as? TabViewController else { return}
        
        tabController.updateLocation(with: location)
        tabController.selectedViewController = tabController.viewControllers?.first
    }
    

}



