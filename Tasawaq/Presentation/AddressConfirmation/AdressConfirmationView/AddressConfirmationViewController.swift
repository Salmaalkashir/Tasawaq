//
//  AddressConfirmationViewController.swift
//  Tasawaq
//
//  Created by Salma on 09/12/2023.
//

import UIKit

class AddressConfirmationViewController: UIViewController {
  //MARK: -IBOutlets
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var firsttName: UITextField!
  @IBOutlet weak var lastName: UITextField!
  @IBOutlet weak var phoneNumber: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    firsttName.stylingTextField()
    lastName.stylingTextField()
    phoneNumber.stylingTextField()
  }
  
}
//MARK: -IBActions
private extension AddressConfirmationViewController{
  @IBAction func editAddress(_ sender: UIButton){
  }
  
  @IBAction func saveAddress(_ sender: UIButton){
  }
}
