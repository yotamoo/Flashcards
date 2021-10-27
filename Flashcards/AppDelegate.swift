//
//  AppDelegate.swift
//  Flashcards
//
//  Created by Justyna Kleczar on 08/10/2021.
//

import UIKit
import Common

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Common.initializeFirebase()

        return true
    }
}
