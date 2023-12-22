//
//  HomeRepository.swift
//  Tasawaq
//
//  Created by Salma on 22/12/2023.
//

import Foundation
// MARK: - HomeRepositoryProtocol
protocol HomeRepositotyProtocol {
    func getOfferData(parameters: [String: Any]?, completion: @escaping (Result<Coupon, NetworkError>)-> Void)
    func getBrandData(parameters: [String: Any]?, completion: @escaping (Result<SmartCollection, NetworkError>)-> Void)
}

// MARK: - HomeRepository
class HomeRepository: HomeRepositotyProtocol{
    let networkService: NetworkServiceProtocol = NetworkService()
    func getOfferData(parameters: [String: Any]?, completion: @escaping (Result<Coupon, NetworkError>)-> Void) {
        networkService.request(path: .discount, method: .GET, parameters: parameters, completion: completion)
    }
    
    func getBrandData(parameters: [String: Any]?, completion: @escaping (Result<SmartCollection, NetworkError>)-> Void) {
        networkService.request(path: .brand, method: .GET, parameters: parameters, completion: completion)
    }
    
    
}
