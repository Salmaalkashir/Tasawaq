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
  var prices = ["70.00", "150.00", "100.00", "50.00"]
  var names = ["adidas", "nike", "pull&bear", "sketchers"]
  var filterNames: [String]?
  var pricesDouble: [Double]?
  var highSort:[Double]?
  var lowSort: [Double]?

  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    configureSegmentControl()
    pricesDouble = prices.map{Double($0) ?? 0}
    filterNames = names
    searchBrandProduct.delegate = self
  }
  
  func configureCollectionView(){
    brandProductsCollectionView.dataSource = self
    brandProductsCollectionView.delegate = self
    let nib1 = UINib(nibName: "DetailedProductCollectionViewCell", bundle: nil)
    brandProductsCollectionView.register(nib1, forCellWithReuseIdentifier: "detailedProductCell")
    brandProductsCollectionView.layer.masksToBounds = true
    brandProductsCollectionView.layer.cornerRadius = 20
  }
  
  func configureSegmentControl(){
    priceSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    priceSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
  }
  
  func sortAscendingly(){
    pricesDouble?.sort(by: <)
    print("low\(pricesDouble ?? [])")
    highSort = pricesDouble
  }
  
  func sortDescendingly(){
    pricesDouble?.sort(by: >)
    print("high\(pricesDouble ?? [])")
    lowSort = pricesDouble
  }
}

//MARK: -IBActions
private extension BrandProductsViewController{
  @IBAction func segmentControlReload(_ sender: UISegmentedControl){
    brandProductsCollectionView.reloadData()
  }
}

//MARK: -UICollectionViewDelegate, UICollectionViewDataSource
extension BrandProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return filterNames?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailedProductCell", for: indexPath) as! DetailedProductCollectionViewCell
    switch priceSegmentControl.selectedSegmentIndex{
    case 0:
      sortDescendingly()
      cell.configureCell(image: UIImage(named: "adidas") ?? UIImage(), name: filterNames?[indexPath.row] ?? "", price: "\(lowSort?[indexPath.row] ?? 0.0)")
    case 1:
      sortAscendingly()
      cell.configureCell(image: UIImage(named: "adidas") ?? UIImage(), name: filterNames?[indexPath.row] ?? "", price: "\(highSort?[indexPath.row] ?? 0.0)")
    default:
      break
    }
    return cell
  }
}

//MARK: -UICollectionViewDelegateFlowLayout
extension BrandProductsViewController : UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    let screenWidth = UIScreen.main.bounds.width
    let itemWidth = screenWidth / 2 - 20
    let itemHeight = itemWidth * (1.2)
    
    return CGSize(width:itemWidth , height: itemHeight)
  }
}

//MARK: -UISearchBarDelegate
extension BrandProductsViewController: UISearchBarDelegate{
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      if searchText.isEmpty {
          filterNames = names
      } else {
          filterNames = names.filter { $0.uppercased().contains(searchText.uppercased()) }
      }
      brandProductsCollectionView.reloadData()
  }
}
