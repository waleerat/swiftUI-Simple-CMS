//
//  CategoryUpdateRecord.swift
//  swiftUI-Simple-CMS
//
//  Created by Waleerat Gottlieb on 2020-12-03.
//

import SwiftUI

struct CategoryUpdateRecord: View {
    
    @Binding var isUpdateRecord: Bool
    @Binding var categoryData: Category?
    
    var loadParent = {}
    
    var body: some View {
        
        ZStack {
            Color.init("myBackground")
            VStack {
                //Start Top Menu
                HStack(spacing: 20) {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 20))
                        Text("Category")
                            .font(.title2)
                            .bold()
                        Spacer()
                    
                    Button(action: {
                        self.loadParent()
                        self.isUpdateRecord.toggle()
                    }, label: {
                        Image(systemName: "list.dash")
                            .font(.system(size: 20))
                            .scaleEffect(x: 1.1)
                    })
                        
                    }
                    .padding(15)
                    .background(Color("myHeader"))
                // End Top menu
                
                // Start Body
                ScrollView(.vertical, showsIndicators: false) {
                    CategoryForm(categoryData: $categoryData, isUpdateRecord: $isUpdateRecord)
                }
                //End Body
            }
            .padding(.top, screen.height * 0.035)
            .padding(.bottom, 30)
            
        }.edgesIgnoringSafeArea(.all)
    }
}

//NOT ACTIVE JUST FOR DEBUGING
struct CategoryUpdateRecord_Previews: PreviewProvider {
    static var previews: some View {
        CategoryUpdateRecord(isUpdateRecord: .constant(false), categoryData: .constant(nil))
    }
}
