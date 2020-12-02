//
//  ProductNewRecord.swift
//  swiftUI-Simple-CMS
//
//  Created by Waleerat Gottlieb on 2020-12-02.
//

import SwiftUI

struct ProductNewRecord: View {
    @Binding var isNewRecord: Bool
    
    var body: some View {
        ZStack {
            Color.init("myBackground")
            VStack {
                //Start Top Menu
                HStack(spacing: 20) {
                    Image(systemName: "doc.text")
                        .font(.system(size: 20))
                        Text("Product")
                            .font(.title2)
                            .bold()
                        Spacer()
                    
                    Button(action: {
                        self.isNewRecord.toggle()
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
                    ProductForm(popupInfo: PopupInfo())
                }
                //End Body
            }
            .padding(.top, screen.height * 0.035)
            .padding(.bottom, 30)
            
            
        }.edgesIgnoringSafeArea(.all)
         
    }
}

//NOT ACTIVE JUST FOR DEBUGING
struct ProductNewRecord_Previews: PreviewProvider {
    static var previews: some View {
            ProductNewRecord(isNewRecord: .constant(false)) 
    }
}
