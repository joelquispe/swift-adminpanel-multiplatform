//
//  CustomTextField.swift
//  macos-admin-panel
//
//  Created by joel on 16/03/24.
//

import SwiftUI

struct CustomTextField: View {
    @State var tfText: String
    var text: String
    var isPassword = false
    var body: some View {
        if(isPassword){
            SecureField(text: $tfText, label:  {
                
            })
            .padding()
            .background(.white)
            .foregroundColor(.black)
            .textFieldStyle(.plain)
            .clipShape(.rect(cornerRadius: 15))
        }else{
            TextField(text: $tfText, label: {
                Text(text)
            })
            .padding()
            .background(.white)
            .foregroundColor(.black)
            .textFieldStyle(.plain)
            .clipShape(.rect(cornerRadius: 15))
        }
    }
}

