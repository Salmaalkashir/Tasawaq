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
    
  }
  func configureCell(image: UIImage){
    offerImage.image = image

  }
  
}
