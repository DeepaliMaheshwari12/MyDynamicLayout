//
//  AppDelegate.swift
//  MyDynamicAutoLayout
//
//  Created by GtoMobility on 22/04/19.
//  Copyright © 2019 GtoMobility. All rights reserved.
//

import UIKit
import AuthenticationServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var webAuthSession: ASWebAuthenticationSession?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        getAuthTokenWithWebLogin()
        return true
    }
    func getAuthTokenWithWebLogin() {
        
        let authURL = URL(string: "https://github.com/login/oauth/authorize?client_id=d63f8acff36bc179266e")
        let callbackUrlScheme = "mydynamicautolayout://callback"
        
        self.webAuthSession = ASWebAuthenticationSession.init(url: authURL!, callbackURLScheme: callbackUrlScheme, completionHandler: { (callBack:URL?, error:Error?) in
            
            // handle auth response
            guard error == nil, let successURL = callBack else {
                return
            }
            
            let oauthToken = NSURLComponents(string: (successURL.absoluteString))?.queryItems?.filter({$0.name == "code"}).first
            
            // Do what you now that you've got the token, or use the callBack URL
            print(oauthToken ?? "No OAuth Token")
        })
        
        // Kick it off
        self.webAuthSession?.start()
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }


}

