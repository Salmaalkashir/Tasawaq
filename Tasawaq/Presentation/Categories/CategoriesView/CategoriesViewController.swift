//
//  CategoriesViewController.swift
//  Tasawaq
//
//  Created by Salma on 28/11/2023.
//

import UIKit

class CategoriesViewController: UIViewController {
  // MARK: - IBOutlets
  @IBOutlet weak var categoriesSegmentControl: UISegmentedControl!
  @IBOutlet weak var subCategoriesSegmentControl: UISegmentedControl!
  @IBOutlet weak var productsCollectionView: UICollectionView!
  var categoriesViewModel = CategoriesViewModel()
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    configureSegmentControl()
    categoryFilter(path: .allProducts)
    /*    categoriesViewModel.retrieveMenProducts(id: Category.men.rawValue)
   
   categoriesViewModel.retrieveCategoryProducts(id: Category.kids.rawValue)
   categoriesViewModel.retrieveCategoryProducts(id: Category.sale.rawValue)
    categoriesViewModel.bindingMenProductsToCategoriesController = {
      DispatchQueue.main.async{
        self.categoriesViewModel.menProductArray = self.categoriesViewModel.retrievedMenProducts
        self.productsCollectionView.reloadData()
      }
    }
    categoriesViewModel.retrieveWomenProducts(id: Category.women.rawValue)
    categoriesViewModel.bindingWomenProductsToCategoriesController = {
      DispatchQueue.main.async {
        self.categoriesViewModel.womenProductArray = self.categoriesViewModel.retrievedWomenProducts
        self.productsCollectionView.reloadData()
      }
    }*/
  }
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: animated)
    categoriesViewModel.backButton.title = "Categories"
    categoriesViewModel.backButton.tintColor = .black
    navigationItem.backBarButtonItem = categoriesViewModel.backButton
  }
  
  func configureCollectionView() {
    productsCollectionView.dataSource = self
    productsCollectionView.delegate = self
    let nib1 = UINib(nibName: "DetailedProductCollectionViewCell", bundle: nil)
    productsCollectionView.register(nib1, forCellWithReuseIdentifier: "detailedProductCell")
    productsCollectionView.layer.masksToBounds = true
    productsCollectionView.layer.cornerRadius = 20
  }
  
  func configureSegmentControl() {
    categoriesSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    categoriesSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    
    subCategoriesSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    subCategoriesSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
  }
  func categoryFilter(path: Path){
    self.categoriesViewModel.retrieveProducts(path: path)
    self.categoriesViewModel.bindingProductsToCategoriesController = { () in
      DispatchQueue.main.async{
        self.categoriesViewModel.productsArray = self.categoriesViewModel.retrievedProducts
        self.productsCollectionView.reloadData()
      }
    }
  }
}

