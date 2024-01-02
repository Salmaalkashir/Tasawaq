//
//  CartTableViewCell.swift
//  Tasawaq
//
//  Created by Salma on 03/12/2023.
//

import UIKit
import Kingfisher
class CartTableViewCell: UITableViewCell {
  //MARK: -IBOutlets
  @IBOutlet weak var cellView: UIView!
  @IBOutlet weak var productImage: UIImageView!
  @IBOutlet weak var productName: UILabel!
  @IBOutlet weak var quantityLabel: UILabel!
  @IBOutlet weak var totalPrice: UILabel!
  @IBOutlet weak var productDetails: UILabel!
  
  public var increaseQuantity: (()->())?
  public var decreaseQuantity: (()->())?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureCellView()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  //MARK: -IBActions
  @IBAction func increaseButtonTapped(_ sender: UIButton){
    increaseQuantity?()
  }
  @IBAction func decreseButtonTapped(_ sender: UIButton){
    decreaseQuantity?()
  }
  
  //MARK: -Configurations
  func configureTableCell(image: String, name: String, quantity: String, price: String, details: String){
    productImage.kf.setImage(with: URL(string: image))
    productName.text = name
    quantityLabel.text = quantity
    totalPrice.text = price
    productDetails.text = details
  }
  func configureCellView(){
    cellView.layer.cornerRadius = 20
    cellView.backgroundColor = .white
    cellView.layer.shadowOffset = CGSize(width: 5, height: 5)
    cellView.layer.shadowRadius = 5
    cellView.layer.shadowOpacity = 0.5
  }
}
