//
//  OrderListTableViewCell.swift
//  Tasawaq
//
//  Created by Salma on 05/12/2023.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {
  //MARK: -IBOutlets
  @IBOutlet weak var cellView: UIView!
  @IBOutlet weak var productImage: UIImageView!
  @IBOutlet weak var productName: UILabel!
  @IBOutlet weak var productDetails: UILabel!
  @IBOutlet weak var productQuantity: UILabel!
  @IBOutlet weak var productPrice: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureCellView()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  //MARK: -Configurations
  func configureTableCell(image: UIImage, name: String, details: String, quantity: String, price: String){
    productImage.image = image
    productName.text = name
    productQuantity.text = quantity
    productDetails.text = details
    productPrice.text = price
  }
  func configureCellView(){
    cellView.layer.cornerRadius = 20
    cellView.backgroundColor = .white
    cellView.layer.shadowOffset = CGSize(width: 5, height: 5)
    cellView.layer.shadowRadius = 5
    cellView.layer.shadowOpacity = 0.5
  }
  
}
