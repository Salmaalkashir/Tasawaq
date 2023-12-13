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
  
  let backbutton = UIBarButtonItem()
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
    promocode.stylingTextField()
  }
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.isNavigationBarHidden = false
    backbutton.title = "Order Details"
    navigationController?.navigationBar.tintColor = UIColor.black
    navigationItem.backBarButtonItem = backbutton
  }
  
  func configureTableView(){
    orders.dataSource = self
    orders.delegate = self
    let nib = UINib(nibName: "OrderListTableViewCell", bundle: nil)
    orders.register(nib, forCellReuseIdentifier: "orderListCell")
    
    address.dataSource = self
    address.delegate = self
    let nib1 = UINib(nibName: "ShippingAddressTableViewCell", bundle: nil)
    address.register(nib1, forCellReuseIdentifier: "shippingAddressCell")
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
      let cell = tableView.dequeueReusableCell(withIdentifier: "shippingAddressCell", for: indexPath) as! ShippingAddressTableViewCell
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
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch tableView{
    case address:
      self.navigationController?.pushViewController(AddressesViewController(), animated: true)
    default:
      break
    }
  }
  
}
