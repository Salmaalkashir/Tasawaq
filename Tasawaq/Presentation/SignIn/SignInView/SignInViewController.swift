//
//  SignInViewController.swift
//  Tasawaq
//
//  Created by Salma on 27/11/2023.
//

import UIKit

class SignInViewController: UIViewController {
  
  //MARK: -IBOutlets
  @IBOutlet weak var userName: UITextField!
  @IBOutlet weak var password: UITextField!
  @IBOutlet weak var stackView: UIStackView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTextField()
  }
  //MARK: -IBActions
  @IBAction func signIn(_ sender: Any) {
  }
  @IBAction func signUp(_ sender: Any) {
  }
}


//MARK: -UITextFieldDelegate
extension SignInViewController: UITextFieldDelegate{
  func configureTextField(){
    userName.delegate = self
    userName.setLeftView(image: UIImage(systemName: "person")!)
    userName.stylingTextField()
    
    password.delegate = self
    password.setLeftView(image: UIImage(systemName: "lock")!)
    password.stylingTextField()
  }
}
