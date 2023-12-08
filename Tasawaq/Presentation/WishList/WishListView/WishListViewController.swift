//
//  WishListViewController.swift
//  Tasawaq
//
//  Created by Salma on 05/12/2023.
//

import UIKit

class WishListViewController: UIViewController {
  //MARK: -IBOutlets
  @IBOutlet weak var wishListCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    
  }
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  func configureCollectionView(){
    wishListCollectionView.dataSource = self
    wishListCollectionView.delegate = self
    let nib1 = UINib(nibName: "DetailedProductCollectionViewCell", bundle: nil)
    wishListCollectionView.register(nib1, forCellWithReuseIdentifier: "detailedProductCell")
    wishListCollectionView.layer.masksToBounds = true
    wishListCollectionView.layer.cornerRadius = 20
  }
}
//MARK: -UICollectionViewDelegate,UICollectionViewDataSource
extension WishListViewController: UICollectionViewDelegate,UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailedProductCell", for: indexPath) as! DetailedProductCollectionViewCell
    cell.configureCell(image: UIImage(named: "adidas") ?? UIImage(), name: "ADIDAS | CLASSIC BACKPACK ", price: "USD 70.00")
    return cell
  }
}
//MARK: -UICollectionViewDelegateFlowLayout
extension WishListViewController : UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    let screenWidth = UIScreen.main.bounds.width
    let itemWidth = screenWidth / 2 - 20
    let itemHeight = itemWidth * (1.3)
    
    return CGSize(width:itemWidth , height: itemHeight)
  }
}
