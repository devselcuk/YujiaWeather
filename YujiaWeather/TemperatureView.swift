//
//  TemperatureView.swift
//  YujiaWeather
//
//  Created by MacMini on 26.09.2021.
//

import Foundation
import UIKit


@IBDesignable
class TemperatureView : UIView {
    
    
    let horizontalStackView = UIStackView()
    let verticalStackView = UIStackView()
    let subStackView = UIStackView()
    
    let imageView = UIImageView()
    
    let titleLabel = UILabel()
    let tempLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    
    override  func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
    private func commonInit() {
        horizontalStackView.axis = .horizontal
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.distribution = .fillEqually
        
        
        addSubview(horizontalStackView)
        
        horizontalStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        horizontalStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        horizontalStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "")
   
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(imageView)
        
        
        
        
        verticalStackView.axis = .vertical
       
        let emptyLabel = UILabel()
        verticalStackView.addArrangedSubview(emptyLabel)
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
  
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(tempLabel)
        titleLabel.text = ""
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        if #available(iOS 13.0, *) {
            titleLabel.textColor = .secondaryLabel
        } else {
            // Fallback on earlier versions
        }
        
        tempLabel.font = UIFont.systemFont(ofSize: 100, weight: .semibold)
        tempLabel.text = ""
        tempLabel.textAlignment = .center
        tempLabel.adjustsFontSizeToFitWidth = true
        tempLabel.minimumScaleFactor = 0.2
        
        
        
        
        
        
        
    }
    
    
    
    
    
}
