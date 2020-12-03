//
//  ProductUpdateRecord.swift
//  swiftUI-Simple-CMS
//
//  Created by Waleerat Gottlieb on 2020-12-02.
//

import SwiftUI

struct ProductUpdateRecord: View {
    
    @Binding var isUpdateRecord: Bool
    @Binding var productData: Product?
    
    var loadParent = {}
    
    var body: some View {
        
        ZStack {
            Color.init("myBackground")
            VStack {
                //Start Top Menu
                HStack(spacing: 20) {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 20))
                        Text("Product")
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
                    ProductForm(productData: $productData, isUpdateRecord: $isUpdateRecord, popupInfo: PopupInfo())
                }
                //End Body
            }
            .padding(.top, screen.height * 0.035)
            .padding(.bottom, 30)
            
        }.edgesIgnoringSafeArea(.all)
    }
}

//NOT ACTIVE JUST FOR DEBUGING
struct ProductUpdateRecord_Previews: PreviewProvider {
    static var previews: some View {
        ProductUpdateRecord(isUpdateRecord: .constant(false), productData: .constant(nil))
    }
}
