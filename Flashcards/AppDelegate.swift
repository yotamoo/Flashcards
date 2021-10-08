//
//  AppDelegate.swift
//  Flashcards
//
//  Created by Justyna Kleczar on 08/10/2021.
//

import UIKit
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        // Move to Service
        let db = Firestore.firestore()
        
        db.collection("flashcards").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
        return true
    }
}
