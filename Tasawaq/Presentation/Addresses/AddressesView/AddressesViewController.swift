//
//  AddressesViewController.swift
//  Tasawaq
//
//  Created by Salma on 08/12/2023.
//

import UIKit

class AddressesViewController: UIViewController {
  //MARK: -IBOutlets
  @IBOutlet weak var addressesTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
    
  }
  func configureTableView(){
    addressesTableView.dataSource = self
    addressesTableView.delegate = self
    let nib = UINib(nibName: "AddressesTableViewCell", bundle: nil)
    addressesTableView.register(nib, forCellReuseIdentifier: "addressesCell")
  }
}
//MARK: -IBActions
private extension AddressesViewController{
  @IBAction func addNewAddress(_ sender: UIButton){
    self.navigationController?.pushViewController(LocationViewController(), animated: true)
  }
}
//MARK: -UITableViewDelegate,UITableViewDataSource
extension AddressesViewController: UITableViewDelegate,UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "addressesCell", for: indexPath) as! AddressesTableViewCell
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 100
  }
  
}
