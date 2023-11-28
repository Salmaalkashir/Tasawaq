//
//  SignInViewController.swift
//  Tasawaq
//
//  Created by Salma on 27/11/2023.
//

import UIKit

class SignInViewController: UIViewController {
  
  //MARK: -IBOutlets
  @IBOutlet weak var welcome: UILabel!
  @IBOutlet weak var userName: UITextField!
  @IBOutlet weak var password: UITextField!
  @IBOutlet weak var stackView: UIStackView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTextField()
  }
  //MARK: -IBActions
  @IBAction func forgetPassword(_ sender: Any) {
  }
  @IBAction func signIn(_ sender: Any) {
  }
  @IBAction func signUp(_ sender: Any) {
  }
}


//MARK: -UITextFieldDelegate
extension SignInViewController: UITextFieldDelegate{
  func configureTextField(){
    userName.delegate = self
    //UserName.setLeftView(image: UIImage(systemName: "person")!)
    //UserName.stylingTextField()
    
    password.delegate = self
    // Password.setLeftView(image: UIImage(systemName: "lock")!)
    //Password.stylingTextField()
  }
}
