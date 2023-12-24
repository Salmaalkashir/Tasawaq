//
//  BrandProductRepository.swift
//  Tasawaq
//
//  Created by Salma on 22/12/2023.
//

import Foundation
protocol BrandProductRepositotyProtocol {
  func getBrandProducts(id: String, completion: @escaping (Result<Products, NetworkError>)-> Void)
}

class BrandProductRepository: BrandProductRepositotyProtocol{
  let networkService: NetworkServiceProtocol = NetworkService()
  func getBrandProducts(id: String , completion: @escaping (Result<Products, NetworkError>)-> Void) {
    networkService.request(path: .brandProducts(id:id), method: .GET, parameters: nil, completion: completion)
  }
  
  
}
