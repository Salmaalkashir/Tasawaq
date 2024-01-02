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
  
   var Selectedd: Bool = false {
    didSet{
      updateSelectionState()
    }
  }
static var lastSelected: ColorSizeCollectionViewCell?
  
  var selectedSize: String?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    updateSelectionState()
  }
  
  private func updateSelectionState() {
    if Selectedd{
      ColorSizeCollectionViewCell.lastSelected?.Selectedd = false
      layer.cornerRadius = 25
      layer.borderWidth = 0.5
      layer.borderColor = UIColor.white.cgColor
      contentView.backgroundColor = UIColor(named: "Custom Color")
      sizeColorLabel.textColor = .white
      selectedSize = sizeColorLabel.text
      ColorSizeCollectionViewCell.lastSelected = self
    } else {
      layer.cornerRadius = 25
      layer.borderWidth = 0.5
      layer.borderColor = UIColor(named: "Custom Color")?.cgColor
      contentView.backgroundColor = UIColor.white
      sizeColorLabel.textColor = UIColor(named: "Custom Color")
      ColorSizeCollectionViewCell.lastSelected = nil
    }
  }
}
/*    lastClick?.backgroundColor = UIColor.white
 lastClick?.layer.borderColor = UIColor(named: "Custom Color")?.cgColor
 lastClick?.layer.borderWidth = 0.8
 lastClick?.configuration?.baseForegroundColor = UIColor(named: "Custom Color")
 
 sender.backgroundColor = UIColor(named: "Custom Color")
 sender.layer.borderWidth = 0.8
 sender.configuration?.baseForegroundColor = .white
 sender.layer.borderColor = UIColor.white.cgColor
 
 lastClick = sender
 
 switch sender{
 case quantity1:
   quantityView.isHidden = true
   finalQuantityLabel.text = sender.titleLabel?.text ?? ""
 case quantity2:
   quantityView.isHidden = true
   finalQuantityLabel.text = sender.titleLabel?.text ?? ""
 case quantity3:
   quantityView.isHidden = true
   finalQuantityLabel.text = sender.titleLabel?.text ?? ""
 case quantity4:
   quantityView.isHidden = true
   finalQuantityLabel.text = sender.titleLabel?.text ?? ""
 default:
   break
 }
*/
