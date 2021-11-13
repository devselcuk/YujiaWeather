//
//  EpochFormatter.swift
//  YujiaWeather
//
//  Created by MacMini on 26.09.2021.
//

import Foundation


extension Int {
    
    func date() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM"
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        
        
        return dateFormatter.string(from: date)
        
        
    }
    
    func hour() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        
        
        return dateFormatter.string(from: date)
    }
    
    
    
}
