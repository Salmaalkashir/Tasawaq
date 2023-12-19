//
//  HomeModel.swift
//  Tasawaq
//
//  Created by Salma on 18/12/2023.
//

import Foundation
//MARK: -Offers
struct Coupon: Codable{
  var discount_codes: [Discounts]
}

struct Discounts: Codable{
  var id, price_rule_id, usage_count: Int?
  var code: String?
}

//MARK: -Brands
struct SmartCollection: Codable{
  var smart_collections: [Brands]
}

struct Brands: Codable{
  var id: Int?
  var image: BrandImage
}

struct BrandImage: Codable{
  var src: String?
}
