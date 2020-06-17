//
//  TableViewController.swift
//  Lost? Find.
//
//  Created by Gajula,Vineeth on 2/28/17.
//  Copyright © 2017 Gajula,Vineeth. All rights reserved.
//

import UIKit
import Parse
class TableViewController: UITableViewController {
    @IBOutlet var myTable: UITableView!
    //var userlist = [PFUser]()
    var tf:Bool = true
    var arr1:[String]=[] // array of lost items
    var arr2:[String]=[] // array of found items
    //var ex:[String]=["hjak","sds","sdsd"]
    var cme = 0
    var count1 = 0
    // var users = [PFUser]()
    var objectArr:[String] = []
    var user_name1 = ""
    var product = ""
    var countme:Int = 1
    var countME = 1
    var dataWhenPress = ""
    var dataFromUnwind = ""
    var delete_item = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        loadReports()
        
    }
    override func viewWillAppear(_ animated: Bool) {
    
        DispatchQueue.main.async {
            self.myTable.reloadData()
        }
        print("product is :\(self.product)")
        refreshList()
    }
    func refreshList()
    {
        //if(self.countME == 1){
        print("product reported is:\(product) with ")
        
        let uq2 = PFQuery(className: "report")
        uq2.whereKey("email", equalTo: self.user_name1)
        uq2.whereKey("pname", equalTo: self.product)
        if(self.product.isEmpty){
            print("product is empty")
        }
        

        else if arr1.contains(self.product) || arr2.contains(self.product)
        {
            print("redundant data")
        
            }
        else{

                let uquery = PFQuery(className: "report")
                uquery.whereKey("email", equalTo: self.user_name1)
                uquery.whereKey("pname", equalTo: self.product)
                uquery.countObjectsInBackground { (count_product:Int32,error: Error?) in
                    print("Counted Product:\(count_product)")
                    self.executereports()
                  /*  self.cme = Int(count_product)
                    if(self.cme == 1 && self.tf)
                    {
                        print("entered refreshlist \(self.tf)")
                        self.executereports()
                        self.cme += 1
                        self.tf = false
                        
                    }
                    else{
                        print("dont do anything to table view")
                    }
                    
                    if(self.product.isEmpty){
                        print("product is empty")
                    }

                */
            }
            }

    }
    func executereports()
    {
        print("product reported is:\(product) with ")
        let uquery = PFQuery(className: "report")
        uquery.whereKey("email", equalTo: self.user_name1)
        uquery.whereKey("pname", equalTo: self.product)
        uquery.countObjectsInBackground { (counting:Int32,error: Error?) in
            uquery.findObjectsInBackground(block: { (object:[PFObject]?, error:Error?) in
                for obj in object!
                {
                    print("new items added")
                    let a = obj.value(forKey: "reported") as! String?
                    print("reported \(self.product) as \((a)!)")
                    if((a)!=="Lost")
                    {
                        print("entered if")
                        self.arr1.append(self.product)
                        self.myTable.reloadData()
                       // self.tf = true
                       // self.countME+=1
                    }
                    else if((a)! == "Found")
                    {
                        print("entered else")
                        self.arr2.append(self.product)
                        self.myTable.reloadData()
                      //  self.tf = true
                        
                        // self.countME+=1
                    }}
            })

    }
    }
    // loads report table and retrieves Lost and Found items and
    // stores them in arr1 and arr2 arrays as strings
    
    @IBAction func unwindToList(segue: UIStoryboardSegue)
    {
        if let sourceVC = segue.source as? ItemEditViewController
        {
           self.dataFromUnwind = sourceVC.unwind_data1
            self.dataWhenPress = sourceVC.sd2
            refreshWholeTable()
        }
    }
    func refreshWholeTable()
    {
        print("undwined data\(self.dataFromUnwind) data pressed: \(self.dataWhenPress)")
        if arr1.contains(self.dataFromUnwind) || arr2.contains(self.dataFromUnwind)
        {
            
        }
        else{
            if let index = arr1.index(of: self.dataWhenPress)
            {
                print("entered arr1 unwind")
                self.arr1.remove(at: index)
                self.myTable.reloadData()
            }
            else if let index = arr2.index(of: self.dataWhenPress)
            {
                print("entered arr2 unwind")
                self.arr2.remove(at: index)
                self.myTable.reloadData()


            }
            let uquery = PFQuery(className: "report")
            uquery.whereKey("email", equalTo: self.user_name1)
            uquery.whereKey("pname", equalTo: self.dataFromUnwind)
            uquery.countObjectsInBackground { (counting:Int32,error: Error?) in
                uquery.findObjectsInBackground(block: { (object:[PFObject]?, error:Error?) in
                    for obj in object!
                    {
                        print("new items added")
                        let a = obj.value(forKey: "reported") as! String?
                        print("reported \(self.product) as \((a)!)")
                        if((a)!=="Lost")
                        {
                            print("entered if")
                            self.arr1.append(self.dataFromUnwind)
                            self.myTable.reloadData()
                            // self.tf = true
                            // self.countME+=1
                        }
                        else if((a)! == "Found")
                        {
                            print("entered else")
                            self.arr2.append(self.dataFromUnwind)
                            self.myTable.reloadData()
                            //  self.tf = true
                            
                            // self.countME+=1
                        }}
                })
                
            }

        }
    }
    
    func loadReports()
    {
        
        let userQuery = PFQuery(className: "report")
        userQuery.findObjectsInBackground { (result:[PFObject]?, error:Error?) in
            if error == nil
            {
                print("finding objects")
                for object in result!
                {
                    var findUser = object.value(forKey: "email") as! String
                    if(findUser == self.user_name1)
                    {
                       // self.count+=1
                        var v = object.value(forKey: "reported") as! String
                        if(v=="Lost")
                        {
                            self.arr1.append(object["pname"] as! String)
                            //print(self.arr1)
                        }
                        else if(v=="Found")
                        {
                            self.arr2.append(object["pname"] as! String)
                            //print(self.arr2)
                        }
                        else
                        {
                            print("nothing found")
                        }
                        self.myTable.reloadData()
                    }
                }
                
            }
            else{
                print(error)
            }
            
        }
        tableView.delegate=self
        tableView.dataSource=self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func deleteItem()
    
    {
        print("entered deleteItem()")
        let query = PFQuery(className: "report")
        query.whereKey("email", equalTo: self.user_name1)
        query.whereKey("pname", equalTo: self.delete_item)
        query.findObjectsInBackground { (objects:[PFObject]?, error:Error?) in
          
            for object in objects!
            {
                object.deleteInBackground()
                object.saveInBackground()
                print("deleted successfull")
            }
            
        }
        
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            
            if indexPath.section == 0
            {
                print("delete: \(arr1[indexPath.row])")
                delete_item = String(arr1[indexPath.row])
                deleteItem()
                self.arr1.remove(at: indexPath.row)
                self.myTable.reloadData()
            }
        
            else if indexPath.section == 1
            {
                print("delete: \(arr2[indexPath.row])")
                delete_item = String(arr2[indexPath.row])
                self.arr2.remove(at: indexPath.row)
                deleteItem()
                self.myTable.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowcount=0
        if section == 0
        {
            rowcount = Int(self.arr1.count)
        }
        else if section == 1
        {
            rowcount = Int(self.arr2.count)
            
        }
        return rowcount
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let itemVC = self.storyboard?.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
        self.navigationController?.pushViewController(itemVC, animated: true)
        itemVC.sharedData1 = user_name1
        //UITableViewCell cell = [tableView .cellForRow(at: indexPath)]
        let ip = tableView.indexPathForSelectedRow
        let currentcell = tableView.cellForRow(at: ip!)
        print(currentcell?.textLabel?.text)
        itemVC.sharedData2 = (currentcell?.textLabel?.text)! //passing product name to ItemVC
        
        
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title=""
        if  section==0
        {
            title = "Lost"
        }
        else if section==1
        {
            title = "Found"
        }
        return title
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemname", for: indexPath)
        
        // displays lost and found items using single prototype cell
        switch indexPath.section
        {
        case 0:
            cell.textLabel?.text = String(arr1[indexPath.row])
            
        case 1:
            cell.textLabel?.text = String(arr2[indexPath.row])
            
        default:
            break
        }
        return cell
    }
    
}

