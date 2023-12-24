//
//  HomeCell.swift
//  Tasawaq
//
//  Created by Zeinab on 04/12/2023.
//

import UIKit
import Kingfisher
class BrandsCollectionViewCell: UICollectionViewCell {
    //MARK: -IBOutlets
    @IBOutlet weak var brandImage: UIImageView!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCellView()
    }
    //MARK: -Configurations
    func configureCell(img: String){
        brandImage.kf.setImage(with: URL(string: img))
    }

    func configureCellView(){
      cellView.layer.cornerRadius = 20
      cellView.backgroundColor = .white
      cellView.layer.shadowOffset = CGSize(width: 5, height: 5)
      cellView.layer.shadowRadius = 5
      cellView.layer.shadowOpacity = 0.5
    }
}
