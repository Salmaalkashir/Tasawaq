//
//  HomeViewModel.swift
//  Tasawaq
//
//  Created by Salma on 21/12/2023.
//

import Foundation
import UIKit
class HomeViewModel{
  let backbutton = UIBarButtonItem()
  let saleImages = [UIImage(named: "sale"),UIImage(named: "sale1"), UIImage(named: "sale2")]
  var images: [UIImage?]?
  var timer: Timer?
  var currentImageIndex = 0
  var offersArray: Coupon?
  var brandsArray: SmartCollection?
  
  var homeRepository =  HomeRepository()
  
  // MARK: - Offers
  var bindOffersToHomeController: (() -> ()) = {}
  
  var retrievedOffers: Coupon?{
    didSet{
      bindOffersToHomeController()
    }
  }
  
  func retrieveOffers(){
    homeRepository.getOfferData(parameters: nil) {(result: Result<Coupon, NetworkError>) in
      switch result {
      case .success(let coupon):
        self.retrievedOffers = coupon
      case .failure(let error):
        print("Error: \(error)")
      }
    }
  }
  
  // MARK: - Brands
  var bindBrandsToHomeController: (() -> ()) = {}
  
  var retrievedBrands: SmartCollection?{
    didSet{
      bindBrandsToHomeController()
    }
  }
  
  func retrieveBrands(){
    homeRepository.getBrandData(parameters: nil) { (result: Result<SmartCollection, NetworkError>) in
      switch result {
      case .success(let brand):
        self.retrievedBrands = brand
      case .failure(let error):
        print("ErrorB:\(error)")
      }
    }
  }
}
          
