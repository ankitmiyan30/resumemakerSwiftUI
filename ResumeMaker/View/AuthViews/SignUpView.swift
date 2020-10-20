//
//  SignUpView.swift
//  ResumeMaker
//
//  Created by Anthony Ankit on 13/10/20.
//

import SwiftUI

struct SignUpView : View {
    @State var email = ""
    @State var password = ""
    @State var rePassword = ""
    @Binding var shopSignUp: Bool
    
    var body: some View{
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
            
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
                    
                    HStack(spacing: 0){
                        
                        Text("New Profile")
                            .font(.system(size: 35, weight: .heavy))
                            .foregroundColor(.white)
                        
                    }
                    
                    Text("Open a new account")
                        .foregroundColor(Color.black.opacity(0.3))
                        .fontWeight(.heavy)
                }
                .padding(.top)
                
                VStack(spacing: 20){
                    
                    CustomTextField(image: "person", placeHolder: "Email", txt: $email)
                    
                    CustomTextField(image: "lock", placeHolder: "Password", txt: $password)
                    
                    CustomTextField(image: "lock", placeHolder: "Re-Enter", txt: $rePassword)
                }
                .padding(.top)
                
                Button(action:{
                    
                }){
                    
                    Text("SIGNUP")
                        .fontWeight(.bold)
                        .foregroundColor(Color("bottom"))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding(.vertical,22)
                
                Spacer(minLength: 0)
            }
            
            Button(action: {
                shopSignUp.toggle()
            }) {
                
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .clipShape(Circle())
            }
            .padding(.trailing)
            .padding(.top,10)
        })
        .background(LinearGradient(gradient: .init(colors: [Color("top"),Color("bottom")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all))
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(shopSignUp: .constant(false))
    }
}
