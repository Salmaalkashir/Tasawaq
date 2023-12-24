//
//  CategoriesCollectionViewCell.swift
//  Tasawaq
//
//  Created by Salma on 29/11/2023.
//

import UIKit
import Kingfisher

class DetailedProductCollectionViewCell: UICollectionViewCell {
  //MARK: -IBOutlets
  @IBOutlet weak var cellView: UIView!
  @IBOutlet weak var productImage: UIImageView!
  @IBOutlet weak var productName: UILabel!
  @IBOutlet weak var productPrice: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureCellView()
  }
  //MARK: -Configurations
  func configureCell(image: String, name: String, price: String){
    productName.text = name
    productPrice.text = price
    productImage.kf.setImage(with: URL(string: image))
  }
  
  func configureCellView(){
    cellView.layer.cornerRadius = 20
    cellView.backgroundColor = .white
    cellView.layer.shadowOffset = CGSize(width: 5, height: 5)
    cellView.layer.shadowRadius = 5
    cellView.layer.shadowOpacity = 0.5
  }
}
