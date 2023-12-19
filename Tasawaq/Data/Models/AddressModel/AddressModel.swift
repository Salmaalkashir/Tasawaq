//
//  AddressModel.swift
//  Tasawaq
//
//  Created by Salma on 19/12/2023.
//

import Foundation
struct CustomerAddress: Codable{
  var id: Int?
  var address1, address2, city: String?
  var `default`: Bool?
}
