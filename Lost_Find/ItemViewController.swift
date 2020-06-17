//
//  ItemViewController.swift
//  Lost_Find
//
//  Created by appleGeek on 3/20/17.
//  Copyright © 2017 nwmsu. All rights reserved.
//

import UIKit
import Parse
class ItemViewController: UIViewController {
    var sharedData1 = ""
    var sharedData2 = ""
    var email_IVC = ""
    var product_IVC = ""

    @IBOutlet weak var nameTF: UILabel!
  
    @IBOutlet weak var colorTF: UILabel!
    @IBOutlet weak var dateTF: UILabel!

    
    @IBOutlet weak var placeTF: UILabel!
    @IBOutlet weak var brandTF: UILabel!

    @IBOutlet weak var desc: UILabel!

    //@IBOutlet weak var desc: UITextView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: "god_pleaseHelp")
        
        print("shared data's user:\(sharedData1) with item:\(sharedData2)")
        loadReported()
        // Do any additional setup after loading the view.
    }
func god_pleaseHelp()
{
    self.performSegue(withIdentifier: "test", sender: self)
    
}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "test"
        {
            var vc = segue.destination as! ItemEditViewController
            vc.sd1 = sharedData1
            vc.sd2 = sharedData2
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadReported()
        
    {
        let userQuery = PFQuery(className: "report")
        //userQuery.getObjectInBackground(withId: <#T##String#>, block: ()
        userQuery.findObjectsInBackground { (result:[PFObject]?, error:Error?) in
        if error == nil
        {
            
            for object in result!
            {
                self.email_IVC = object.value(forKey: "email") as! String
               // self.product_IVC =
                    if (self.email_IVC == self.sharedData1 && self.sharedData2 == object.value(forKey: "pname") as! String)
                    {
                        //if(self.product_IVC == self.sharedData2)
                        self.nameTF.text = object.value(forKey: "pname") as! String?
                        self.colorTF.text = object.value(forKey: "color") as! String?
                        //print("printing desc")
                        //print(object["description"] as! String)
                        self.desc.text = object["description"] as! String // accessing in different way as desc is of type dictionary
                        let state = object["state"] as! String // same as above
                        let city = object.value(forKey: "city") as! String
                        //print(object.value(forKey: "city"))
                        
                        //print(object["state"] as! String)
                        self.placeTF.text = String("\(city), \(state)")!  // "City, State" format for placeTF
                        self.dateTF.text = object.value(forKey: "date") as! String?
                        self.brandTF.text = object.value(forKey: "bname") as! String?
                        
                        
                    }
                
            }
        }
        else
        {
         print(error)
        }
        } // query ends
    } // func ends
} // class ends
