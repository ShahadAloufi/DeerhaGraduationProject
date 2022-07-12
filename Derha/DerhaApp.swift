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
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            TabView()
                .environment(\.colorScheme, .light)
            
        }
    }
}
class AppDelegate: NSObject,UIApplicationDelegate{
     
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
         
        FirebaseApp.configure()
        return true
    }
}
