//
//  ProductDetailsViewController.swift
//  Tasawaq
//
//  Created by Salma on 12/12/2023.
//

import UIKit

class ProductDetailsViewController: UIViewController {
  //MARK: -IBOutlets
  @IBOutlet weak var productName: UILabel!
  @IBOutlet weak var productPrice: UILabel!
  @IBOutlet weak var productImages: UIImageView!
  //@IBOutlet weak var colorStackView: UIStackView!
  //@IBOutlet weak var sizeStackView: UIStackView!
  @IBOutlet weak var productSegmentControl: UISegmentedControl!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var productDescription: UILabel!
  @IBOutlet weak var reviewsTableView: UITableView!
  
  let imageNames = ["adidas", "paypal", "cash", "checked"]
  var currentImageIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
    configureSegmentControl()
    setupSwipeGestureRecognizers()
    containerView.addSubview(reviewsTableView)
    reviewsTableView.isHidden = true
    updateImageView()
  }
  
  func configureTableView(){
    reviewsTableView.dataSource = self
    reviewsTableView.delegate = self
    let nib = UINib(nibName: "ReviewsTableViewCell", bundle: nil)
    reviewsTableView.register(nib, forCellReuseIdentifier: "reviewsCell")
  }
  
  func configureSegmentControl(){
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
    currentImageIndex = min(imageNames.count - 1, currentImageIndex + 1)
    updateImageView()
  }
  
  func updateImageView(){
    let images = imageNames[currentImageIndex]
    productImages.image = UIImage(named: images)
  }
}
//MARK: -IBAction
private extension ProductDetailsViewController{
  @IBAction func addToFavourite(_ sender: UIButton){
    
  }
  
  @IBAction func addToCart(_ sender: UIButton){
    
  }
  
  @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl){
    switch productSegmentControl.selectedSegmentIndex {
    case 0:
      reviewsTableView.isHidden = true
    case 1:
      reviewsTableView.isHidden = false
    default:
      break
    }
  }
}
//MARK: -UITableViewDelegate,UITableViewDataSource
extension ProductDetailsViewController: UITableViewDelegate,UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reviewsCell", for: indexPath) as! ReviewsTableViewCell
    cell.configureCell(name: "Salma", review: "This product is so good and highly recommended", rate: "3⭐️")
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}
