//
//  CategoryListener.swift
//  swiftUI-Simple-CMS
//
//  Created by Waleerat Gottlieb on 2020-12-03.
//

import Foundation
import Firebase
import SwiftUI

class CategoryListener: ObservableObject {
    
    @Published var categories: [Category] = []
    
    init() {
        downloadcategories()
    }
     
    
    func downloadcategories() {
        print(">> Refresh rows ")
        FirebaseReference(.Category)
            .order(by: kCATENAME, descending: true)
            .getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else { return }
            
            if !snapshot.isEmpty {
                
                self.categories = self.getRowsFromDictionary(snapshot)
            }
        }
    }
    
    
    func getRowsFromDictionary(_ snapshot: QuerySnapshot) -> [Category] {
        
        var allRows: [Category] = []
        
        for snapshot in snapshot.documents {
            
            let rowData = snapshot.data()
           
           allRows.append(Category(
                                id: rowData[kID] as? String ?? UUID().uuidString,
                                name: rowData[kCATENAME]! as? String ?? ""
                                )
                            )
        }
        
        return allRows
    }
    
}

