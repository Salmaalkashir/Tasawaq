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
    var currency, total_price, subtotal_price, total_tax: String?
    var line_items: [LineItem]?
   // var applied_discount:
    var customer: [Customer]?
    var default_address: CustomerAddress?
}
struct LineItem: Codable{
    var id, quantity: Int?
    var price: String?
}

struct Customer: Codable{
    var id, orders_count, last_order_id: Int?
    var email, first_name, last_name, phone: String?
}
