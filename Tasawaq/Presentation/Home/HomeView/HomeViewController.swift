//
//  HomeViewController.swift
//  Tasawaq
//
//  Created by Zeinab on 04/12/2023.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: -IBOutlets
    @IBOutlet weak var offerCollectionView: UICollectionView!
    @IBOutlet weak var brandCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView(collectionView: offerCollectionView)
        configureCollectionView(collectionView: brandCollectionView)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    func configureCollectionView(collectionView: UICollectionView){
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "homeCell")
        collectionView.layer.masksToBounds = true
        collectionView.layer.cornerRadius = 20
    }
}
//MARK: UICollectionViewDataSource,Delegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case offerCollectionView:
            return 3
        case brandCollectionView:
            return 10
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCollectionViewCell
        switch collectionView{
        case offerCollectionView:
            cell.configureCell(img: UIImage(named: "adidas") ?? UIImage())
        case brandCollectionView:
            cell.image.layer.cornerRadius = 20
            cell.configureCell(img: UIImage(named: "adidas") ?? UIImage())
        default:
            break
        }
      return cell
    }
}

//MARK: -UICollectionViewDelegateFlowLayout
extension HomeViewController : UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
      
      switch collectionView{
      case offerCollectionView:
          let offerItemWidth = offerCollectionView.layer.frame.size.width - 20
          let offerItemHeight = offerCollectionView.layer.frame.size.height - 20
          return CGSize(width: offerItemWidth, height: offerItemHeight)
      case brandCollectionView:
          let brandItemWidth = brandCollectionView.layer.frame.size.width / 2 - 10
          let brandItemHeight = brandItemWidth * (1)
          return CGSize(width: brandItemWidth, height: brandItemHeight)
      default:
          return CGSize(width: 0, height: 0)
      }
  }
}

