//
//  ClientInitializationVC.swift
//  E2E Driver App
//
//  Created by Josh Wang on 10/3/17.
//  Copyright © 2017 Optimizely. All rights reserved.
//

import UIKit
import OptimizelySDKiOS

class ClientInitializationVC : UIViewController {
    
    @IBOutlet weak var UserProfileServiceNameField: UITextField!
    @IBOutlet weak var UserProfileServiceStateField: UITextField!
    @IBOutlet weak var ForcedVariationMappingState: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func initializeClientPressed(_ sender: UIButton) {
        var datafile : Data = Data.init()
        
        if let filepath = Bundle.main.url(forResource: "datafile", withExtension: "json") {
            do {
                datafile = try Data(contentsOf: filepath)
            } catch {
                // contents could not be loaded
            }
        } else {
            // example.txt not found!
            
        }
        
//        let userProfileServiceName : String! = self.UserProfileServiceNameField!.text!
//        let userProfileService : OPTLYUserProfileService = UserProfileServiceHelper.getUserProfileService(userProfileServiceName)!
        
        let optlyClient : OPTLYClient? = OPTLYClient.init { (builder) in
            builder.datafile = datafile
//            builder.userProfileService = userProfileService
        }
        
        let apiSelectorVC : APIs_VC! = storyboard?.instantiateViewController(withIdentifier: "APIs View Controller") as! APIs_VC
        apiSelectorVC.optlyClient = optlyClient
        self.present(apiSelectorVC, animated: true, completion: nil)
    }
    
    
    
}
