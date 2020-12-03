//
//  ConfirmationView.swift
//  swiftUI-Simple-CMS
//
//  Created by Waleerat Gottlieb on 2020-12-02.
//

import SwiftUI

 struct ConfirmationView: View {
    
        @Binding var IsConfirmation: Bool
        @Binding var ConfirmationAnswer: Bool
        @State var ConfirmationTitle: String
        @State var ConfirmationDescription: String
        
    
        var body: some View {
            return ZStack {
                Group {
                    Color.init("myBackground").opacity(0.6)
                         
                            VStack {
                                // close buntton
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        self.IsConfirmation.toggle()
                                    }, label: {
                                        Image(systemName: "xmark.circle")
                                            .font(.system(size: 30))
                                    })
                                    
                                }
                                .padding(.horizontal, 10)
                                .foregroundColor(.gray)
                                .padding()
                                VStack {
                                    Text(ConfirmationTitle)
                                        .font(.title)
                                        .bold()
                                        .padding(.top, -50)
                                    Text(ConfirmationDescription)
                                        .font(.title3)
                                        .padding(.top, 20)
                                        
                                    Spacer()
                                }
                                .foregroundColor(.primary)
                                
                                HStack(spacing: 3) {
                                    Button(action: {
                                        IsConfirmation.toggle()
                                        ConfirmationAnswer = false
                                    }, label: {
                                        Text(" Yes ")
                                    })
                                    .foregroundColor(.white)
                                    .frame(width: screen.width * 0.3)
                                    .padding()
                                    .padding(.horizontal)
                                    .background(Color("myButtonYes"))
                                    .onTapGesture {
                                        IsConfirmation.toggle()
                                        ConfirmationAnswer = true
                                    }
                                    
                                    Button(action: {
                                        IsConfirmation.toggle()
                                        ConfirmationAnswer = false
                                    }, label: {
                                        Text(" No ")
                                    })
                                    .foregroundColor(.white)
                                    .frame(width: screen.width * 0.3)
                                    .padding()
                                    .padding(.horizontal)
                                    .background(Color("myButtonNo"))
                                    .onTapGesture {
                                        IsConfirmation.toggle()
                                        ConfirmationAnswer = false
                                    }
                                }
                                .font(.title2)
                                
                            }
                            
                        .frame(width: screen.width * 0.9, height: screen.height * 0.3)
                        .background(Color("myBackgroundConfirmation"))
                        .cornerRadius(10)
                        .shadow(radius: 10)
                    
                }
                
            }
            .edgesIgnoringSafeArea(.all)
             
            // End of Zstack
            
             
        }
    }

    struct ConfirmationView_Previews: PreviewProvider {
        static var previews: some View {
          
            ConfirmationView(IsConfirmation: .constant(false), ConfirmationAnswer: .constant(false), ConfirmationTitle: "Title", ConfirmationDescription: "Are you sure?")
            
        }
    }


