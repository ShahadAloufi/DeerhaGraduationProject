//
//  AJApp.swift
//  AJ
//
//  Created by Areej Albaqami on 09/11/1443 AH.
//

import SwiftUI
import Firebase
@main
struct AJApp: App {
  
    
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
     
    
    var body: some Scene {
        let authViewModel = AuthViewModel()
        let loginPopUpCheck = LoginPopUpCheck()
        let cashBoxOpen = CashBoxOpen()
        let cashBoxViewModel = CashBoxViewModel()
        
        WindowGroup {
            MainView()
                .environmentObject(authViewModel)
                .environmentObject(loginPopUpCheck)
                .environmentObject(cashBoxOpen)
                .environmentObject(cashBoxViewModel)
                .environment(\.colorScheme, .light)
        }
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}



class AppDelegate: NSObject, UIApplicationDelegate {
    static var orientationLock = UIInterfaceOrientationMask.landscape
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
 
}
