//
//  ProductForm.swift
//  swiftUI-Simple-CMS
//
//  Created by Waleerat Gottlieb on 2020-12-02.
//

import SwiftUI

struct ProductForm: View {
    @State private var image: SwiftUI.Image?
    @State private var imageSeleted: UIImage?
    @State private var filterIntensity = 0.5
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State var name: String = ""
    @State var description: String = ""
    @State var price: String = ""
    @State var isActive: Bool = true
    @State var uploadImage: String = kDEFAULEUPLOADIMAGE
    
    @State var IsPopupInfo: Bool = false
    @State var popupInfo: PopupInfo
     
    
    var body: some View {
        ZStack {
            Color.init("myBackground")
            VStack {
                // Start Form
                ScrollView {
                    VStack (spacing: 50) {
            
                        ZStack {
                            if image != nil {
                                image?
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screen.width * 0.9)
                            } else {
                                Image(uploadImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screen.width * 0.5)
                                    .onTapGesture {
                                        self.showingImagePicker = true
                                    }
                            }
                            
                             
                        }
                        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                            ImagePicker(image: self.$inputImage, imageSeleted: $imageSeleted)
                        }
                        
                        VStack (alignment: .leading){
                            Text("Product Name")
                                .font(.headline)
                                .fontWeight(.light)
                                .foregroundColor(Color.init(.label))
                                .opacity(0.75)
                            TextField("Requied", text: $name)
                                .padding(10)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(7)
                            
                            HStack {
                                Text("Price")
                                    .font(.headline)
                                    .fontWeight(.light)
                                    .foregroundColor(Color.init(.label))
                                    .opacity(0.75)
                                TextField("0.0", text: $price)
                                    .padding(10)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(7)
                                    .keyboardType(.numberPad)
                                
                                
                                Toggle(isOn: $isActive) {
                                    Text("Active")
                                }.padding()

                            }
                            
                            
                        }
                        
                        Button(action: {
                            saveDataToFirebase()
                        }, label: {
                            Text("Save")
                                .foregroundColor(.white)
                                .frame(width: screen.width - 120)
                                .padding()
                                .padding(.horizontal)
                        })
                        .background((name == "" || price == "") ? Color.gray : Color.blue)
                        .clipShape(Capsule())
                        .padding(.top, 45)
                        .disabled((name == "" || price == ""))
                        
                        
                    }.padding()
                } // End ScrollView
                // End Form
            }
            
            if IsPopupInfo {
                PopUpInfoView(IsPopupInfo: $IsPopupInfo, popupInfoType: popupInfo.popupType, popupInfoTitle: popupInfo.title, popupInfoDescription: popupInfo.description)
                    .animation(.easeInOut)
            }
        }// End of ZStack
    }
    
    // MARK: - Helper Functions
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    private func uploadImage(_ image: UIImage, completion: @escaping (_ imageURL: String?)-> Void) {
        //let fileDirectory = "Avatars/_" + FUser.currentId() + ".jpg"
        let fileName = UUID().uuidString
        let fileDirectory = "Category/" + fileName + ".jpg"
        
        FileStorage.uploadImage(image, directory: fileDirectory) { (imageURL) in
            FileStorage.saveImageLocally(imageData: image.jpegData(compressionQuality: 0.8)! as NSData, fileName: fileName)
            completion(imageURL)
        }
    
    }
    
    
    func saveDataToFirebase(){
        var imageURL: String = ""
        uploadImage(self.inputImage!) { (uploadedImageURL) in
            imageURL = uploadedImageURL ?? ""
        }
        
        ProductCMS().createRecord(_name: self.name,
                                  _price: Double(self.price) ?? 0.0,
                                    _imageURL: imageURL,
                                    _isActive: self.isActive) { (infoType, message)  in
            // reset form and popup Info
            self.IsPopupInfo = true
            self.name = ""
            self.price = ""
            self.image = nil
            self.popupInfo.newValue(popupType: infoType ?? .Information,
                                    title: "Save Category",
                                    description: message!)
            
        }
    }
}


//NOT ACTIVE JUST FOR DEBUGING
struct ProductForm_Previews: PreviewProvider {
    static var previews: some View {
        ProductForm(popupInfo: PopupInfo())
    }
}