// MARK: - IBActions
private extension CategoriesViewController{
  @IBAction func segmentControlReload(_ sender: UISegmentedControl){
    switch categoriesSegmentControl.selectedSegmentIndex{
    case 0:
      categoryFilter(path: .allProducts)
    case 1:
      categoryFilter(path: .categoriesProducts(id: Category.men.rawValue))
    case 2:
      categoryFilter(path: .categoriesProducts(id: Category.women.rawValue))
    case 3:
      categoryFilter(path: .categoriesProducts(id: Category.kids.rawValue))
    case 4:
      categoryFilter(path: .categoriesProducts(id: Category.sale.rawValue))
    default:
      break
    }
  }
  @IBAction func subsegmentControlReload(_ sender: UISegmentedControl){
    switch subCategoriesSegmentControl.selectedSegmentIndex{
    case 0:
      if categoriesSegmentControl.selectedSegmentIndex == 0{
        categoryFilter(path: .allProducts)
      }
      if categoriesSegmentControl.selectedSegmentIndex == 1{
        categoryFilter(path: .categoriesProducts(id: Category.men.rawValue))
      }
      if categoriesSegmentControl.selectedSegmentIndex == 2{
        categoryFilter(path: .categoriesProducts(id: Category.women.rawValue))
      }
      if categoriesSegmentControl.selectedSegmentIndex == 3{
        categoryFilter(path: .categoriesProducts(id: Category.sale.rawValue))
      }
      
    case 1:
      if categoriesSegmentControl.selectedSegmentIndex == 0{
        categoryFilter(path: .tshirtsCategory(id: ""))
      }
      if categoriesSegmentControl.selectedSegmentIndex == 1{
        categoryFilter(path: .tshirtsCategory(id: Category.men.rawValue))
      }
      if categoriesSegmentControl.selectedSegmentIndex == 2{
        categoryFilter(path: .tshirtsCategory(id: Category.women.rawValue))
      }
      if categoriesSegmentControl.selectedSegmentIndex == 3{
        categoryFilter(path: .tshirtsCategory(id: Category.kids.rawValue))
      }
      if categoriesSegmentControl.selectedSegmentIndex == 4{
        categoryFilter(path: .tshirtsCategory(id: Category.sale.rawValue))
      }
     
    case 2:
      if categoriesSegmentControl.selectedSegmentIndex == 0{
        categoryFilter(path: .shoesCategory(id: ""))
      }
      if categoriesSegmentControl.selectedSegmentIndex == 1{
        categoryFilter(path: .shoesCategory(id: Category.men.rawValue))
      }
      if categoriesSegmentControl.selectedSegmentIndex == 2{
        categoryFilter(path: .shoesCategory(id: Category.women.rawValue))
      }
      if categoriesSegmentControl.selectedSegmentIndex == 3{
        categoryFilter(path: .shoesCategory(id: Category.kids.rawValue))
      }
      if categoriesSegmentControl.selectedSegmentIndex == 4{
        categoryFilter(path: .shoesCategory(id: Category.sale.rawValue))
      }
    case 3:
      if categoriesSegmentControl.selectedSegmentIndex == 0{
        categoryFilter(path: .accessoriesCategory(id: ""))
      }
      if categoriesSegmentControl.selectedSegmentIndex == 1{
        categoryFilter(path: .accessoriesCategory(id: Category.men.rawValue))
      }
      if categoriesSegmentControl.selectedSegmentIndex == 2{
        categoryFilter(path: .accessoriesCategory(id: Category.women.rawValue))
      }
      if categoriesSegmentControl.selectedSegmentIndex == 3{
        categoryFilter(path: .accessoriesCategory(id: Category.kids.rawValue))
      }
      if categoriesSegmentControl.selectedSegmentIndex == 4{
        categoryFilter(path: .accessoriesCategory(id: Category.sale.rawValue))
      }
    default:
      break
    }
  }
}
// MARK: - UICollectionViewDataSource,UICollectionViewDelegate
extension CategoriesViewController: UICollectionViewDataSource,UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return categoriesViewModel.productsArray?.products?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailedProductCell", for: indexPath) as! DetailedProductCollectionViewCell
    cell.configureCell(image: categoriesViewModel.productsArray?.products?[indexPath.row].image?.src ?? "", name: categoriesViewModel.productsArray?.products?[indexPath.row].title ?? "", price: categoriesViewModel.productsArray?.products?[indexPath.row].variants[0].price ?? "" )
    cell.isFavourite = { [weak cell] in
      cell?.favourite.isSelected = !(cell?.favourite.isSelected ?? false)
      if cell?.favourite.isSelected ?? false {
        cell?.favourite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
      }else{
        cell?.favourite.setImage(UIImage(systemName: "heart"), for: .normal)
      }
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.navigationController?.pushViewController(ProductDetailsViewController(), animated: true)
  }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension CategoriesViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    let screenWidth = UIScreen.main.bounds.width
    let itemWidth = screenWidth / 2 - 20
    let itemHeight = itemWidth * (1.2)
    
    return CGSize(width:itemWidth , height: itemHeight)
  }
}

