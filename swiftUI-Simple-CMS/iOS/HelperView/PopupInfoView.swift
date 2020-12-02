//
//  PopupInfoView.swift
//  swiftUI-Simple-CMS
//
//  Created by Waleerat Gottlieb on 2020-12-02.
//

import SwiftUI

struct PopUpInfoView: View {
    @Binding var IsPopupInfo: Bool
    @State var popupInfoType: InfoType
    @State var popupInfoTitle: String
    @State var popupInfoDescription: String


    var body: some View {
        let bgColor = "myInfo"
        return ZStack {
            Group {
                Color.init("myBackground").opacity(0.6)
                     
                        VStack {
                            // close buntton
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.IsPopupInfo.toggle()
                                }, label: {
                                    Image(systemName: "xmark.circle")
                                        .font(.system(size: 30))
                                })
                            }
                            .padding(.horizontal, 10)
                            .foregroundColor(.gray)
                            .padding()
                            VStack {
                                Text(popupInfoTitle)
                                    .font(.title)
                                    .bold()
                                    .padding(.top, -50)
                                Text(popupInfoDescription)
                                    .font(.title3)
                                    .padding(.top, 20)
                                    
                                Spacer()
                            }
                            .foregroundColor(.primary)
                            
                        }
                        
                    .frame(width: screen.width * 0.9, height: screen.height * 0.3)
                    .background(Color.init(bgColor))
                    .cornerRadius(10)
                    .shadow(radius: 10)
                
            }
            
        }
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            self.IsPopupInfo.toggle()
        }
        // End of Zstack
        
         
    }
}

struct PopUpInfoView_Previews: PreviewProvider {
    static var previews: some View {
      
        PopUpInfoView(IsPopupInfo: .constant(false), popupInfoType: .Information, popupInfoTitle: "", popupInfoDescription: "")
        
    }
}
