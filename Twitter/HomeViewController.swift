//
//  homeViewController.swift
//  Twitter
//
//  Created by Taylor McLaughlin on 10/1/18.
//  Copyright © 2018 Taylor McLaughlin. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignOut(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
        PFUser.logOutInBackground { (error: Error?) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                self.performSegue(withIdentifier: "logoutSegue", sender: nil)
            }
        }
        
    }
    

}
