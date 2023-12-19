//
//  OrderModel.swift
//  Tasawaq
//
//  Created by Salma on 20/12/2023.
//

import Foundation
struct Orders: Codable{
  var orders: [Order]
}
struct Order: Codable{
  var id, order_number: Int?
  var contact_email, current_subtotal_price, current_total_discounts: String?
  var line_items: [LineItems]
}
struct LineItems: Codable{
  var id, quantity : Int?
  var title, price: String?
}
