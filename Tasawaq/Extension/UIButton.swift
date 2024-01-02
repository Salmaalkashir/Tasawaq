//
//  UIButton.swift
//  Tasawaq
//
//  Created by Salma on 29/12/2023.
//

import UIKit
extension UIButton{
    func stylingButton(){
        layer.cornerRadius = 17.5
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(named: "Custom Color")?.cgColor
    }
}
