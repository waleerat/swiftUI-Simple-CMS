//
//  CategoryForm.swift
//  swiftUI-Simple-CMS
//
//  Created by Waleerat Gottlieb on 2020-12-03.
//

import SwiftUI

struct CategoryForm: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var categoryListener: CategoryListener
    
    @Binding var categoryData: Category?
    @Binding var isUpdateRecord: Bool
    @State var name: String = ""
    @State var IsCompleted: Bool = false
    
    var loadParent = {}
    
    var body: some View {
        
        return ZStack {
            Color.init("myBackground")
            VStack {
                // Start Form
                ScrollView {
                    VStack (spacing: 50) {
                        VStack (alignment: .leading){
                            Text("Category Name")
                                .font(.headline)
                                .fontWeight(.light)
                                .foregroundColor(Color.init(.label))
                                .opacity(0.75)
                            TextField("Requied", text: $name)
                                .padding(10)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(7)
                            
                        }
                        
                        Button(action: {
                            saveDataToFirebase()
                            self.loadParent()
                        }, label: {
                            Text("Save")
                                .foregroundColor(.white)
                                .frame(width: screen.width - 120)
                                .padding()
                                .padding(.horizontal)
                        })
                        .background((name == "") ? Color.gray : Color.blue)
                        .clipShape(Capsule())
                        .padding(.top, 45)
                        .disabled((name == ""))
                        
                    }.padding()
                } // End ScrollView
                // End Form
            }
            
            
            if IsCompleted {
                Text("Wait a minute")
                .fullScreenCover(isPresented: .constant(true), content: {
                    // for navigation
//                    CategoryIndexView(categoryListener: CategoryListener()) {
//                        isUpdateRecord = false
//                        self.presentationMode.wrappedValue.dismiss()
//                    }
                    // for bottom bar menu
                    HomeView()
                })
                
            }
            
        }
        .onAppear {
            if (isUpdateRecord) {
                if let categoryData = categoryData {
                    name = categoryData.name
                }
            }
        }
        
        // End of ZStack
    }
    
    // MARK: - Helper Functions
    func saveDataToFirebase(){
        if (categoryData == nil) {
            doCreateRecord()
        } else {
            doUpdateRecord()
        }
    }
    
    func doUpdateRecord(){
     
        CategoryCMS().updateRecord(_objectId: categoryData?.id ?? "", _name: self.name) { (infoType, message)  in
            self.IsCompleted = true
            
        }
    }
    
    func doCreateRecord(){
        CategoryCMS().createRecord(_name: self.name) { (infoType, message)  in
                // reset form and popup Info
            self.IsCompleted = true
            self.name = ""
          
        }
    }
    
 
}
