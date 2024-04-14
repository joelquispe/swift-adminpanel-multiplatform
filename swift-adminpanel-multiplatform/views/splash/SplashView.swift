//
//  SplashView.swift
//  macos-admin-panel
//
//  Created by joel on 16/03/24.
//

import SwiftUI

struct SplashView: View {
    @State var isLogin = false
    @State var isSplash = true
    @State var isRedirect = false
    
    func redirectView() -> AnyView{
        if(isLogin){
            return AnyView(ProductsView())
        }else{
            return AnyView(LoginView())
        }
    }
    
    var body: some View {
        NavigationStack(){
            VStack(content: {
                   Image(systemName: "house.lodge.circle.fill")
                        .resizable()
                        .frame(width:200,height: 200)
            })
            .navigationDestination(isPresented: $isRedirect, destination: {
                redirectView()
            })
            
        }
        
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                isRedirect.toggle()
            })
        }
        
    }
}

#Preview {
    SplashView()
}
