//
//  LoginViewController.swift
//  Lost_Find
//
//  Created by appleGeek on 3/19/17.
//  Copyright © 2017 nwmsu. All rights reserved.
//

import UIKit
import Parse
class LoginViewController: UIViewController, UITextFieldDelegate{
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        email.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
    var  objectID:String = ""
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.email.delegate = self
        self.password.delegate = self
        let userQuery = PFQuery(className: "_User")
        userQuery.findObjectsInBackground { (result:[PFObject]?, error:Error?) in
            if error == nil
            {
                //print("printing report objectID;s")
                for object in result!
                {
                    //print(object)
                    self.objectID = object.objectId!
                    
                }
            }
            else{
                print(error)
            }
        }
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //keyboard shows
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField: password, moveDistance: -100, up: true)
    }
    // keyboard hiddens
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField: password, moveDistance: -100, up: false)
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginsuccess"
        {
        let destVC = segue.destination as! UITabBarController
           // let s =
        let tab = destVC.viewControllers?[0] as! FirstViewController
       // let tab1 = destVC.viewControllers?[1] as! TableViewController
        tab.objID = objectID
        tab.user_name = email.text!
            //tab1.user_name1 = email.text!
    }
        else if segue.identifier == "signupview"
        {
            let desVC = segue.destination as! SignUpViewController
        }
    }
    
    @IBAction func login(_ sender: Any) {
        let email = self.email.text!
        let password = self.password.text!
        if ((email.isEmpty) || (password.isEmpty))
        {
            let alert = UIAlertController(title: "Invalid", message: "Please Enter all fields", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated:true, completion: nil)
        }
        else{
       // PFUser.login
        PFUser.logInWithUsername(inBackground: email, password: password, block:{(user, error) -> Void in
            if error != nil{
               //print(error)
                let alert = UIAlertController(title: "OOPS", message: "Sorry, User Does'nt exists!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated:true, completion: nil)

            }
            else {
                let alert:UIAlertController = UIAlertController(title: "Success", message: "You have Successfully Logged-in!", preferredStyle: .alert)
                let defaultAction:UIAlertAction =  UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(UIAlertAction(title:"OK", style: .default, handler: { action in self.performSegue(withIdentifier: "loginsuccess", sender: self)}))
                self.present(alert, animated: true, completion: nil)
                
                
            }
        })
        }
  
    }


    
}
