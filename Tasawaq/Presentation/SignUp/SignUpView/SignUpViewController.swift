//
//  SignUpViewController.swift
//  Tasawaq
//
//  Created by Salma on 27/11/2023.
//

import UIKit

class SignUpViewController: UIViewController {
  //MARK: -IBOutlets
  @IBOutlet weak var userNameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var passwordConfirmationTextField: UITextField!
  @IBOutlet weak var notMatchedLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTextField()
  }
  override func viewWillAppear(_ animated: Bool){
    notMatchedLabel.isHidden = true
  }
  
}
//MARK: -IBActions
private extension SignUpViewController{
  @IBAction func signUp(_ sender: UIButton){
  }
  @IBAction func editPasswordConfirmationTextField(_ sender: UITextField){
    if passwordTextField.text != sender.text{
      notMatchedLabel.isHidden = false
    }else{
      notMatchedLabel.isHidden = true
    }
  }
  @IBAction func hideUnhide(_ sender: UIButton){
    switch sender.tag{
    case 1:
      sender.isSelected = !sender.isSelected
      if sender.isSelected{
        passwordTextField.isSecureTextEntry = false
        sender.setImage(UIImage(systemName: "eye"), for: .normal)
      }else{
        passwordTextField.isSecureTextEntry = true
        sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
      }
    case 2:
      sender.isSelected = !sender.isSelected
      if sender.isSelected{
        passwordConfirmationTextField.isSecureTextEntry = false
        sender.setImage(UIImage(systemName: "eye"), for: .normal)
      }else{
        passwordConfirmationTextField.isSecureTextEntry = true
        sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
      }
    default:
      return
    }
  }
}
//MARK: -UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate{
  func configureTextField(){
    userNameTextField.delegate = self
    userNameTextField.setLeftView(image: UIImage(systemName: "person")!)
    userNameTextField.stylingTextField()
    
    emailTextField.delegate = self
    emailTextField.setLeftView(image: UIImage(systemName: "at")!)
    emailTextField.stylingTextField()
    
    passwordTextField.delegate = self
    passwordTextField.setLeftView(image: UIImage(systemName: "lock")!)
    passwordTextField.stylingTextField()
    
    passwordConfirmationTextField.delegate = self
    passwordConfirmationTextField.setLeftView(image: UIImage(systemName: "lock")!)
    passwordConfirmationTextField.stylingTextField()
  }
}
