//
//  PaymentMethodsViewController.swift
//  Tasawaq
//
//  Created by Salma on 06/12/2023.
//

import UIKit

class PaymentMethodsViewController: UIViewController {
  //MARK: -IBOutlets
  @IBOutlet weak var cashButton: UIButton!
  @IBOutlet weak var paypalButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    cashButton.setImage(UIImage(named: "unchecked"), for: .normal)
    cashButton.setImage(UIImage(named: "checked"), for: .selected)
    paypalButton.setImage(UIImage(named: "unchecked"), for: .normal)
    paypalButton.setImage(UIImage(named: "checked"), for: .selected)
  }
  
}
//MARK: -IBActions
private extension PaymentMethodsViewController{
  @IBAction func selectPaymentMethod(_ sender: UIButton){
    if sender == paypalButton{
      cashButton.isSelected = false
      paypalButton.isSelected = true
    }else{
      cashButton.isSelected = true
      paypalButton.isSelected = false
    }
  }
  
}
