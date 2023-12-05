//
//  UserOrdersTableViewCell.swift
//  Tasawaq
//
//  Created by Salma on 05/12/2023.
//

import UIKit

class UserOrdersTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var orderPrice: UILabel!
    @IBOutlet weak var orderDetails: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCellView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    //MARK: -Configurations
    func configureCell(price: String, details: String){
        orderPrice.text = price
        orderDetails.text = details
    }
    func configureCellView(){
      cellView.layer.cornerRadius = 20
      cellView.backgroundColor = .white
      cellView.layer.shadowOffset = CGSize(width: 5, height: 5)
      cellView.layer.shadowRadius = 5
      cellView.layer.shadowOpacity = 0.5
    }
}
