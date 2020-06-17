//
//  SecondViewController.swift
//  Lost? Find.
//
//  Created by Gajula,Vineeth on 2/10/17.
//  Copyright © 2017 Gajula,Vineeth. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    var states=["AR","CA","MO","OH","TX"]
    var cities=["Cleveland","Dallas","Los Angeles","Maryville"]
    @IBOutlet weak var statePick: UIPickerView!
        @IBOutlet weak var cityPick: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        statePick.delegate=self
        statePick.dataSource=self
        cityPick.delegate=self
        cityPick.dataSource=self
        
    statePick.tag=1
        cityPick.tag=2
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
}
func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView==statePick
    {
    return 5
}
    else
    {
        return 4
    }

    }
func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerView==statePick
    {
        return states[row]
    }
    else
    {
        return cities[row]
    }
    
}

}
