//
//  AddressesTableViewCell.swift
//  Tasawaq
//
//  Created by Salma on 08/12/2023.
//

import UIKit

class AddressesTableViewCell: UITableViewCell {
  //MARK: -IBOutlets
  @IBOutlet weak var cellView: UIView!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var phoneNumberLabel: UILabel!
  @IBOutlet weak var chosenaddressImage: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureCellView()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  //MARK: -Configurations
  func configureCell(address: String, number: String){
    addressLabel.text = address
    phoneNumberLabel.text = number
  }
  func configureCellView(){
    cellView.layer.cornerRadius = 20
    cellView.backgroundColor = .white
    cellView.layer.shadowOffset = CGSize(width: 5, height: 5)
    cellView.layer.shadowRadius = 5
    cellView.layer.shadowOpacity = 0.5
  }
}
