//
//  CartViewModel.swift
//  Tasawaq
//
//  Created by Salma on 29/12/2023.
//

import Foundation
class CartViewModel{
    let cartRepository = CartRepository()
    var bindingErorrToController: (()->()) = {}
    
    var retrievedCartError: NetworkError?{
        didSet{
            bindingErorrToController()
        }
    }
 

    func postCart(productName: String, email: String, currency: String, lineItems: [String: Any]){
        let parameters: [String: Any] = [
              "draft_order": [
                  "email": email,
                  "currency": currency,
                  "line_items": [lineItems]
              ] as [String : Any]
          ]
        cartRepository.postDraftOrder(parameters: parameters) { (result: Result<SingleDraftOrder, NetworkError>) in
            switch result{
            case .success(let successPost):
                print("success: \(successPost)")
            case .failure(let error):
                print("Error:\(error)")
            }
        }
    }
}
