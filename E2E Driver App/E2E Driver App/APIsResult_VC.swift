//
//  APIsResult_VC.swift
//  E2E Driver App
//
//  Created by Josh Wang on 11/27/17.
//  Copyright © 2017 Optimizely. All rights reserved.
//

import Foundation
import OptimizelySDKiOS

class APIsResult_VC : ViewController {
    
    var apiResult : String?
    var optlyClient : OPTLYClient?
    @IBOutlet weak var apiReturnValueTextField: UITextField!
    @IBOutlet weak var userProfileServiceStateTextField: UITextField!
    @IBOutlet weak var forcedVariationMappingStateTextField: UITextField!
    @IBOutlet weak var logOutputsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        apiReturnValueTextField.text = apiResult
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
