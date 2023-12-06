//
//  OrderDetailsViewController.swift
//  Tasawaq
//
//  Created by Salma on 05/12/2023.
//

import UIKit

class OrderDetailsViewController: UIViewController {
  //MARK: -IBOutlets
  @IBOutlet weak var orders: UITableView!
  @IBOutlet weak var address: UITableView!
  @IBOutlet weak var promocodeView: UIView!
  @IBOutlet weak var promocode: UITextField!
  @IBOutlet weak var cost: UILabel!
  @IBOutlet weak var discount: UILabel!
  @IBOutlet weak var totalCost: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
    promocode.stylingTextField()
  }
  
  func configureTableView(){
    orders.dataSource = self
    orders.delegate = self
    let nib = UINib(nibName: "OrderListTableViewCell", bundle: nil)
    orders.register(nib, forCellReuseIdentifier: "orderListCell")
    
    address.dataSource = self
    address.delegate = self
    let nib1 = UINib(nibName: "AddressTableViewCell", bundle: nil)
    address.register(nib1, forCellReuseIdentifier: "addressCell")
  }
}
//MARK: -IBActions
private extension OrderDetailsViewController{
  @IBAction func applyPromocode(_ sender:UIButton){
  }

  @IBAction func continuePayment(_ sender: UIButton){
    let paymentobj = PaymentMethodsViewController()
    if let sheet = paymentobj.sheetPresentationController{
      sheet.detents = [.medium()]
      sheet.preferredCornerRadius = 25
      sheet.prefersScrollingExpandsWhenScrolledToEdge = false
    }
   // paymentobj.modalPresentationStyle = .pageSheet
    self.present(paymentobj, animated: true)
  }
}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension OrderDetailsViewController: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch tableView{
    case orders:
      return 5
    case address:
      return 1
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch tableView{
    case orders:
      let cell = tableView.dequeueReusableCell(withIdentifier: "orderListCell", for: indexPath) as! OrderListTableViewCell
      cell.configureTableCell(image: UIImage(named: "adidas") ?? UIImage(), name: "ADIDAS | CLASSIC BACKPACK ", details: "Details: 2/White", quantity: "Quantity: 1", price: "USD 70.00")
      return cell
    case address:
      let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressTableViewCell
      cell.configureCell(country: "Alexandria, Egypt", city: "Ebn Shoaba St", phone: "01098885040")
      return cell
    default:
      return UITableViewCell()
    }
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch tableView{
    case orders:
      return 115
    case address:
      return 80
    default:
      return 120
    }
  }
  
}
