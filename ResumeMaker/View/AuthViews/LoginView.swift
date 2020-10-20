//
//  ContentView.swift
//  ResumeMaker
//
//  Created by Anthony Ankit on 13/10/20.
//

import SwiftUI

struct LoginView : View {
    @State var email = ""
    @State var password = ""
    @State var showSignUP = false
    @AppStorage("login_status") var status = true
    var body: some View{
        ZStack{
            VStack{
                Spacer(minLength: 0)
                ZStack{
                    if UIScreen.main.bounds.height < 750{
                        Image("logo")
                            .resizable()
                            .frame(width: 130, height: 130)
                    }
                    else{
                        Image("logo")
                    }
                }
                .padding(.horizontal)
                .padding(.vertical,20)
                .background(Color.white.opacity(0.2))
                .cornerRadius(30)
                .padding(.top)
                
                VStack(spacing: 4){
                    Text("Lets create the resume")
                        .foregroundColor(Color.black.opacity(0.3))
                        .fontWeight(.heavy)
                }
                .padding(.top)
                
                VStack(spacing: 20){
                    CustomTextField(image: "person", placeHolder: "Email", txt: $email)
                    CustomTextField(image: "lock", placeHolder: "Password", txt: $password)
                }
                .padding(.top)
                
                Button(action: {
                    loginClicked()
                }) {
                    Text("LOGIN")
                        .fontWeight(.bold)
                        .foregroundColor(Color("bottom"))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding(.top,22)
                
                HStack(spacing: 12){
                    
                    Text("Don't have an account?")
                        .foregroundColor(Color.white.opacity(0.7))
                    
                    Button(action: {
                        showSignUP.toggle()
                        
                    }) {
                        
                        Text("Sign Up Now")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .padding(.top,25)
                
                Spacer(minLength: 0)
                
                Button(action: {
                    print("Forgot Password Clicked")
                }){
                    
                    Text("Forget Password?")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.vertical,22)
            }
            if showSignUP {
                withAnimation(.easeIn){
                    SignUpView(shopSignUp: $showSignUP)
                }
            }
        }
        .background(LinearGradient(gradient: .init(colors: [Color("top"),Color("bottom")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all))
        
    }
    
    func loginClicked(){
        status = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
