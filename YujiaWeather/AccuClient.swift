//
//  AccuClient.swift
//  YujiaWeather
//
//  Created by MacMini on 26.09.2021.
//

import Foundation
import UIKit
import CoreLocation

let apikey = "pZM6BpFr8o2M4hmpgl117h8ZGzo5Sn6t"

var forecast : DailyModel?
var cityCode : String?

var mappedLocation  : CLLocation?


extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}


struct CurrentTask : Codable {
    
    let request : CurrentRequest
    let response : AccuModel

    
    
    
}

struct CurrentRequest : Codable {
    let apikey : String
    let details : String
   
}


struct DailyTask : Codable {
    let request : CurrentRequest
    let response : DailyModel
}




struct AccuClient {
    
    
    let activityIndicator = UIActivityIndicatorView()
    
    init() {
        if let controller = UIApplication.getTopViewController() {
            activityIndicator.frame = controller.view.bounds
            activityIndicator.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            activityIndicator.hidesWhenStopped = true
            controller.view.addSubview(activityIndicator)
            if #available(iOS 13.0, *) {
                activityIndicator.backgroundColor = .systemGray6
            } else {
                // Fallback on earlier versions
            }
            activityIndicator.color = .black
        }
    }
    
    
    
    func execute(cityID : String,request : CurrentRequest, completion : @escaping (Result<[AccuModel], Error>) -> Void) {
        
        
        
        let params = request.toDict()
        print(params)
        guard let url = URL(string: "http://dataservice.accuweather.com/currentconditions/v1/\(cityID)") else { return}
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        let queryItems = params.map({
            URLQueryItem(name: $0.key, value:  "\($0.value)")
        })
        print(queryItems)
        components?.queryItems = queryItems
        
        guard let finalURL = components?.url else { return}
        print(finalURL)
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
           
         
            if let error = error {
                completion(.failure(error))
                print(error)
                return
            }
            
            
            if let data = data {
               
                do {
                    let accuModel = try JSONDecoder().decode([AccuModel].self, from: data)
                    
                    completion(.success(accuModel))
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                    }
                    
                } catch let error {
                    print(error)
                    print("decoding error")
                    completion(.failure(error))
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                    }
                }
                
                
               
            }
            
        }.resume()
        
    }
    
    func executeDaily(cityID : String,request : CurrentRequest, completion : @escaping (Result<DailyModel, Error>) -> Void) {
        DispatchQueue.main.async {
            activityIndicator.startAnimating()
        }
     
        let params = request.toDict()
        print(params)
        guard let url = URL(string: "http://dataservice.accuweather.com/forecasts/v1/daily/5day/\(cityID)?metrics=true") else { return}
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        let queryItems = params.map({
            URLQueryItem(name: $0.key, value:  "\($0.value)")
        })
        print(queryItems)
        components?.queryItems = queryItems
        
        guard let finalURL = components?.url else { return}
        print(finalURL)
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            
           
            if let error = error {
                completion(.failure(error))
                print(error)
                return
            }
            
            
            if let data = data {
                print(try? JSONSerialization.jsonObject(with: data, options: []))
                do {
                    let accuModel = try JSONDecoder().decode(DailyModel.self, from: data)
                    
                    completion(.success(accuModel))
                } catch let error {
                    print(error)
                    print("decoding error")
                    completion(.failure(error))
                }
                
                
               
            }
            
        }.resume()
        
    }
    
    
    func executeTopCities( completion : @escaping (Result<[City], Error>) -> Void) {
        
       
       
        activityIndicator.startAnimating()
       guard let url = URL(string: "http://dataservice.accuweather.com/currentconditions/v1/topcities/50?apikey=\(apikey)") else { return}
       
    
       
    
       URLSession.shared.dataTask(with: url) { data, response, error in
           DispatchQueue.main.async {
               self.activityIndicator.stopAnimating()
           }
          
           if let error = error {
               completion(.failure(error))
               print(error)
               return
           }
           
           
           if let data = data {
               print(try? JSONSerialization.jsonObject(with: data, options: []))
               do {
                   let accuModel = try JSONDecoder().decode([City].self, from: data)
                   
                   completion(.success(accuModel))
               } catch let error {
                   print(error)
                   print("decoding error")
                   completion(.failure(error))
               }
               
               
              
           }
           
       }.resume()
       
   }
    
    
    func executeForCityID( location : CLLocation,completion : @escaping (Result<CityIDModel, Error>) -> Void) {
        
       
       
        activityIndicator.startAnimating()
        guard let url = URL(string: "http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?q=\(location.coordinate.latitude),\(location.coordinate.longitude)&apikey=\(apikey)") else { return}
       
    
       
    
       URLSession.shared.dataTask(with: url) { data, response, error in
           
          
           if let error = error {
               completion(.failure(error))
               print(error)
               return
           }
           
           
           if let data = data {
               print(try? JSONSerialization.jsonObject(with: data, options: []))
               do {
                   let accuModel = try JSONDecoder().decode(CityIDModel.self, from: data)
                   
                   completion(.success(accuModel))
               } catch let error {
                   print(error)
                   print("decoding error")
                   completion(.failure(error))
                   
                   DispatchQueue.main.async {
                       self.activityIndicator.stopAnimating()
                       let alert = UIAlertController(title: "Unknown Location", message: "Unfortunately we can not provide data for the selected location. Please choose another location", preferredStyle: .alert)
                       let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                       alert.addAction(action)
                       UIApplication.getTopViewController()?.present(alert, animated: true, completion: nil)
                   }
               }
               
               
              
           }
           
       }.resume()
       
   }

    
    
}






extension Encodable {
    
    
    func toDict() -> [String : Any]  {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try JSONEncoder().encode(self)
            
            if let dict = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as? [String : Any] {
                print(dict)
                return dict
            }
            print("sss")
            return [:]
        } catch let error {
            print(error)
            return [:]
        }
        
    }
}
