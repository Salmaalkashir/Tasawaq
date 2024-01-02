//
//  ProductDetailsViewController.swift
//  Tasawaq
//
//  Created by Salma on 12/12/2023.
//

import UIKit
import Kingfisher

class ProductDetailsViewController: UIViewController {
  // MARK: - IBOutlets
  @IBOutlet weak var productName: UILabel!
  @IBOutlet weak var productPrice: UILabel!
  @IBOutlet weak var productImages: UIImageView!
  @IBOutlet weak var colorCollectionView: UICollectionView!
  @IBOutlet weak var sizeCollectionView: UICollectionView!
  @IBOutlet weak var productSegmentControl: UISegmentedControl!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var productDescription: UILabel!
  @IBOutlet weak var reviewsTableView: UITableView!
  @IBOutlet weak var quantityView: UIView!
  @IBOutlet weak var quantityButtons: UIButton!
  @IBOutlet weak var quantity1: UIButton!
  @IBOutlet weak var quantity2: UIButton!
  @IBOutlet weak var quantity3: UIButton!
  @IBOutlet weak var quantity4: UIButton!
  @IBOutlet weak var finalQuantityLabel: UILabel!
  @IBOutlet weak var quantityLabel: UILabel!
  @IBOutlet weak var quantityInStock: UILabel!
  
  var product: Product?
  var currentImageIndex = 0
  var selectedSize: String = ""
  var selectedColor: String = ""
  var parameters: [String:Any]?
 
  var lastClick: UIButton?
  var isVisible = false
  
  var cartViewModel = CartViewModel()
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    configureTableView()
    configureSegmentControl()
    configureQuantityView()
    configureButtons()
    setupSwipeGestureRecognizers()
    quantityInStock.text = String(product?.variants[0].inventory_quantity ?? 0) + " " + "in Stock"
    containerView.addSubview(reviewsTableView)
    reviewsTableView.isHidden = true
    quantityView.isHidden = true
    updateImageView()
    productName.text = product?.title
    productPrice.text = product?.variants[0].price
    if let imageUrlString = product?.image?.src, let imageUrl = URL(string: imageUrlString) {
      productImages.kf.setImage(with: imageUrl)
    }
    productDescription.text = product?.body_html
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
         quantityLabel.addGestureRecognizer(tapGesture)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.isNavigationBarHidden = false
  }
 
  func configureTableView() {
    reviewsTableView.dataSource = self
    reviewsTableView.delegate = self
    let nib = UINib(nibName: "ReviewsTableViewCell", bundle: nil)
    reviewsTableView.register(nib, forCellReuseIdentifier: "reviewsCell")
  }
  
  func configureCollectionView() {
    sizeCollectionView.dataSource = self
    sizeCollectionView.delegate = self
    colorCollectionView.dataSource = self
    colorCollectionView.delegate = self
    let nib = UINib(nibName: "ColorSizeCollectionViewCell", bundle: nil)
    sizeCollectionView.register(nib, forCellWithReuseIdentifier: "sizeColorCell")
    colorCollectionView.register(nib, forCellWithReuseIdentifier: "sizeColorCell")
  }
  
  func configureSegmentControl() {
    productSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    productSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
  }
  
  func setupSwipeGestureRecognizers() {
    let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
    swipeRightGesture.direction = .right
    productImages.addGestureRecognizer(swipeRightGesture)
    
    let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
    swipeLeftGesture.direction = .left
    productImages.addGestureRecognizer(swipeLeftGesture)
  }
  @objc func handleSwipeRight() {
    currentImageIndex = max(0, currentImageIndex - 1)
    updateImageView()
  }
  
  @objc func handleSwipeLeft() {
    currentImageIndex = min((product?.images.count ?? 0) - 1, currentImageIndex + 1)
    updateImageView()
  }
  
  func updateImageView() {
    if let imageUrlString = product?.images[currentImageIndex], let imageUrl = URL(string: imageUrlString.src ?? ""){
      productImages.kf.setImage(with: imageUrl)
    }
  }
  @objc func labelTapped(){
    quantityView.isHidden = !isVisible
    isVisible = !isVisible
  }
  func configureQuantityView(){
    quantityView.layer.cornerRadius = 15
    quantityView.layer.borderWidth = 0.2
    quantityView.layer.borderColor = UIColor(named: "Custom Color")?.cgColor
  }
  func configureButtons(){
    quantity1.stylingButton()
    quantity2.stylingButton()
    quantity3.stylingButton()
    quantity4.stylingButton()
  }
}
// MARK: - IBAction
private extension ProductDetailsViewController{
  @IBAction func addToFavourite(_ sender: UIButton) {
    sender.isSelected = !sender.isSelected
    if sender.isSelected {
      sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }else{
      sender.setImage(UIImage(systemName: "heart"), for: .normal)
    }
  }
  
