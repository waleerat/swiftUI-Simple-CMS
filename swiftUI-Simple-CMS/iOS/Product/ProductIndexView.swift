//
//  ProductIndexView.swift
//  swiftUI-Simple-CMS
//
//  Created by Waleerat Gottlieb on 2020-12-02.
//

import SwiftUI

struct ProductIndexView: View { 
    
    @State var isNewRecord: Bool = false
    @State var isUpdateRecord: Bool = false
    @State var isPopupInfo: Bool = false
    
    var body: some View {
        ZStack {
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
                VStack {
                    Text("Product Index View")
                    
                    Button(action: {
                        self.isUpdateRecord = true
                    }, label: {
                        Text("Test preview Edit View")
                    })
                    .frame(width: screen.width * 0.50, height: 50)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .background(Color(.blue))
                    .padding()
                }
                Spacer()
            }
            .padding(.top, -17)
            
            if isNewRecord {
                ProductNewRecord(isNewRecord: $isNewRecord)
                .animation(.easeIn)
                .transition(.opacity)
            }
            
            if isUpdateRecord {
                ProductUpdateRecord(isUpdateRecord: $isUpdateRecord)
                    .animation(.easeIn)
                    .transition(.opacity)
            }
        }
    }
}

struct ProductIndexView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.init("myBackground")
                .edgesIgnoringSafeArea(.all)
            ProductIndexView()
        }
    }
}

 
