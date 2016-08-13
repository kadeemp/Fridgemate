//
//  GroceryListView.swift
//  Fridgemate
//
//  Created by MakeSchool on 8/13/16.
//  Copyright © 2016 Kadeem. All rights reserved.
//

import UIKit

class GroceryListView: UIViewController {

    var userDefaults = NSUserDefaults.standardUserDefaults()

    @IBOutlet weak var groceryListTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        groceryListTextView = userDefaults.objectForKey("savedGroceryList") as? UITextView

        // Do any additional setup after loading the view.
    }
    @IBAction func saveButton(sender: AnyObject) {
        self.userDefaults.setObject(groceryListTextView, forKey: "savedGroceryList")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
