//
//  FireDBHelper.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-06.
//

import Foundation
import FirebaseFirestore

class FireDBHelper: ObservableObject {
    
    public static var shared: FireDBHelper?
    private var db: Firestore
    
    private init(database: Firestore) {
        self.db = database
    }
    
    static func getInstance() -> FireDBHelper {
        if self.shared == nil {
            self.shared = FireDBHelper(database: Firestore.firestore())
        }
        return self.shared!
    }
    
    
}
