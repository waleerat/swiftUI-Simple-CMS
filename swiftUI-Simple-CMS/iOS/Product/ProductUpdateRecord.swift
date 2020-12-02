//
//  ProductUpdateRecord.swift
//  swiftUI-Simple-CMS
//
//  Created by Waleerat Gottlieb on 2020-12-02.
//

import SwiftUI

struct ProductUpdateRecord: View {
    
    @Binding var isUpdateRecord: Bool
    
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
                        self.isUpdateRecord.toggle()
                    }, label: {
                        Image(systemName: "list.dash")
                            .font(.system(size: 20))
                    })
                        
                    }
                    .padding(15)
                    .background(Color("myHeader"))
                // End Top menu
                
                // Start Body
                ScrollView(.vertical, showsIndicators: false) {
                    
                }
                //End Body
            }
            .padding(.top, screen.height * 0.035)
            .padding(.bottom, 30)
            
            
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ProductUpdateRecord_Previews: PreviewProvider {
    static var previews: some View {
        ProductUpdateRecord(isUpdateRecord: .constant(false))
    }
}
