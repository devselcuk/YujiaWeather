//
//  MyLocsViewController.swift
//  YujiaWeather
//
//  Created by MacMini on 27.09.2021.
//

import UIKit



class MyLocsViewController: UIViewController {
    
    @AppModel var locations : [AppDataModel]

    @IBOutlet weak var tableView: UITableView!
    var derivedLocations : [AppDataModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.derivedLocations = locations
        tableView.reloadData()
    }
    
    

}


extension MyLocsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return derivedLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "loc")!
        
        cell.textLabel?.text = "\(derivedLocations[indexPath.row].name)"
        
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dlOC = derivedLocations[indexPath.row]
        guard let tabController = navigationController?.tabBarController as? TabViewController else { return}
        
        tabController.updateLocation(with: dlOC.location)
        tabController.selectedViewController = tabController.viewControllers?.first
    }
    
    
    
}
