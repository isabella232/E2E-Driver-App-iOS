//
//  UserProfileServiceHelper.swift
//  E2E Driver App
//
//  Created by Josh Wang on 10/5/17.
//  Copyright © 2017 Optimizely. All rights reserved.
//

import OptimizelySDKUserProfileService

class UserProfileServiceHelper {

    class func getUserProfileService(_ name: String) -> OPTLYUserProfileService? {
    //    switch name {
    //    case "NormalService":
            print("normal")
        return OPTLYUserProfileServiceDefault.init({ (builder) in
            
        })
    //    case "LookupErrorService":
    //        print("lookup error service")
    //    case "SaveErrorService":
    //        print("save error service")
    //    default:
    //        return nil<OPTLYUserProfileService>
    //    }
    }
    
}
