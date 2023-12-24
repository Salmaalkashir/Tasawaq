//
//  BrandProductViewModel.swift
//  Tasawaq
//
//  Created by Salma on 22/12/2023.
//

import Foundation
import UIKit
class BrandProductsViewModel{
    var backbutton = UIBarButtonItem()
    var brandId: String?
    var brandProductsArray: Products?
    var sortedProducts: [Product]?
    var searchArray: [Product]?
    let brandProductsRepository =  BrandProductRepository()
    
    var bindBrandProductsToController: (() -> ()) = {}
    
    var retrievedBrandProducts: Products?{
        didSet{
            bindBrandProductsToController()
        }
    }
    
    func retrieveBrandProduct(){
        brandProductsRepository.getBrandProducts(id: brandId ?? "") { (result: Result<Products, NetworkError>) in
            switch result{
            case .success(let brandProducts):
                self.retrievedBrandProducts = brandProducts
            case .failure(let error):
                print("Error:\(error)")
            }
            
        }
    }
}
