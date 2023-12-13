//
//  SettingsViewController.swift
//  Tasawaq
//
//  Created by Salma on 13/12/2023.
//

import UIKit

class SettingsViewController: UIViewController {
  //MARK: -IBOutlets
  @IBOutlet weak var currencySegmentControl: UISegmentedControl!
  let backbutton = UIBarButtonItem()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureSegmentControl()
  }
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.isNavigationBarHidden = false
  }
  
  func configureSegmentControl(){
    currencySegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    currencySegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
  }
}
//MARK: -IBActions
private extension SettingsViewController{
  @IBAction func goToAddresses(_ sender: UIButton){
    self.navigationController?.pushViewController(AddressesViewController(), animated: true)
  }
  
  @IBAction func logout(_ sender: UIButton){
    
  }
}
