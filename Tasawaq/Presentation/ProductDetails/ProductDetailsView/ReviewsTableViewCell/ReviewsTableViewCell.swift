//
//  ReviewsTableViewCell.swift
//  Tasawaq
//
//  Created by Salma on 12/12/2023.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {
  //MARK: -IBOutlets
  @IBOutlet weak var clientName: UILabel!
  @IBOutlet weak var clientReview: UILabel!
  @IBOutlet weak var clientRate: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  func configureCell(name: String, review: String, rate: String){
    clientName.text = name
    clientReview.text = review
    clientRate.text = rate
  }
  
}
