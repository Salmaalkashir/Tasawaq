//
//  CategoriesViewController.swift
//  Tasawaq
//
//  Created by Salma on 28/11/2023.
//

import UIKit

class CategoriesViewController: UIViewController {
  //MARK: -IBOutlets
  @IBOutlet weak var segment: UISegmentedControl!
  @IBOutlet weak var subCategory: UISegmentedControl!
  @IBOutlet weak var productsCollectionView: UICollectionView!
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    configureSegmentControl()
  }
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  func configureCollectionView(){
    productsCollectionView.dataSource = self
    productsCollectionView.delegate = self
    let nib1 = UINib(nibName: "DetailedProductCollectionViewCell", bundle: nil)
    productsCollectionView.register(nib1, forCellWithReuseIdentifier: "detailedProductCell")
    productsCollectionView.layer.masksToBounds = true
    productsCollectionView.layer.cornerRadius = 20
  }
  
  func configureSegmentControl(){
    segment.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    segment.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    
    subCategory.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    subCategory.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
  }
}
//MARK: -UICollectionViewDataSource,UICollectionViewDelegate
extension CategoriesViewController: UICollectionViewDataSource,UICollectionViewDelegate{
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
extension CategoriesViewController : UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    let screenWidth = UIScreen.main.bounds.width
    let itemWidth = screenWidth / 2 - 20
    let itemHeight = itemWidth * (1.2)
    
    return CGSize(width:itemWidth , height: itemHeight)
  }
}

