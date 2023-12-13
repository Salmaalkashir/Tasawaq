//
//  OffersCollectionViewCell.swift
//  Tasawaq
//
//  Created by Salma on 13/12/2023.
//

import UIKit

class OffersCollectionViewCell: UICollectionViewCell {
  //MARK: -IBOutlets
  @IBOutlet weak var offerImage: UIImageView!
  override func awakeFromNib() {
    super.awakeFromNib()
    configureCell()
  }
  func configureCell(){
    offerImage.layer.cornerRadius = 20
  }
  
}
