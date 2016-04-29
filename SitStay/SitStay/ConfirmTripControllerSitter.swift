//
//  ConfirmTripControllerSitter.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/25/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class ConfirmTripControllerSitter: UIViewController {

    @IBOutlet weak var textField: UITextField!
    var values:NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submit(sender: AnyObject) {
        
        //ToDo, pull trip object where trip.tripID = textField.text and all associated pets and to-do lists
        //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //let fetchedPets = appDelegate.getPets()
        
        //
        if let text = textField.text{
            if (text.characters.count > 0){
                get()
        }
        ///
        //appDelegate.insertNewTrip(NSDate.init(timeIntervalSinceNow: NSTimeInterval.init(30)), endDate: NSDate.init(timeIntervalSinceNow: NSTimeInterval.init(35000)), street: "821 East Walnut Street", zip: "65201", city: "Columbia", addr2: "Apt. 240", pets: fetchedPets!, tripName: "New Zealand", isSitting: true)
        
            let storyboard = UIStoryboard(name: "Sitter", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("tabBarControllerSitter") as! UITabBarController
            vc.selectedIndex = 0
            vc.modalTransitionStyle = .CrossDissolve
            presentViewController(vc, animated: true, completion: nil)
        }
        
        
    }
    
    func get(){
        let tripID:Int? = Int(textField.text!)
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.petsitterz.netau.net/getTrip.php")!)
        request.HTTPMethod = "POST"
        let postString = "a=\(tripID!)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            
        }
        task.resume()

        
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
