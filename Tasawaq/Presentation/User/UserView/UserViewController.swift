//
//  UserViewController.swift
//  Tasawaq
//
//  Created by Salma on 05/12/2023.
//

import UIKit

class UserViewController: UIViewController {
  //MARK: -IBOutlets
  @IBOutlet weak var userOrdersTableView: UITableView!
  @IBOutlet weak var userWishListCollectionView: UICollectionView!
  let backbutton = UIBarButtonItem()
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    configureTableView()
    
  }
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: animated)
    backbutton.title = "Profile"
    navigationController?.navigationBar.tintColor = UIColor.black
    navigationItem.backBarButtonItem = backbutton
  }
  
  func configureTableView(){
    userOrdersTableView.dataSource = self
    userOrdersTableView.delegate = self
    let nib = UINib(nibName: "UserOrdersTableViewCell", bundle: nil)
    userOrdersTableView.register(nib, forCellReuseIdentifier: "userOrdersCell")
  }
  
  func configureCollectionView(){
    userWishListCollectionView.dataSource = self
    userWishListCollectionView.delegate = self
    let nib = UINib(nibName: "DetailedProductCollectionViewCell", bundle: nil)
    userWishListCollectionView.register(nib, forCellWithReuseIdentifier: "detailedProductCell")
    userWishListCollectionView.layer.masksToBounds = true
    userWishListCollectionView.layer.cornerRadius = 20
  }
}

//MARK: -IBActions
private extension UserViewController{
  @IBAction func goToSettings(_ sender: UIButton){
    self.navigationController?.pushViewController(SettingsViewController(), animated: true)
  }
  
  @IBAction func seeMoreOrders(_ sender:UIButton){
  }
  
  @IBAction func seeMoreWishList(_ sender: UIButton){
    self.navigationController?.pushViewController(WishListViewController(), animated: true)
  }
}
//MARK: -UITableViewDelegate,UITableViewDataSource
extension UserViewController: UITableViewDelegate,UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "userOrdersCell", for: indexPath) as! UserOrdersTableViewCell
    cell.configureCell(price: "USD 70.00", details: "Dec 5, 2023, 4:30 PM")
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 90
  }
}
//MARK: -UICollectionViewDelegate,UICollectionViewDataSource
extension UserViewController: UICollectionViewDelegate,UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailedProductCell", for: indexPath) as! DetailedProductCollectionViewCell
    cell.configureCell(image: UIImage(named: "adidas") ?? UIImage(), name: "ADIDAS | CLASSIC BACKPACK ", price: "USD 70.00")
    return cell
  }
}
//MARK: -UICollectionViewDelegateFlowLayout
extension UserViewController: UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    let screenWidth = UIScreen.main.bounds.width
    let itemWidth = screenWidth / 2 - 20
    let itemHeight = itemWidth * (1.3)
    
    return CGSize(width:itemWidth , height: itemHeight)
  }
}
