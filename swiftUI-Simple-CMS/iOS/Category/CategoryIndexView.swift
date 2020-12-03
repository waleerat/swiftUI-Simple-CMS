//
//  CategoryIndexView.swift
//  swiftUI-Simple-CMS
//
//  Created by Waleerat Gottlieb on 2020-12-03.
//

import SwiftUI

struct CategoryIndexView: View {
    
    @ObservedObject var categoryListener = CategoryListener()
     
    @State var categoryData: Category?
    
    @State var isNewRecord: Bool = false
    @State var isUpdateRecord: Bool = false
    @State var isPopupInfo: Bool = false
    
    var loadParent = {}

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
                            ForEach(categoryListener.categories) { rowData in
                                // List Body
                                HStack {
                                     
                                    Text(rowData.name)
                                        .frame(alignment: .leading)
                                        .padding(.leading, 5)
                                    Spacer()
                                    
                                    Button(action: {
                                        self.isUpdateRecord.toggle()
                                        categoryData = rowData
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
            
            if isNewRecord {
                CategoryNewRecord(isNewRecord: $isNewRecord, categoryData: $categoryData, isUpdateRecord: $isUpdateRecord, loadParent: categoryListener.downloadcategories)
                .animation(.easeIn)
                .transition(.opacity)
            }
            
            if isUpdateRecord {
                CategoryUpdateRecord(isUpdateRecord: $isUpdateRecord, categoryData: $categoryData, loadParent: categoryListener.downloadcategories)
                    .animation(.easeIn)
                    .transition(.opacity)
            }
        }
        
    }
    
    // MARK: - Helper Function
    func deleteItems(at offsets: IndexSet) {
        let objectId = self.categoryListener.categories[offsets.first!].id
        CategoryCMS().removeRecord(objectId: objectId)
        self.categoryListener.categories.remove(at: offsets.first!)
        
    }
}

struct CategoryIndexView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.init("myBackground")
              //  .edgesIgnoringSafeArea(.all)
            CategoryIndexView()
        }
    }
}
 

