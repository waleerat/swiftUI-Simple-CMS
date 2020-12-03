//
//  ProductModel.swift
//  swiftUI-Simple-CMS
//
//  Created by Waleerat Gottlieb on 2020-12-02.
//

import Foundation
import Firebase
import FirebaseStorage

struct Product: Identifiable, Hashable {
    var id: String
    var name: String!
    var price: Double!
    var imageURL: String!
    var isActive: Bool!
    var createdDate : Date = Date()
    
    
    func saveOrderToFirestore() {
        let withData = ProductCMS().dictionaryFrom(self)
        FirebaseReference(.Product).document(self.id).setData(withData) {
            error in
            
            if error != nil {
                print("error saving order to firestore: ", error!.localizedDescription)
            }
        }
    }
    // MARK: - End
 
}


class ProductCMS {
    func dictionaryFrom(_ Product: Product) -> [String : Any] {
        
        return NSDictionary(objects: [Product.id,
                                      Product.name ?? "",
                                      Product.price ?? "",
                                      Product.imageURL ?? "",
                                      Product.isActive ?? true,
                                      Product.createdDate
                                    ],
                            
                            forKeys: [kID as NSCopying,
                                      kPRONAME as NSCopying,
                                      kPROPRICE as NSCopying,
                                      kPROIMAGEURL as NSCopying,
                                      kPROISACTIVE  as NSCopying,
                                      kCREATEDDATE as NSCopying
        ]) as! [String : Any]
        
        
    }
    
    func emptyStrucValues(){
        var product = Product(id: UUID().uuidString)
        product.id = ""
        product.name = ""
        product.price = 0.0
        product.imageURL = ""
        product.isActive = true
    }
    
    
    
    func createRecord(_name: String, _price: Double, _imageURL: String, _isActive: Bool, completion: @escaping (_ error: InfoType?,_ message: String?) -> Void) {
            
        FirebaseReference(.Product).whereField(kPRONAME, isEqualTo: _name).addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            
            if snapshot.isEmpty {
              
                var product = Product(id: UUID().uuidString)
                product.id = UUID().uuidString
                product.name = _name
                product.price = _price
                product.imageURL = _imageURL
                product.isActive = _isActive
                product.createdDate = Date()
                
                product.saveOrderToFirestore()
                self.emptyStrucValues()
                completion(.Information, "Created")
                
            } else {
                completion(.Information, "Duplicate name")
            }
        }
    }
    
    
    func updateRecord(_objectId: String,_name: String, _price: Double, _imageURL: String, _isActive: Bool, completion: @escaping (_ error: InfoType?,_ message: String?) -> Void) {
        
        var product = Product(id: UUID().uuidString)
        product.id = _objectId
        product.name = _name
        product.price = _price
        product.imageURL = _imageURL
        product.isActive = _isActive
        product.createdDate = Date()
        
        product.saveOrderToFirestore()
        emptyStrucValues()
        completion(.Information, "Updated")
        
    }
    
    func removeRecord(objectId: String) {
        print("removeRecord \(objectId)")
        FirebaseReference(.Product).whereField(kID, isEqualTo: objectId).addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else { return }

            if !snapshot.isEmpty {
                let rowData = snapshot.documents
                let imageURL = rowData.map { $0["imageURL"]! }
                
                // Delete Document
                FirebaseReference(.Product).document(objectId).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print(">> Document successfully removed!")
                        
                        //Removes image from storage
                        if (imageURL[0] as! String != "") {
                            FileStorage.removeFileFromFirestore(fileURL: imageURL[0] as! String)
                        }
                        
                    }
                }
            }
            
            
            
           
        }
         
        
       // fileExistsAt(path: String)
        
        

    }

}

