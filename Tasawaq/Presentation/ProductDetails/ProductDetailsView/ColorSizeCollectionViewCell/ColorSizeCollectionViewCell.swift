//
//  ColorSizeCollectionViewCell.swift
//  Tasawaq
//
//  Created by Salma on 27/12/2023.
//

import UIKit

class ColorSizeCollectionViewCell: UICollectionViewCell {
  // MARK: - IBOutlets
  @IBOutlet weak var sizeColorLabel: UILabel!
  
  override var isSelected: Bool{
    didSet{
      updateSelectionState()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    updateSelectionState()
  }
  
  private func updateSelectionState() {
    if isSelected {
      layer.cornerRadius = 25
      layer.borderWidth = 0.5
      layer.borderColor = UIColor.white.cgColor
      contentView.backgroundColor = UIColor(named: "Custom Color")
     sizeColorLabel.textColor = .white
      print("tit:\(sizeColorLabel.text)")
    } else {
      layer.cornerRadius = 25
      layer.borderWidth = 0.5
      layer.borderColor = UIColor(named: "Custom Color")?.cgColor
      contentView.backgroundColor = UIColor.white
      sizeColorLabel.textColor = UIColor(named: "Custom Color")
    }
  }
}
