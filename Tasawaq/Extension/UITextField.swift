//
//  UITextField.swift
//  Tasawaq
//
//  Created by Salma on 27/11/2023.
//

import UIKit
extension UITextField{
  func setLeftView(image: UIImage){
    
    let icon = UIImageView(frame: CGRect(x: 10, y: 10, width: 25, height: 25))
    icon.image = image
    let iconContainerView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
    iconContainerView.addSubview(icon)
    leftView = iconContainerView
    leftViewMode = .always
    self.tintColor = UIColor(named: "Custom Color")
  }
  
  func stylingTextField()
  {
    layer.cornerRadius = 15
    layer.borderWidth = 1.5
    layer.borderColor = UIColor.lightGray.cgColor
    borderStyle =  .roundedRect
  }
}
