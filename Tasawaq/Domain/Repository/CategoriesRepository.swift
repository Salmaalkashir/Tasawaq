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
    func getMenProducts(id: String, completion: @escaping (Result<Products,NetworkError>)-> Void)
    func getWomenProducts(id: String, completion: @escaping (Result<Products,NetworkError>)-> Void)
    func getKidsProducts()
    func getSaleProducts()
}
// MARK: - CategoriesRepository
class CategoriesRepository: CategoriesRepositoryProtocol {
    let networkService: NetworkServiceProtocol = NetworkService()
    func getProducts(path: Path, completion: @escaping (Result<Products,NetworkError>) -> Void){
        networkService.request(path: path, method: .GET, parameters: nil, completion: completion)
    }
    
    func getMenProducts(id: String, completion: @escaping (Result<Products,NetworkError>)-> Void) {
        networkService.request(path: .categoriesProducts(id: id), method: .GET, parameters: nil, completion: completion)
    }
    
    func getWomenProducts(id: String, completion: @escaping (Result<Products,NetworkError>)-> Void) {
        networkService.request(path: .categoriesProducts(id: id), method: .GET, parameters: nil, completion: completion)
    }
    
    func getKidsProducts() {
        //
    }
    
    func getSaleProducts() {
        //
    }
    
    
}