  @IBAction func addToCart(_ sender: UIButton) {
    let productObj = CartViewController()
    let lineItem: [String: Any] =  [
        "variant_id": product?.variants[0].id ?? 0,
        "product_id": product?.id ?? 0,
        "title": product?.title ?? "",
        "variant_title":" \(selectedSize) / \(selectedColor)",
        "vendor": product?.vendor ?? "",
        "quantity": Int(finalQuantityLabel.text ?? "") ?? 0,
        "price": product?.variants[0].price ?? 0.0
    ]
    cartViewModel.postCart(productName: product?.title ?? "", email: "yyyyy@ymail.com", currency: "USD", lineItems: lineItem)
    self.navigationController?.pushViewController(productObj, animated: true)
  }
  
  @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
    switch productSegmentControl.selectedSegmentIndex {
    case 0:
      reviewsTableView.isHidden = true
    case 1:
      reviewsTableView.isHidden = false
    default:
      break
    }
  }
  @IBAction func quantityButtonTapped(_ sender: UIButton){
    lastClick?.backgroundColor = UIColor.white
    lastClick?.layer.borderColor = UIColor(named: "Custom Color")?.cgColor
    lastClick?.layer.borderWidth = 0.8
    lastClick?.configuration?.baseForegroundColor = UIColor(named: "Custom Color")
    
    sender.backgroundColor = UIColor(named: "Custom Color")
    sender.layer.borderWidth = 0.8
    sender.configuration?.baseForegroundColor = .white
    sender.layer.borderColor = UIColor.white.cgColor
    
    lastClick = sender
    
    switch sender{
    case quantity1:
      quantityView.isHidden = true
      finalQuantityLabel.text = sender.titleLabel?.text ?? ""
    case quantity2:
      quantityView.isHidden = true
      finalQuantityLabel.text = sender.titleLabel?.text ?? ""
    case quantity3:
      quantityView.isHidden = true
      finalQuantityLabel.text = sender.titleLabel?.text ?? ""
    case quantity4:
      quantityView.isHidden = true
      finalQuantityLabel.text = sender.titleLabel?.text ?? ""
    default:
      break
    }
  }
}

// MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension ProductDetailsViewController: UICollectionViewDelegate,UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch collectionView{
    case colorCollectionView:
      return product?.options[1].values?.count ?? 0
    case sizeCollectionView:
      return product?.options[0].values?.count ?? 0
    default:
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sizeColorCell", for: indexPath) as! ColorSizeCollectionViewCell
    switch collectionView{
    case colorCollectionView:
      cell.sizeColorLabel.text = product?.options[1].values?[indexPath.row]
    case sizeCollectionView:
      cell.sizeColorLabel.text = product?.options[0].values?[indexPath.row]
    default:
      return UICollectionViewCell()
    }
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as? ColorSizeCollectionViewCell
    cell?.Selectedd.toggle()
    switch collectionView{
    case colorCollectionView:
      selectedColor = cell?.selectedSize ?? ""
    case sizeCollectionView:
      selectedSize = cell?.selectedSize ?? ""
    default:
      break
    }
  }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension ProductDetailsViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    return CGSize(width: 50 , height: 50)
  }
}
// MARK: - UITableViewDelegate,UITableViewDataSource
extension ProductDetailsViewController: UITableViewDelegate,UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let clientName = ["Salma", "Fatma", "Ahmad", "Youssef", "Evelyn", "Yehya"]
    return clientName.count 
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reviewsCell", for: indexPath) as! ReviewsTableViewCell
    let clientName = ["Salma", "Fatma", "Ahmad", "Youssef", "Evelyn", "Yehya"]
    let review = ["This product is so good and highly recommended", "I didn't like it", "Not Bad", "High Quality as expected", "", ""]
    let rate = ["5⭐️", "2⭐️", "3⭐️", "4⭐️", "5⭐️", "3⭐️"]
    cell.configureCell(name: clientName[indexPath.row], review: review[indexPath.row], rate: rate[indexPath.row])
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}
