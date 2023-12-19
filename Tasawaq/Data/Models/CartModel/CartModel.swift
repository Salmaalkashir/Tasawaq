//
//  CartModel.swift
//  Tasawaq
//
//  Created by Salma on 19/12/2023.
//

import Foundation

struct DraftOrders: Codable{
  var draft_orders: [DraftOrder]
}

struct DraftOrder: Codable{
  var id: Int?
  var currency, subtotal_price, email, note: String?
  var line_items: [LineItem]?
  var customer: [Customer]?
  var default_address: CustomerAddress?
}

struct LineItem: Codable{
  var id, product_id, quantity: Int?
  var price, title, vendor: String?
}


