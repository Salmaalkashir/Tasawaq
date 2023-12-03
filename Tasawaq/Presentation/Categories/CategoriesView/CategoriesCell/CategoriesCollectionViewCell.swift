//
//  CategoriesCollectionViewCell.swift
//  Tasawaq
//
//  Created by Salma on 29/11/2023.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var cellView: UIView!{
    didSet{
      cellView.layer.cornerRadius = 20
      cellView.backgroundColor = .white
      cellView.layer.shadowOffset = CGSize(width: 5, height: 5)
      cellView.layer.shadowRadius = 5
      cellView.layer.shadowOpacity = 0.5
    }
  }
  @IBOutlet weak var productImage: UIImageView!
  @IBOutlet weak var productName: UILabel!
  @IBOutlet weak var productPrice: UILabel!
  @IBOutlet weak var isFavourite: UIButton!
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  func configureCell(productImagee: UIImage, productNamee: String, productPricee: String){
    productName.text = productNamee
    productPrice.text = productPricee
    productImage.image = productImagee
  }
}
