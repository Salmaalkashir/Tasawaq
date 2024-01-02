//
//  CategoriesViewModel.swift
//  Tasawaq
//
//  Created by Salma on 24/12/2023.
//

import Foundation
import UIKit
class CategoriesViewModel{
    let backButton = UIBarButtonItem()
    let categoriesRepository = CategoriesRepository()
    
    var productsArray: Products?
  
    var bindingProductsToCategoriesController: (()->()) = {}
    
    var retrievedProducts: Products?{
        didSet{
            bindingProductsToCategoriesController()
        }
    }
    
    func retrieveProducts(path: Path){
        categoriesRepository.getProducts(path: path) { (result: Result<Products, NetworkError>) in
            switch result{
            case .success(let categoryProduct):
                self.retrievedProducts = categoryProduct
            case .failure(let error):
                print("Error:\(error)")
            }
        }
    }

}
