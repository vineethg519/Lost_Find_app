//
//  ItemEditViewController.swift
//  Lost_Find
//
//  Created by appleGeek on 3/20/17.
//  Copyright © 2017 nwmsu. All rights reserved.
//

import UIKit
import Parse
class ItemEditViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate {
 var rvalue = ""
    var svalue = ""
    var cvalue = ""
        var dateSelected = ""
    var unwind_data1 = ""
    @IBOutlet weak var pnameTF: UITextField!
    @IBOutlet weak var statePicker: UIPickerView!
    
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var cityPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descTF: UITextField!
    @IBOutlet weak var colorTF: UITextField!
    @IBOutlet weak var bnameTF: UITextField!
    var sd1 = "" // email
    var sd2 = "" // product
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        pnameTF.resignFirstResponder()
        colorTF.resignFirstResponder()
        bnameTF.resignFirstResponder()
        descTF.resignFirstResponder()
        
        
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        picker1.delegate=self
        picker1.dataSource=self
        statePicker.delegate=self
        statePicker.dataSource=self
        cityPicker.delegate=self
        cityPicker.dataSource=self
        picker1.tag=1
        statePicker.tag=2
        cityPicker.tag=3
        datePicker.datePickerMode = .date
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM/dd/yy"
        dateSelected = dateformatter.string(from: datePicker.date)
        

print(sd1)
        print(sd2)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        loadItems()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func saveItem(_ sender: Any) {
        if((pnameTF.text?.isEmpty)! || (bnameTF.text?.isEmpty)! || (colorTF.text?.isEmpty)! || (descTF.text?.isEmpty)!)
        {
            let alert = UIAlertController(title: "Alert", message: "Please Enter All Fields", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated:true, completion: nil)
        }
        else{
            
                            let query = PFQuery(className: "report")
                            query.whereKey("email", equalTo: self.sd1)
                            query.whereKey("pname",equalTo: self.sd2)
                            query.findObjectsInBackground(block: { (result:[PFObject]?, error:Error?) in
                                
                                for objects in result!{
                                //let reportItems = PFObject(className: "report")
                                objects["pname"] = self.pnameTF.text!
                                objects["bname"] = self.bnameTF.text!
                                objects["color"] = self.colorTF.text!
                                objects["state"] = self.svalue
                                objects["city"] = self.cvalue
                                objects["reported"] = String(self.rvalue)
                                objects["description"] = String(self.descTF.text!)
                                    objects["date"] = self.dateSelected as! String
                                 objects.saveInBackground()
                                    self.unwind_data1 = self.pnameTF.text!

                                    
                                }
                            })
            
                        
            let alert = UIAlertController(title: "Sucesss", message: "Item Saved Successfully!", preferredStyle: UIAlertControllerStyle.alert)
            //alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title:"OK", style: .default, handler: { action in self.performSegue(withIdentifier: "unwindtoList", sender: self)
            
            }))
            self.present(alert, animated: true, completion: nil)

            //self.present(alert, animated:true, completion: nil)
         
                        }
    }


    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == picker1)
        {
            rvalue = lostfound[row] as String
        }
        else if pickerView == statePicker
        {
            svalue = states[row] as String
            
        }
        else if pickerView == cityPicker
        {
            cvalue = cities[row] as String
        }
    }
    
    var lostfound=["--","Lost","Found"]
    var states=["---","AR","CA","MO","OH","TX"]
    var cities=["---","Cleveland","Dallas","Los Angeles","Maryville"]
 
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView==picker1
        {
            return lostfound.count
        }
        else if pickerView==statePicker
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
        else if pickerView==statePicker
        {
            return states[row]
        }
        else
        {
            return cities[row]
        }
        
    }


    func loadItems()
        
    {
        let userQuery = PFQuery(className: "report")
        userQuery.findObjectsInBackground { (result:[PFObject]?, error:Error?) in
            if error == nil
            {
                
                for object in result!
                {
                    self.sd1 = object.value(forKey: "email") as! String
                    if (self.sd2 == object.value(forKey: "pname") as! String)
                    {
                        self.pnameTF.text = object.value(forKey: "pname") as! String?
                        self.bnameTF.text = object.value(forKey: "bname") as! String?
                        
                        self.colorTF.text = object.value(forKey: "color") as! String?
                 
                        self.descTF.text = object["description"] as! String // accessing in different way as desc is of type dictionary
                        //let state = object["state"] as! String // same as above
                        //let city = object.value(forKey: "city") as! String
                        //print(object.value(forKey: "city"))
                        
                        //print(object["state"] as! String)
                        //self.placeTF.text = String("\(city), \(state)")!  // "City, State" format for placeTF
                        //self.dateTF.text = object.value(forKey: "date") as! String?
                      
                        
                    }
                    
                }
            }
            else
            {
                print(error)
            }
        } // query ends
    } // func ends

    
    
  
}
