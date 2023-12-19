//
//  CustomerModel.swift
//  Tasawaq
//
//  Created by Salma on 20/12/2023.
//

import Foundation

struct Customer: Codable{
  var id, orders_count, last_order_id: Int?
  var email, first_name, last_name, phone, tags, currency: String?
}
