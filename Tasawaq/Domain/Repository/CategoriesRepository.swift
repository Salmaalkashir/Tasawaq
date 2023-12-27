//
//  CategoriesRepository.swift
//  Tasawaq
//
//  Created by Salma on 24/12/2023.
//

import Foundation
// MARK: - CategoriesRepositoryProtocol
protocol CategoriesRepositoryProtocol{
    func getProducts(path: Path, completion: @escaping (Result<Products,NetworkError>) -> Void)
}
// MARK: - CategoriesRepository
class CategoriesRepository: CategoriesRepositoryProtocol {
    let networkService: NetworkServiceProtocol = NetworkService()
    func getProducts(path: Path, completion: @escaping (Result<Products,NetworkError>) -> Void){
        networkService.request(path: path, method: .GET, parameters: nil, completion: completion)
    }
}
