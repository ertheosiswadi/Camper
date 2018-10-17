//
//  SignUpViewController.swift
//  Camper
//
//  Created by Ertheo Siswadi on 9/27/18.
//  Copyright © 2018 Ertheo Siswadi. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController:UIViewController
{
    @IBAction func unwindToLogin(_ sender: Any) {
        performSegue(withIdentifier: "unwindSignupToLogin", sender: self)
    }
    let apiHelper = APIHelper.init()
    
    var firstName_textField = UITextField(frame: CGRect.zero)
    var lastName_textField = UITextField(frame: CGRect.zero)
    var birthdate_textField = UITextField(frame: CGRect.zero)
    var username_textField = UITextField(frame: CGRect.zero)
    var password_textField = UITextField(frame: CGRect.zero)
    var favloc_textField = UITextField(frame: CGRect.zero)
    var validityButton_1 = UIButton(frame: CGRect.zero)
    var validityButton_2 = UIButton(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //when the signup button is pressed
    @objc func buttonPressed(sender: UIButton!) {
        if !isUsernameValid()
        {
            present(createAlert(message: "username already exists\ntry a different one", title: "invalid input"), animated: true, completion:nil)
        }
        else if !isPasswordValid()
        {
            present(createAlert(message: "password must meet the following criteria", title: "invalid password"), animated: true, completion:nil)
        }
        else if !areAllFieldsFilled()
        {
            present(createAlert(message: "please fill in all of the above fields", title: "blank fields"), animated: true, completion:nil)
        }
        else
        {
            postFromTextFields()
            unwindToLogin(sender)
        }
    }
    
    func createAlert(message msg:String, title t:String) -> UIAlertController
    {
        let alert = UIAlertController(title: t, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Clear", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            //nothing
        }))
        return alert
    }
    func areAllFieldsFilled() ->Bool
    {
        return firstName_textField.text != "" &&
        lastName_textField.text != "" &&
        birthdate_textField.text != "" &&
        username_textField.text != "" &&
        password_textField.text != "" &&
        favloc_textField.text != ""
    }
    func isUsernameValid() -> Bool
    {
        //get username from textfield
        let user_tf = username_textField.text!
        //check to database if username exists
        return !apiHelper.doesUsernameExist(usr: user_tf)
    }
    func isPasswordValid() -> Bool
    {
        //get password from textfield
        //make up a bunch of your own criterias
        //1. min 5 characters
        return true
    }
    
    
    func setupViews()
    {
        let screen_width = Int(UIScreen.main.bounds.width)
        let screen_height = Int(UIScreen.main.bounds.height)
        
        let bannerView_1 = UIView(frame: CGRect.init(x: 0, y: screen_height/5, width: screen_width, height: screen_height/12))
        bannerView_1.center = CGPoint(x: screen_width/2, y: screen_height/5)
        bannerView_1.backgroundColor = UIColor(red:0.17, green:0.10, blue:0.07, alpha:1.0)
        
        let bannerView_2 = UIImageView(frame: CGRect.init(x: screen_width/4, y: screen_height/5, width: screen_width/3, height: screen_width/3))
        bannerView_2.center = CGPoint(x: screen_width/4, y: screen_height/5)
        bannerView_2.layer.cornerRadius = bannerView_2.frame.size.width/2
        bannerView_2.backgroundColor = UIColor.black
        bannerView_2.image = UIImage(named: "logo.png")
        
        view.addSubview(bannerView_1)
        view.addSubview(bannerView_2)
        
        view.backgroundColor = UIColor(red:0.82, green:0.65, blue:0.43, alpha:1.0)
        
        let containerView = UIView(frame: CGRect.init(x: 0, y: 0, width: screen_width*5/6, height: screen_height/2))
        containerView.center = CGPoint(x: screen_width/2, y: screen_height*9/16)
        containerView.backgroundColor = UIColor(red:0.82, green:0.65, blue:0.43, alpha:1.0)//UIColor(red:0.61, green:0.42, blue:0.19, alpha:1.0)
        containerView.layer.borderColor = UIColor(red:0.17, green:0.10, blue:0.07, alpha:1.0).cgColor
        containerView.layer.borderWidth = 5
        containerView.layer.cornerRadius = 15
        
        let container_width = Int(containerView.frame.width)
        let container_height = Int(containerView.frame.height)
        
        firstName_textField = UITextField(frame: CGRect.init(x: container_width/10, y: container_height/12, width: container_width*7/20, height: container_height*5/42))
        firstName_textField.placeholder = "First Name"
        firstName_textField.backgroundColor = UIColor(red:0.89, green:0.77, blue:0.63, alpha:1.0)
        firstName_textField.layer.cornerRadius = 15
        firstName_textField.layer.borderColor = UIColor(red:0.85, green:0.70, blue:0.51, alpha:1.0).cgColor
        let paddingView = UIView(frame: CGRect.init(x: 0, y: 0, width: 15, height: firstName_textField.frame.height))
        firstName_textField.leftView = paddingView
        firstName_textField.leftViewMode = UITextFieldViewMode.always
        firstName_textField.autocorrectionType = UITextAutocorrectionType.no
        
        
        lastName_textField = UITextField(frame: CGRect.init(x: container_width*5/10, y: container_height/12, width: container_width*4/10, height: container_height*5/42))
        lastName_textField.placeholder = "Last Name"
        lastName_textField.backgroundColor = UIColor(red:0.89, green:0.77, blue:0.63, alpha:1.0)
        lastName_textField.layer.cornerRadius = 15
        lastName_textField.layer.borderColor = UIColor(red:0.85, green:0.70, blue:0.51, alpha:1.0).cgColor
        lastName_textField.leftView = UIView(frame: CGRect.init(x: 0, y: 0, width: 15, height: lastName_textField.frame.height))
        lastName_textField.leftViewMode = UITextFieldViewMode.always
        lastName_textField.autocorrectionType = UITextAutocorrectionType.no
        
        birthdate_textField = UITextField(frame: CGRect.init(x: container_width/10, y: container_height*11/42, width: container_width*4/5, height: container_height*5/42))
        birthdate_textField.placeholder = "Birthdate (MM/DD/YYYY)"
        birthdate_textField.backgroundColor = UIColor(red:0.89, green:0.77, blue:0.63, alpha:1.0)
        birthdate_textField.layer.cornerRadius = 15
        birthdate_textField.layer.borderColor = UIColor(red:0.85, green:0.70, blue:0.51, alpha:1.0).cgColor
        birthdate_textField.leftView = UIView(frame: CGRect.init(x: 0, y: 0, width: 15, height: birthdate_textField.frame.height))
        birthdate_textField.leftViewMode = UITextFieldViewMode.always
        
        username_textField = UITextField(frame: CGRect.init(x: container_width/10, y: container_height*37/84, width: container_width*3/5, height: container_height*5/42))
        username_textField.placeholder = "username"
        username_textField.backgroundColor = UIColor(red:0.89, green:0.77, blue:0.63, alpha:1.0)
        username_textField.layer.cornerRadius = 15
        username_textField.layer.borderColor = UIColor(red:0.85, green:0.70, blue:0.51, alpha:1.0).cgColor
        username_textField.leftView = UIView(frame: CGRect.init(x: 0, y: 0, width: 15, height: username_textField.frame.height))
        username_textField.leftViewMode = UITextFieldViewMode.always
        username_textField.autocorrectionType = UITextAutocorrectionType.no
        username_textField.autocapitalizationType = UITextAutocapitalizationType.none
        validityButton_1 = UIButton(frame: CGRect.init(x: container_width*18/25, y: container_height*37/84 + 5, width: container_width*2/25, height: container_width*2/25))
        let check_image = UIImage(named: "refresh-icon.png") as UIImage?
        validityButton_1.setBackgroundImage(check_image, for: UIControlState.normal)
        
        password_textField = UITextField(frame: CGRect.init(x: container_width/10, y: container_height*13/21, width: container_width*3/5, height: container_height*5/42))
        password_textField.placeholder = "password"
        password_textField.backgroundColor = UIColor(red:0.89, green:0.77, blue:0.63, alpha:1.0)
        password_textField.layer.cornerRadius = 15
        password_textField.layer.borderColor = UIColor(red:0.85, green:0.70, blue:0.51, alpha:1.0).cgColor
        password_textField.leftView = UIView(frame: CGRect.init(x: 0, y: 0, width: 15, height: password_textField.frame.height))
        password_textField.leftViewMode = UITextFieldViewMode.always
        password_textField.autocorrectionType = UITextAutocorrectionType.no
        password_textField.autocapitalizationType = UITextAutocapitalizationType.none
        password_textField.isSecureTextEntry = true
        validityButton_2 = UIButton(frame: CGRect.init(x: container_width*18/25, y: container_height*13/21 + 5, width: container_width*2/25, height: container_width*2/25))
        validityButton_2.setBackgroundImage(check_image, for: UIControlState.normal)
        
        favloc_textField = UITextField(frame: CGRect.init(x: container_width/10, y: container_height*67/84, width: container_width*4/5, height: container_height*5/42))
        favloc_textField.placeholder = "Favourite Location (e.g. Machu Picchu)"
        favloc_textField.backgroundColor = UIColor(red:0.89, green:0.77, blue:0.63, alpha:1.0)
        favloc_textField.layer.cornerRadius = 15
        favloc_textField.layer.borderColor = UIColor(red:0.85, green:0.70, blue:0.51, alpha:1.0).cgColor
        favloc_textField.leftView = UIView(frame: CGRect.init(x: 0, y: 0, width: 15, height: favloc_textField.frame.height))
        favloc_textField.leftViewMode = UITextFieldViewMode.always
        favloc_textField.autocorrectionType = UITextAutocorrectionType.no
        
        containerView.addSubview(firstName_textField)
        containerView.addSubview(lastName_textField)
        containerView.addSubview(birthdate_textField)
        containerView.addSubview(username_textField)
        containerView.addSubview(validityButton_1)
        containerView.addSubview(password_textField)
        containerView.addSubview(validityButton_2)
        containerView.addSubview(favloc_textField)
        view.addSubview(containerView)
        
        let signupButton = UIButton(frame: CGRect.init(x: 0, y: 0, width: screen_width*5/6, height: screen_height/17))
        signupButton.center = CGPoint(x: screen_width/2, y: screen_height*9/16 + screen_height/4 + container_height*5/42)
        signupButton.layer.borderWidth = 5
        signupButton.layer.borderColor = UIColor(red:0.17, green:0.10, blue:0.07, alpha:1.0).cgColor
        signupButton.backgroundColor = UIColor(red:0.17, green:0.10, blue:0.07, alpha:1.0)
        signupButton.setTitleColor(UIColor(red:0.82, green:0.65, blue:0.43, alpha:1.0), for: UIControlState.normal)
        signupButton.layer.cornerRadius = 15
        signupButton.setTitle("Sign Up", for: UIControlState.normal)
        signupButton.addTarget(self, action: #selector(self.buttonPressed), for: UIControlEvents.touchUpInside)
        
        
        view.addSubview(signupButton)
    }
    
    func postFromTextFields()
    {
        apiHelper.postRequest(input:
            [
                "name": firstName_textField.text! as String + " " + lastName_textField.text! as String,
                "username": username_textField.text! as String,
                "birthdate": birthdate_textField.text! as String,
                "password": password_textField.text! as String,
                "profilepic": "google.com",
                "favlocation":favloc_textField.text!  as String
            ])
        {
            (profile) in
            print("response is -> \(profile)")
        }
    }
}
