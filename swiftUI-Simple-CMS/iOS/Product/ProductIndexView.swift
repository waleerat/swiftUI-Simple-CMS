//
//  ProductIndexView.swift
//  swiftUI-Simple-CMS
//
//  Created by Waleerat Gottlieb on 2020-12-02.
//

import SwiftUI
import KingfisherSwiftUI


struct ProductIndexView: View {
    
    @ObservedObject var productListener = ProductListener()
     
    @State var productData: Product?
    @State var uploadImage: String = kDEFAULEUPLOADIMAGE
    
    @State var IsConfirmation: Bool = false
    @State var ConfirmationAnswer: Bool = false
    @State var ConfirmationTitle: String = ""
    @State var ConfirmationDescription: String = ""
    
    @State var isNewRecord: Bool = false
    @State var isUpdateRecord: Bool = false
    @State var isPopupInfo: Bool = false
    
    var loadParent = {}
    
//    init() {
//        ProductListener().downloadproducts()
//    }
    
    var body: some View {
        ZStack {
            Color.init("myBackground")
                .edgesIgnoringSafeArea(.all)
            VStack {
                //Start Top Menu
                HStack(spacing: 20) {
                    Image(systemName: "list.dash")
                        .font(.system(size: 20))
                    
                        Text("Category")
                            .font(.title2)
                            .bold()
                        Spacer()
                    
                    Button(action: {
                        self.isNewRecord.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 20))
                            .scaleEffect(x: 1.1)
                    })
                        
                    }
                    .padding(15)
                    .background(Color("myHeader"))
                // End Top menu
                //Body
            
                    // Start Body
                    List {
                        Section {
                            ForEach(productListener.products) { rowData in
                                // List Body
                                HStack {
                                    if (rowData.imageURL != "") {
                                        KFImage(URL(string: rowData.imageURL)!)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 80, height: 60)
                                            .cornerRadius(5)
                                            .shadow(radius: 7)
                                            
                                    } else {
                                        Image(uploadImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .cornerRadius(5)
                                            .shadow(radius: 7)
                                    }
                                    Text(rowData.name)
                                        .frame(alignment: .leading)
                                        .padding(.leading, 5)
                                    Spacer()
                                    Text(String(rowData.price))
                                        .frame(alignment: .leading)
                                        .padding(.leading, 5)
                                   
                                    Button(action: {
                                        self.isUpdateRecord.toggle()
                                        productData = rowData
                                    }, label: {
                                        Image(systemName: "square.and.pencil")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                    })
                                    
                                }
                                .padding()
                                
                                //End of HStack
                                // End List Body
                                
                            }//End of ForEach
                            
                            .onDelete { (indexSet) in
                                //self.IsConfirmation.toggle()
                                self.deleteItems(at: indexSet)
                            }
                        }
                    }
                    .navigationBarTitle("All Records")
                    .listStyle(GroupedListStyle())
                    // End Body
              
                Spacer()
            }
            .padding(.top, -17)
            
            .onDisappear(){
               print("productData >>\(productData) ")
            }
            
            if isNewRecord {
                ProductNewRecord(isNewRecord: $isNewRecord, productData: $productData, isUpdateRecord: $isUpdateRecord, loadParent: productListener.downloadproducts)
                .animation(.easeIn)
                .transition(.opacity)
            }
            
            if isUpdateRecord {
                ProductUpdateRecord(isUpdateRecord: $isUpdateRecord, productData: $productData, loadParent: productListener.downloadproducts)
                    .animation(.easeIn)
                    .transition(.opacity)
            }
            
            if IsConfirmation {
                ConfirmationView(IsConfirmation: $IsConfirmation, ConfirmationAnswer: $ConfirmationAnswer, ConfirmationTitle: "Confirm to delete", ConfirmationDescription: "Are you sure?")
                    .animation(.easeInOut)
            }
            
            if ConfirmationAnswer {
               // { print("landmark: \(landmark)") }
            }
        }
        
    }
    
    // MARK: - Helper Function
    func deleteItems(at offsets: IndexSet) {
        let objectId = self.productListener.products[offsets.first!].id
        ProductCMS().removeRecord(objectId: objectId)
        self.productListener.products.remove(at: offsets.first!)
        
    }
}

struct ProductIndexView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.init("myBackground")
              //  .edgesIgnoringSafeArea(.all)
            ProductIndexView()
        }
    }
}
 
