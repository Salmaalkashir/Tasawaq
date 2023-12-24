//
//  BrandProductsViewController.swift
//  Tasawaq
//
//  Created by Salma on 11/12/2023.
//

import UIKit

class BrandProductsViewController: UIViewController {
  //MARK: -IBOutlets
  @IBOutlet weak var searchBrandProduct: UISearchBar!
  @IBOutlet weak var brandProductsCollectionView: UICollectionView!
  @IBOutlet weak var priceSegmentControl: UISegmentedControl!
  var brandID: String?
  var brandProductsViewModel = BrandProductsViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    configureSegmentControl()
    
    searchBrandProduct.delegate = self
    brandProductsViewModel.brandId = brandID
    brandProductsViewModel.retrieveBrandProduct()
    brandProductsViewModel.bindBrandProductsToController = {
      DispatchQueue.main.async {
        self.brandProductsViewModel.brandProductsArray = self.brandProductsViewModel.retrievedBrandProducts
        self.brandProductsViewModel.searchArray = self.brandProductsViewModel.brandProductsArray?.products
        self.brandProductsViewModel.sortedProducts = self.brandProductsViewModel.brandProductsArray?.products
        self.brandProductsCollectionView.reloadData()
      }
    }
   
  }
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.isNavigationBarHidden = false
    brandProductsViewModel.backbutton.title = " "
    navigationController?.navigationBar.tintColor = UIColor.black
    navigationItem.backBarButtonItem =  brandProductsViewModel.backbutton
  }
  func configureCollectionView() {
    brandProductsCollectionView.dataSource = self
    brandProductsCollectionView.delegate = self
    let nib1 = UINib(nibName: "DetailedProductCollectionViewCell", bundle: nil)
    brandProductsCollectionView.register(nib1, forCellWithReuseIdentifier: "detailedProductCell")
    brandProductsCollectionView.layer.masksToBounds = true
    brandProductsCollectionView.layer.cornerRadius = 20
  }
  
  
  func configureSegmentControl() {
    priceSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    priceSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
  }
  
  func sortLowToHigh() {
    brandProductsViewModel.searchArray?.sort{
      guard let firstProduct = Double($0.variants[0].price ?? ""),
            let secondProduct = Double($1.variants[0].price ?? "")else{
        return false
      }
      return firstProduct < secondProduct
    }
    
  }
  
  func sortHighToLow() {
    brandProductsViewModel.searchArray?.sort{
      guard let firstProduct = Double($0.variants[0].price ?? ""),
            let secondProduct = Double($1.variants[0].price ?? "")else{
        return false
      }
      return firstProduct > secondProduct
    }
  }
}

// MARK: - IBActions
private extension BrandProductsViewController {
  @IBAction func segmentControlReload(_ sender: UISegmentedControl){
    brandProductsCollectionView.reloadData()
  }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension BrandProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return  brandProductsViewModel.searchArray?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailedProductCell", for: indexPath) as! DetailedProductCollectionViewCell
   
    switch priceSegmentControl.selectedSegmentIndex{
    case 0:
      sortHighToLow()
      cell.configureCell(image: brandProductsViewModel.searchArray?[indexPath.row].image.src ?? "" , name:  brandProductsViewModel.searchArray?[indexPath.row].title  ?? "" , price:  brandProductsViewModel.searchArray?[indexPath.row].variants[0].price ?? "")
    case 1:
      sortLowToHigh()
      cell.configureCell(image: brandProductsViewModel.searchArray?[indexPath.row].image.src ?? "" , name: brandProductsViewModel.searchArray?[indexPath.row].title  ?? "" , price: brandProductsViewModel.searchArray?[indexPath.row].variants[0].price ?? "")
    default:
      break
    }
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.navigationController?.pushViewController(ProductDetailsViewController(), animated: true)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BrandProductsViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    let screenWidth = UIScreen.main.bounds.width
    let itemWidth = screenWidth / 2 - 20
    let itemHeight = itemWidth * (1.2)
    
    return CGSize(width:itemWidth , height: itemHeight)
  }
}

// MARK: - UISearchBarDelegate
extension BrandProductsViewController: UISearchBarDelegate{
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    brandProductsViewModel.searchArray = []
    
    if searchText.isEmpty {
      brandProductsViewModel.searchArray = brandProductsViewModel.brandProductsArray?.products
    }
    for productName in brandProductsViewModel.brandProductsArray?.products ?? [] {
      let name = productName.title ?? ""
      if (name.uppercased().contains(searchText.uppercased())){
        brandProductsViewModel.searchArray?.append(productName)
      }
    }
    brandProductsCollectionView.reloadData()
  }
}
