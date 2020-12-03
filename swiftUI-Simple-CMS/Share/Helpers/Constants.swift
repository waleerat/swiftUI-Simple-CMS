//
//  Constants.swift
//  swiftUI-Simple-CMS
//
//  Created by Waleerat Gottlieb on 2020-12-02.
//

import Foundation
import SwiftUI

public let kFILEREFERENCE = "gs://wgoshop-79f64.appspot.com"

public let screen = UIScreen.main.bounds
public let userDefaults = UserDefaults.standard
public let kDEFAULEUPLOADIMAGE = "plus_photo"

//Common constant values
public let kID = "id"
public let kCREATEDDATE = "createDate"

//Category
public let kCATENAME = "name"

//Product
public let kPRONAME = "name"
public let kPROPRICE = "description"
public let kPROIMAGEURL = "imageURL"
public let kPROISACTIVE = "isActive"



// For Popinfo HelperView
enum InfoType {
    case Information
    case Warnning
    case Remind
}
//@State private var PopupInfoType: PopupInfoType = .Information

 public struct PopupInfo {
    var popupType: InfoType = .Information
    var title: String = "Title"
    var description: String = "Descripion"
    
    mutating func newValue(popupType: InfoType, title: String, description: String) {
        self.popupType = popupType
        self.title = title
        self.description = description
    }
}
