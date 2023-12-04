//
//  HomeCell.swift
//  Tasawaq
//
//  Created by Zeinab on 04/12/2023.
//

import UIKit

class HomeCell: UICollectionViewCell {
    //MARK: -IBOutlets
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //MARK: -Configurations
    func configureCell(img: UIImage){
      image.image = img
    }

}
