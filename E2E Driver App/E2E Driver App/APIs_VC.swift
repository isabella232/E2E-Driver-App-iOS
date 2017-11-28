//
//  APIViewController.swift
//  E2E Driver App
//
//  Created by Josh Wang on 11/27/17.
//  Copyright © 2017 Optimizely. All rights reserved.
//

import Foundation
import OptimizelySDKiOS

class APIs_VC : ViewController {
    
    var optlyClient : OPTLYClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func activate_pressed(_ sender: Any) {
        let activateAPI_VC : ActivateAPI_VC = storyboard?.instantiateViewController(withIdentifier: "Activate API View Controller") as! ActivateAPI_VC
        activateAPI_VC.optlyClient = optlyClient
        self.present(activateAPI_VC, animated: true, completion: nil)
    }
}
