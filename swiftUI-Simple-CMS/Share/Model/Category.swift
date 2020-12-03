//
//  Category.swift
//  swiftUI-Simple-CMS
//
//  Created by Waleerat Gottlieb on 2020-12-03.
//

import Foundation
import Firebase

struct Category: Identifiable {
        var id: String
        var name: String
    
    func saveOrderToFirestore() {
        let withData = CategoryCMS().dictionaryFrom(self)
        FirebaseReference(.Category).document(self.id).setData(withData) {
            error in
            
            if error != nil {
                print("error saving order to firestore: ", error!.localizedDescription)
            }
        }
    }
}


class CategoryCMS {
    func dictionaryFrom(_ category: Category) -> [String : Any] {
        
        return NSDictionary(objects: [category.id,
                                      category.name
                                    ],
                            forKeys: [kID as NSCopying,
                                      kCATENAME as NSCopying
        ]) as! [String : Any]
    }
    
    func emptyStrucValues(){
        let category = Category(id: "", name: "")
    }
    
    func createRecord(_name: String, completion: @escaping (_ error: InfoType?,_ message: String?) -> Void) {
            
        FirebaseReference(.Product).whereField(kPRONAME, isEqualTo: _name).addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            
            if snapshot.isEmpty {
                let category = Category(id: UUID().uuidString, name: _name)
                category.saveOrderToFirestore()
                self.emptyStrucValues()
                completion(.Information, "Created")
                
            } else {
                completion(.Information, "Duplicate name")
            }
        }
    }
    
    
    func updateRecord(_objectId: String,_name: String, completion: @escaping (_ error: InfoType?,_ message: String?) -> Void) {
        
        let category = Category(id: _objectId, name: _name)
        category.saveOrderToFirestore()
        emptyStrucValues()
        completion(.Information, "Updated")
        
    }
    
    func removeRecord(objectId: String) {
        FirebaseReference(.Category).document(objectId).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print(">> Document successfully removed!")
            }
        }
    }

}
