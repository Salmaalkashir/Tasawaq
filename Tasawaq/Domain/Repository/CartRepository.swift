//
//  CartRepository.swift
//  Tasawaq
//
//  Created by Salma on 28/12/2023.
//

import Foundation
// MARK: - CartRepositoryProtocol
protocol CartRepositoryProtocol{
    func postDraftOrder(parameters: [String: Any], completion: @escaping (Result<SingleDraftOrder,NetworkError>) -> Void)
}
// MARK: - CartRepository
class CartRepository: CartRepositoryProtocol{
    let networkService: NetworkServiceProtocol = NetworkService()
    func postDraftOrder(parameters: [String: Any], completion: @escaping (Result<SingleDraftOrder,NetworkError>) -> Void) {
        networkService.request(path: .allDraftOrders, method: .POST, parameters: parameters, completion: completion)
    }
}
