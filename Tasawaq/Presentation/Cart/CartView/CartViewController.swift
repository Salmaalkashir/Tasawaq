//
//  CartViewController.swift
//  Tasawaq
//
//  Created by Salma on 03/12/2023.
//

import UIKit

class CartViewController: UIViewController {
  //MARK: -IBOutlets
  @IBOutlet weak var cartTableView: UITableView!
  @IBOutlet weak var totalPrice: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
    
  }
  func configureTableView(){
    cartTableView.dataSource = self
    cartTableView.delegate = self
    let nib1 = UINib(nibName: "CartTableViewCell", bundle: nil)
    cartTableView.register(nib1, forCellReuseIdentifier: "cartCell")
  }
  
}
//MARK: -IBActions
private extension CartViewController{
  @IBAction func checkout(_ sender: UIButton){
    
  }
}
//MARK: -UITableViewDelegate
extension CartViewController: UITableViewDelegate{
  
}
//MARK: -UITableViewDataSource
extension CartViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
    cell.configureTableCell(image: UIImage(named: "adidas") ?? UIImage(), name: "ADIDAS | CLASSIC BACKPACK ", quantity: "1", price: "USD 70.00")
    cell.increaseQuantity = { [weak cell] in
      cell?.quantityLabel.text = "2"
    }
    cell.decreaseQuantity = { [weak cell] in
      cell?.quantityLabel.text = "0"
    }
    let price = cell.totalPrice.text?.components(separatedBy: " ")
    totalPrice.text = price?[1]
  
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 120
  }
}
