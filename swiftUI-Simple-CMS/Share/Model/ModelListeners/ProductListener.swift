//
//  ProductListener.swift
//  swiftUI-Simple-CMS
//
//  Created by Waleerat Gottlieb on 2020-12-02.
//

import Foundation
import Firebase
import SwiftUI

class ProductListener: ObservableObject {
    
    @Published var products: [Product] = []
    
    init() {
        downloadproducts()
    }
     
    
    func downloadproducts() {
        print(">> Refresh rows ")
        FirebaseReference(.Product)
            .order(by: kCREATEDDATE, descending: true)
            .getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else { return }
            
            if !snapshot.isEmpty {
                
                self.products = self.getRowsFromDictionary(snapshot)
            }
        }
    }
    
    
    func getRowsFromDictionary(_ snapshot: QuerySnapshot) -> [Product] {
        
        var allRows: [Product] = []
        
        for snapshot in snapshot.documents {
            
            let rowData = snapshot.data()
           
           allRows.append(Product(id: rowData[kID] as? String ?? UUID().uuidString,
                                    name: rowData[kPRONAME]! as? String ?? "",
                                    price: rowData[kPROPRICE]! as? Double ?? 0.0,
                                    imageURL: rowData[kPROIMAGEURL]! as? String ?? "",
                                    isActive: rowData[kPROISACTIVE]! as? Bool ?? true,
                                    createdDate:  Date() //rowData[kCREATEDDATE] as? Data
                                    )
                            )
        }
        
        return allRows
    }
    
}
