//
//  CaategoriesModel.swift
//  Tasawaq
//
//  Created by Salma on 18/12/2023.
//

import Foundation

struct Products: Codable{
  var products: [Product]?
}

struct SelectedProduct: Codable{
  var product: Product
}

struct Product: Codable{
  var id: Int?
  var title, body_html, vendor, product_type: String?
  var variants: [Variants]
  var options: [Options]
  var images: [ProductImages]
  var image: ProductImage?
}

struct Variants: Codable{
  var inventory_quantity: Int?
  var title, price: String?
}

struct Options: Codable{
  var name: String?
  var values: [String]?
}

struct ProductImages: Codable{
  var src: String?
}

struct ProductImage: Codable{
  var src: String?
}

enum Category: String{
  case all = "436748681494"
  case men = "436751270166"
  case women = "436751335702"
  case kids = "436751368470"
  case sale = "436751401238"
}
