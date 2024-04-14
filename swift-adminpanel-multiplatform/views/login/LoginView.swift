//
//  LoginView.swift
//  macos-admin-panel
//
//  Created by joel on 16/03/24.
//

import SwiftUI

struct LoginView: View {
    @State var tfEmail = ""
    @State var tfPassword = ""
    @State var isRedirect = false
    var body: some View {
        NavigationStack{
            VStack(content: {
                Image(systemName: "person.badge.key.fill")
                    .resizable()
                    .frame(width:130,height: 130)
                Spacer().frame(height:75)
                CustomTextField(tfText: tfEmail, text: "Correo electrònico")
                Spacer().frame(height:30)
                CustomTextField(tfText: tfEmail, text: "Contraseña",isPassword: true)
                Spacer().frame(height:80)
                CustomButton(text: "Ingresar", onPress: {
                    print("Ingresar")
                    isRedirect.toggle()
                })
            })
            .frame(width: 300)
            .navigationDestination(isPresented: $isRedirect, destination: {
                ProductsView()
            })
        }
        
        
                
           
        
    }
}

#Preview {
    LoginView()
}

