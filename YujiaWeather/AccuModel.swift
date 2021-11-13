//
//  AccuModel.swift
//  YujiaWeather
//
//  Created by MacMini on 26.09.2021.
//

import Foundation
import CoreLocation
import UIKit




struct AccuModel : Codable {
    
    
    let EpochTime : Int
    let WeatherText : String
    let WeatherIcon : Int
    let Temperature : Temperature
    let RelativeHumidity : Int
    let Wind : Wind
    let UVIndex : Int
    let UVIndexText : String
    let Visibility : Temperature
    let CloudCover : Int
    let Pressure : Temperature
    
}



struct Temperature : Codable {
    
    let Metric : UnitItem
}


struct UnitItem : Codable {
    let Value : Double
    let Unit : String
    let UnitType : Int
}



struct Wind : Codable {
    let Direction : Direction
    let Speed : Speed
}


struct Direction : Codable {
    let Degrees : Int
    let Localized : String

}
struct Speed : Codable {
    let Metric : UnitItem
}



struct DailyModel : Codable {
    let DailyForecasts : [Daily]
}





struct Daily : Codable {
    
    
    
    
    let EpochDate : Int
    let Sun : Sun
    let Temperature : DayTemperature
    let AirAndPollen : [AqiPollen]
    let Day : Day
}


struct Sun : Codable {
    let EpochRise : Int
    let EpochSet : Int
}

struct DayTemperature : Codable {
    let Maximum : DayTempUnit
    let Minimum : DayTempUnit
    
}

struct DayTempUnit : Codable {
    let Value : Int
    let Unit : String
    let UnitType : Int
    
    
    func convertFormFtoC() -> String {
        let measurement = Measurement(value: Double(Value), unit: UnitTemperature.fahrenheit)
        
        let converted = measurement.converted(to: .celsius)
        
        return "\(Int(converted.value))\(converted.unit.symbol)"
    }
}


struct AqiPollen : Codable {
    
    let Name : String
    let Category : String
}



struct Day : Codable {
    let Icon : Int
    let ShortPhrase : String
    let ThunderstormProbability : Int
    let RainProbability : Int
    let SnowProbability : Int
}




struct City : Codable {
    let EnglishName : String
    let WeatherText  :String
    let WeatherIcon : Int
    let EpochTime : Int
    let Temperature : Temperature
}



struct CityIDModel : Codable {
    let Key : String
    let EnglishName : String
    let Country : Country
}


struct Country : Codable {
    let LocalizedName : String
}



struct AppDataModel :  Codable {
    
    let name : String
    let coordLat : Double
    let coordLong : Double
    
    
    
    var location : CLLocation {
        CLLocation(latitude: coordLat, longitude: coordLong)
    }
}

let archiveURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("appmODE").appendingPathExtension("plist")


let decoder = PropertyListDecoder()
let encoder = PropertyListEncoder()




@propertyWrapper struct AppModel {

    
    var wrappedValue : [AppDataModel] {
        
        
        get {
            if let data = try? Data(contentsOf: archiveURL) {
                return try! decoder.decode([AppDataModel].self, from: data)
            }
            return []
        }
        
        set {
            let encoded = try! encoder.encode(newValue)
            try! encoded.write(to: archiveURL)
            
            let alert = UIAlertController(title: "Successful", message: "Location was saved successfully to your favourite locations", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            UIApplication.getTopViewController()?.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
}
