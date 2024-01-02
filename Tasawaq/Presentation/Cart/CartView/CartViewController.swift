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
  var backbutton = UIBarButtonItem()
  var imageproduct: String?
  var productname: String?
  var productPrice: String?
  var productdetails: String?
  var productQuantit: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: animated)
    backbutton.title = "Cart"
    navigationItem.backBarButtonItem = backbutton
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
    self.navigationController?.pushViewController(OrderDetailsViewController(), animated: true)
  }
}
//MARK: -UITableViewDataSource,UITableViewDelegate
extension CartViewController: UITableViewDataSource,UITableViewDelegate{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
    cell.configureTableCell(image: imageproduct ?? "" , name: productname ?? "", quantity: productQuantit ?? "", price: productPrice ?? "", details: "Details: \(productdetails ?? "")")
    cell.increaseQuantity = { [weak cell] in
      cell?.quantityLabel.text = "2"
    }
    cell.decreaseQuantity = { [weak cell] in
      cell?.quantityLabel.text = "0"
    }
    /*let price = cell.totalPrice.text?.components(separatedBy: " ")
    totalPrice.text = price?[1]*/
  
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 130
  }
}
