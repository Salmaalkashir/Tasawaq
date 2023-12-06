//
//  AddressTableViewCell.swift
//  Tasawaq
//
//  Created by Salma on 05/12/2023.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
  //MARK: -IBOutlets
  @IBOutlet weak var cellView: UIView!
  @IBOutlet weak var counrtyLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var phoneNumber: UILabel!
  
  public var changeLoction: (()->())?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureCellView()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  //MARK: -IBActions
  @IBAction func changeLocation(_ sender: UIButton){
    changeLoction?()
  }
  //MARK: -Configurations
  func configureCell(country: String, city: String, phone: String){
    counrtyLabel.text = country
    cityLabel.text = city
    phoneNumber.text = phone
  }
  func configureCellView(){
    cellView.layer.cornerRadius = 20
    cellView.backgroundColor = .white
    cellView.layer.shadowOffset = CGSize(width: 5, height: 5)
    cellView.layer.shadowRadius = 5
    cellView.layer.shadowOpacity = 0.5
  }
}
