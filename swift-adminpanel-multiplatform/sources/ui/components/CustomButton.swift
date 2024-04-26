//
//  CustomButtton.swift
//  macos-admin-panel
//
//  Created by joel on 16/03/24.
//

import Foundation
import SwiftUI
struct CustomButton: View{
    var text:String
    var onPress: ()-> Void
    var body:some View{
        Button(action: onPress, label: {Text(text).padding()})
    }
}
