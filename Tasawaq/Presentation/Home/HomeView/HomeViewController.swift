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
    
    func configureCollectionView(collectionView: UICollectionView){
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "HomeCell", bundle: nil)
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
            break
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoriesCell", for: indexPath) as! HomeCell
      cell.configureCell(image: UIImage(named: "adidas") ?? UIImage())
      return cell
    }
    
}
