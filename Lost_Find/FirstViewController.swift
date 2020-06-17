//
//  FirstViewController.swift
//  Lost? Find.
//
//  Created by Gajula,Vineeth on 2/10/17.
//  Copyright © 2017 Gajula,Vineeth. All rights reserved.
//

import UIKit
import Parse
class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource , UITextFieldDelegate{
    
    
    var selectedUser:PFUser?
    var userArray = [PFUser]()
    var svalue:String = ""
    var cvalue:String = ""
    var rvalue:String = ""
    var objID = ""
    var user_name = ""
    var dateSelected = ""
    var prod = ""
    @IBOutlet weak var brand_name: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var color: UITextField!
    @IBOutlet weak var product_name: UITextField!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var picker1: UIPickerView! // lost found
    @IBOutlet weak var picker2: UIPickerView! // states
    @IBOutlet weak var picker3: UIPickerView! // cities
    
    @IBOutlet weak var desc: UITextField!
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        brand_name.resignFirstResponder()
        product_name.resignFirstResponder()
        desc.resignFirstResponder()
        color.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //keyboard shows
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField: desc, moveDistance: -400, up: true)
    }
    // keyboard hiddens
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField: desc, moveDistance: -200, up: false)
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // func loaduser(selectedUser!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("shared data is :")
        print(user_name)
        picker1.delegate=self
        picker1.dataSource=self
        picker2.delegate=self
        picker2.dataSource=self
        picker3.delegate=self
        picker3.dataSource=self
        picker1.tag=1
        picker2.tag=2
        picker3.tag=3
        date.datePickerMode = .date
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM/dd/yy"
        dateSelected = dateformatter.string(from: date.date)
        
       let navC = self.tabBarController?.viewControllers![2] as! UINavigationController
        let vc = navC.topViewController as! TableViewController
        vc.user_name1=user_name //passing username to tablVC
        vc.product = self.product_name.text!
      //vc.product = prod
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func clearAll(_ sender: Any) {
        
    let alert = UIAlertController(title: "Alert", message: "All fields will reset!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated:true, completion: nil)
     brand_name.text = ""
     product_name.text = ""
     desc.text = ""
     color.text = ""
        
    }
    
    @IBAction func report(_ sender: Any) {
        
    if((product_name.text?.isEmpty)! || (brand_name.text?.isEmpty)! || (color.text?.isEmpty)! || (desc.text?.isEmpty)!)
    {
        let alert = UIAlertController(title: "Alert", message: "Please Enter All Fields", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated:true, completion: nil)
    }
    else{
        
        
        
        let reportItems = PFObject(className: "report")
        reportItems["pname"] = self.product_name.text!
        reportItems["bname"] = self.brand_name.text!
        reportItems["color"] = self.color.text!
        reportItems["state"] = svalue
        reportItems["city"] = cvalue
        reportItems["reported"] = String(rvalue)
        reportItems["description"] = String(self.desc.text!)
        reportItems["email"] = self.user_name // shared data from loginVC
     
   
        
        //print("Date is:\(selectedDate)")
        
        reportItems["date"] = dateSelected as! String
        //reportItems["user"] = users["objectId"]
       reportItems.saveInBackground()
             prod = self.product_name.text!
        let navC = self.tabBarController?.viewControllers![2] as! UINavigationController
        let vc = navC.topViewController as! TableViewController
        vc.user_name1=user_name //passing username to tablVC
        vc.product = self.product_name.text!
       // vc.product = prod
   
        let alert = UIAlertController(title: "Sucesss", message: "Item reported", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated:true, completion: nil)
        brand_name.text = ""
        product_name.text = ""
        desc.text = ""
        color.text = ""
        
        }
        }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == picker1)
        {
            rvalue = lostfound[row] as String
        }
        else if pickerView == picker2
        {
            svalue = states[row] as String
            
        }
        else if pickerView == picker3
        {
            cvalue = cities[row] as String
        }
    }
  
    var lostfound=["--","Lost","Found"]
    var states=["---","AR","CA","MO","OH","TX"]
    var cities=["---","Cleveland","Dallas","Los Angeles","Maryville"]
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      if pickerView==picker1
      {
        return lostfound.count
        }
        else if pickerView==picker2
      {
        return states.count
        }
        else
      {
        return cities.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView==picker1
        {
            return lostfound[row]
        }
        else if pickerView==picker2
        {
            return states[row]
        }
        else
        {
            return cities[row]
        }
        
    }
  
  
}

