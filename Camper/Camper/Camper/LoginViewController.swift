//
//  LoginViewController.swift
//  Camper
//
//  Created by Ertheo Siswadi on 9/14/18.
//  Copyright © 2018 Ertheo Siswadi. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    let apiHelper = APIHelper.init()
    var userProfile : [String: Any] = [:]
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func onLoginButton(_ sender: Any) {
        
        //get text from text fields
        let username_tf = usernameTextField.text!
        let password_tf = passwordTextField.text!
        
        //grab username textfield and use httpget to get the users json profile
        //compare the passwordfromtextfield with passwordfromjson
        //if it matches then perform segue
        //else report error (dialogue would be best)
        if apiHelper.doesUsernameExist(usr: username_tf) && isPasswordCorrect(password: password_tf)
        {
            performSegue(withIdentifier: "fromLoginSegue", sender: self)
        }
        else
        {
            present(createAlert(message: "username/password is invalid", title: "invalid input"), animated: true, completion:nil)
        }
    }
    @IBOutlet weak var signupButton: UIButton!
    @IBAction func signupButton(_ sender: Any) {
    }
    
    let attrs : [NSAttributedStringKey:Any] =
        [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17),
         NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.17, green:0.10, blue:0.07, alpha:1.0)
        
        let buttonTitleAttributedString = NSMutableAttributedString(string: "Sign Up", attributes: attrs)
        
        signupButton.setAttributedTitle(buttonTitleAttributedString, for: .normal)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tb = segue.destination as? UITabBarController
        {
            let vc = tb.viewControllers![0] as! ProfileViewController
            vc.profile = self.userProfile
        }
    }
    func isPasswordCorrect(password pw_tf:String) -> Bool //blocking func
    {
        var pw_real : String = ""
        //make blocking
        let semaphore = DispatchSemaphore(value: 0)
        //check for the password
        apiHelper.getRequest(username: usernameTextField.text!) { (profile) in
            pw_real = profile["password"] as! String
            self.userProfile = profile
            semaphore.signal()
        }
        semaphore.wait()
        if pw_real == pw_tf
        {
            return true
        }
        return false
    }
    func createAlert(message msg:String, title t:String) -> UIAlertController
    {
        let alert = UIAlertController(title: t, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Clear", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            //nothing
        }))
        return alert
    }
    
}
