//
//  CustomTabBarViewController.swift
//  Tasawaq
//
//  Created by Salma on 04/12/2023.
//

import UIKit

class CustomTabBarViewController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBar()
    UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
  }
  
  func setupTabBar(){
    let categories = templateNavController(rootViewController: CategoriesViewController(), image: UIImage(systemName: "circle.grid.2x2") ?? UIImage())
    let cart = templateNavController(rootViewController: CartViewController(), image: UIImage(systemName: "cart") ?? UIImage())
   // let wishlist = templateNavController(rootViewController: WishListViewController(), image: UIImage(systemName: "heart") ?? UIImage())
    //let me = templateNavController(rootViewController: UserViewController(), image: UIImage(systemName: "person") ?? UIImage())
    let home = templateNavController(rootViewController: HomeViewController(), image: UIImage(systemName: "house") ?? UIImage())
    viewControllers = [home,categories,cart]
    tabBar.tintColor = UIColor(named: "Custom Color")
    tabBar.barTintColor = .white
    tabBar.isTranslucent = true
  }
  
  func templateNavController(rootViewController: UIViewController, image: UIImage) -> UINavigationController{
    let navController = UINavigationController(rootViewController: rootViewController)
    navController.tabBarItem.image = image
    return navController
  }
}
