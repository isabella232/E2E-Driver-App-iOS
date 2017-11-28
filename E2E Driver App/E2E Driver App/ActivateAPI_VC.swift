//
//  ActivateAPI_VC.swift
//  E2E Driver App
//
//  Created by Josh Wang on 11/27/17.
//  Copyright © 2017 Optimizely. All rights reserved.
//

import Foundation
import OptimizelySDKiOS

class ActivateAPI_VC : ViewController {
    
    var optlyClient : OPTLYClient?
    @IBOutlet weak var experimentKeyTextField: UITextField!
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var attributesTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CallAPI_Pressed(_ sender: Any) {
        
        let attributesMap : [String : String]! = convertToDictionary(text: attributesTextField.text!)
        
        let activateResult : String? = optlyClient?.activate(experimentKeyTextField.text!,
                                                        userId: userIdTextField.text!,
                                                        attributes: attributesMap!)?.variationKey
        
        let apisResult_VC : APIsResult_VC = storyboard?.instantiateViewController(withIdentifier: "APIs Result View Controller") as! APIsResult_VC
        apisResult_VC.apiResult = activateResult
        apisResult_VC.optlyClient = optlyClient
        self.present(apisResult_VC, animated: true, completion: nil)
    }
}

func convertToDictionary(text: String) -> [String: String]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
        } catch {
            print(error.localizedDescription)
        }
    }
    return [:]
}

