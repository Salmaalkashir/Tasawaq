//
//  HomeViewController.swift
//  Tasawaq
//
//  Created by Zeinab on 04/12/2023.
//

import UIKit

class HomeViewController: UIViewController {
  // MARK: - IBOutlets
  @IBOutlet weak var offerCollectionView: UICollectionView!
  @IBOutlet weak var brandCollectionView: UICollectionView!
  @IBOutlet weak var offerPageControl: UIPageControl!
  
  let homeViewModel = HomeViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    startTimer()
    offerPageControl.numberOfPages = homeViewModel.saleImages.count
    homeViewModel.retrieveOffers()
    
    homeViewModel.retrieveBrands()
    homeViewModel.bindBrandsToHomeController = {
      DispatchQueue.main.async {
        self.homeViewModel.brandsArray = self.homeViewModel.retrievedBrands
        self.homeViewModel.images = self.homeViewModel.saleImages
        self.homeViewModel.offersArray = self.homeViewModel.retrievedOffers
        self.offerCollectionView.reloadData()
        self.brandCollectionView.reloadData()
        if !self.homeViewModel.saleImages.isEmpty {
          self.offerCollectionView.scrollToItem(at: IndexPath(item: self.homeViewModel.currentImageIndex, section: 0), at: .centeredHorizontally, animated: true)}
      }
    }
  }
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: animated)
    homeViewModel.backButton.title = "Home"
    homeViewModel.backButton.tintColor = .black
    navigationItem.backBarButtonItem = homeViewModel.backButton
  }
  
  func configureCollectionView(){
    offerCollectionView.delegate = self
    offerCollectionView.dataSource = self
    let nib = UINib(nibName: "OffersCollectionViewCell", bundle: nil)
    offerCollectionView.register(nib, forCellWithReuseIdentifier: "offersCell")
    offerCollectionView.layer.cornerRadius = 20
    offerCollectionView.clipsToBounds = true
    offerCollectionView.layer.borderWidth = 1.5
    offerCollectionView.layer.borderColor = UIColor(named: "Custom Color")?.cgColor
    
    brandCollectionView.delegate = self
    brandCollectionView.dataSource = self
    let nib1 = UINib(nibName: "BrandsCollectionViewCell", bundle: nil)
    brandCollectionView.register(nib1, forCellWithReuseIdentifier: "brandsCell")
  }
  
  func startTimer(){
    homeViewModel.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(moveToNextImage), userInfo: nil, repeats: true)
  }
  @objc func moveToNextImage(){
    homeViewModel.currentImageIndex = (homeViewModel.currentImageIndex + 1) % homeViewModel.saleImages.count
    offerCollectionView.scrollToItem(at: IndexPath(item: homeViewModel.currentImageIndex, section: 0), at: .centeredHorizontally, animated: true)
    offerPageControl.currentPage = homeViewModel.currentImageIndex
  }
  
  func showToastMessagee(message: String, color: UIColor){
    let toastLabel = UILabel(frame: CGRect(x: self.view.bounds.size.width / 2 - 90, y: self.view.bounds.size.height - 130, width: self.view.bounds.size.width / 2 , height: 30))
    
    toastLabel.textAlignment = .center
    toastLabel.backgroundColor = color
    toastLabel.textColor = .white
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10
    toastLabel.clipsToBounds = true
    toastLabel.text = message
    view.addSubview(toastLabel)
    
    UIView.animate(withDuration: 3.0, delay: 1.0, options: .curveEaseIn, animations: {
      toastLabel.alpha = 0.0
    }) { _ in
      toastLabel.removeFromSuperview()
    }
  }
}
// MARK: - UICollectionViewDataSource,Delegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch collectionView{
    case offerCollectionView:
      return homeViewModel.images?.count ?? 0
    case brandCollectionView:
      return homeViewModel.brandsArray?.smart_collections.count ?? 0
    default:
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch collectionView{
    case offerCollectionView:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offersCell", for: indexPath) as! OffersCollectionViewCell
      cell.configureCell(image: homeViewModel.saleImages[indexPath.row] ?? UIImage())
      return cell
    case brandCollectionView:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandsCell", for: indexPath) as! BrandsCollectionViewCell
      cell.configureCell(img: homeViewModel.brandsArray?.smart_collections[indexPath.row].image.src ?? "")
      return cell
    default:
      return UICollectionViewCell()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch collectionView{
    case offerCollectionView:
      let pasteboard = UIPasteboard.general
      pasteboard.string = homeViewModel.offersArray?.discount_codes[indexPath.row].code
      showToastMessagee(message: "Code Copied", color: .black)
    case brandCollectionView:
      let brandProductObj = BrandProductsViewController()
      brandProductObj.brandID = String(homeViewModel.brandsArray?.smart_collections[indexPath.row].id ?? 0)
      brandProductObj.brandName = homeViewModel.brandsArray?.smart_collections[indexPath.row].title ?? ""
      self.navigationController?.pushViewController(brandProductObj, animated: true)
    default:
      break
    }
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController : UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    
    switch collectionView{
    case offerCollectionView:
      let offerItemWidth = offerCollectionView.layer.frame.size.width
      let offerItemHeight = offerCollectionView.layer.frame.size.height
      return CGSize(width: offerItemWidth, height: offerItemHeight)
    case brandCollectionView:
      let brandItemWidth = brandCollectionView.layer.frame.size.width / 2 - 5
      let brandItemHeight = brandItemWidth * (0.8)
      return CGSize(width: brandItemWidth, height: brandItemHeight)
    default:
      return CGSize(width: 0, height: 0)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    switch collectionView{
    case offerCollectionView:
      return 0
    default:
      return 0
    }
  }
}
