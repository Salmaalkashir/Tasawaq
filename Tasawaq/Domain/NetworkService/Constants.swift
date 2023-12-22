//
//  Constants.swift
//  Tasawaq
//
//  Created by Salma on 21/12/2023.
//

import Foundation
// MARK: - HTTPMethods
enum HTTPMethod: String{
  case GET
  case POST
  case PUT
  case DELETE
}
// MARK: - Handling Error
enum NetworkError: Error{
  case invalidURL
  case requestFailed(Error)
  case invalidResponse
  case decodingFailed(Error)
}
// MARK: - EndPoints
enum Path {
  case allProducts
  case categoriesProducts(id: String)
  case shoesCategory(id: String)
  case accessoriesCategory(id: String)
  case tshirtsCategory(id: String)
  case brandProducts(id: String)
  case allCustomers
  case searchCustomerByID(id: String)
  case searchCustomerByEmail(email: String)
  case searchCustomerByAddress(id: Int)
  case deleteProductByID(id: Int)
  case orders
  case customerOrder(id: Int)
  case brand
  case allDraftOrders
  case draftOrder(id: Int)
  case discount
  case checkUser(email: String, tag: String)
  case addAddress(id: Int)
  case editAddress(customerID: Int, addressID: Int)
  case deleteAddress(customerID: Int, addressID: Int)
  
  var stringValue: String {
    switch self{
      
    case .allProducts:
      return "/products.json"
    case let .categoriesProducts(id: id):
      return "/products.json?collection_id=\(id)"
    case let .shoesCategory(id: id):
      return "/products.json?collection_id=\(id)&product_type=SHOES"
    case let .accessoriesCategory(id: id):
      return "/products.json?collection_id=\(id)&product_type=ACCESSORIES"
    case let .tshirtsCategory(id: id):
      return "/products.json?collection_id=\(id)&product_type=T-SHIRTS"
    case let .brandProducts(id: id):
      return "/products.json?collection_id=\(id)"
    case .allCustomers:
      return "/customers.json"
    case let .searchCustomerByID(id: id):
      return "/customers/search.json?query=id:\(id)"
    case let .searchCustomerByEmail(email: email):
      return "/customers/search.json?query=email:\(email)"
    case let .searchCustomerByAddress(id: id):
      return "/customers/\(id)/addresses.json"
    case let .deleteProductByID(id: id):
      return "/products/\(id).json"
    case .orders:
      return "/orders.json"
    case let .customerOrder(id: id):
      return "/customers/\(id)/orders.json"
    case .brand:
      return "/smart_collections.json"
    case .allDraftOrders:
      return "/draft_orders.json"
    case let .draftOrder(id: id):
      return "/draft_orders/\(id).json"
    case .discount:
      return "/price_rules/1380100899094/discount_codes.json"
    case let .checkUser(email: email, tag: tag):
      return "/customers/search.json?query=email:\(email)&tag:\(tag)"
    case let .addAddress(id: id):
      return "/customers/\(id)/addresses.json"
    case let .editAddress(customerID: customerID, addressID: addressID):
      return "/customers/\(customerID)/addresses/\(addressID).json"
    case let .deleteAddress(customerID: customerID, addressID: addressID):
      return "/customers/\(customerID)/addresses/\(addressID).json"
    }
  }
}

