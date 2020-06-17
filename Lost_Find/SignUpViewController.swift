//
//  SignUpViewController.swift
//  Lost_Find
//
//  Created by appleGeek on 3/18/17.
//  Copyright © 2017 nwmsu. All rights reserved.
//

import UIKit
import Parse
class SignUpViewController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fName.delegate = self
        self.lName.delegate = self
        self.email.delegate = self
        self.pwd.delegate = self
        self.cpwd.delegate = self
        self.phone.delegate = self
        
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        fName.resignFirstResponder()
        lName.resignFirstResponder()
        email.resignFirstResponder()
        pwd.resignFirstResponder()
        cpwd.resignFirstResponder()
        phone.resignFirstResponder()
        
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var cpwd: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    //keyboard shows
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField: phone, moveDistance: -120, up: true)
    }
    // keyboard hiddens
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField: phone, moveDistance: -120, up: false)
    }
    // userdefined method to show animation for keyboard
    func moveTextField(textField: UITextField, moveDistance: Int, up:Bool)
    {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
        
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        
        let first_name = self.fName.text
        let last_name = self.lName.text
        var email = self.email.text
        var phone = self.phone.text
        var pwd = self.pwd.text
        var cpwd = self.cpwd.text
        // Validate the text fields
        if ((first_name?.isEmpty)! || (last_name?.isEmpty)! || (email?.isEmpty)! || (pwd?.isEmpty)! || (cpwd?.isEmpty)! || (phone?.isEmpty)!)
        {
            let alert = UIAlertController(title: "Invalid", message: "Please Enter all fields", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated:true, completion: nil)
        }
        else if pwd != cpwd {
            let alert = UIAlertController(title: "Invalid", message: "Password doesn't match", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated:true, completion: nil)
            
        } else if (phone?.characters.count)! < 10 {
            let alert = UIAlertController(title: "Invalid", message: "Please enter a valid Phone Number", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated:true, completion: nil)

            
        } else if (email?.characters.count)! < 8 {
            let alert = UIAlertController(title: "Invalid", message: "Please enter a valid Email Address", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated:true, completion: nil)
        }
           else if ((pwd?.characters.count)! < 8 ){
            let alert = UIAlertController(title: "invalid", message: "Please enter a valid Password atleast 8 characters", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated:true, completion: nil)
            }
            else {
            var User = PFUser()
           // userTable.email
            User.username = email  // email is your username which is required for login i.e onlt with email
            User.password = pwd
            User["fname"] = first_name
            User["lname"] = last_name
            
            User["PhoneNumber"] = phone
            User.signUpInBackground( block: {
                (success, error) -> Void in
                if let error = error as NSError? {
                    let errorString = error.userInfo["error"] as? NSString
                    // In case something went wrong, use errorString to get the error
                    //self.displayAlertWithTitle("Something has gone wrong", message:"\(errorString)")
                   // print(errorString)
                    let alert = UIAlertController(title: "OOPS", message: "\(errorString!)", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated:true, completion: nil)

            
                } else {
                    let alert:UIAlertController = UIAlertController(title: "Success", message: "You have Successfully Registered!", preferredStyle: .alert)
                    let defaultAction:UIAlertAction =  UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(UIAlertAction(title:"OK", style: .default, handler: { action in self.performSegue(withIdentifier: "login", sender: self)}))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                }
            })
            
            
        }
    }
  
}
