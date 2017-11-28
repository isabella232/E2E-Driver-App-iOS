//
//  APIViewController.swift
//  E2E Driver App
//
//  Created by Josh Wang on 11/27/17.
//  Copyright © 2017 Optimizely. All rights reserved.
//

import Foundation
import OptimizelySDKiOS

class APIViewController : ViewController {
    
    var optlyClient : OPTLYClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(self.optlyClient?.optimizely?.config?.accountId)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
