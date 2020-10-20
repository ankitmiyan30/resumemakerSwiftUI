//
//  MenuView.swift
//  ResumeMaker
//
//  Created by Anthony Ankit on 14/10/20.
//

import SwiftUI

var drawerMenuText = ["Home", "My Resume", "Latest Formats", "Add Own"]
var drawerMenuImage:[String] = ["ic_home",  "ic_my_resume", "ic_latest", "ic_addown"]

struct MenuView: View {
    @Binding var showDrawer: Bool
    @Binding var screenIndex: Int
    @AppStorage("login_status") var status = true
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    status.toggle()
                }){
                    VStack{
                        Image("ic_logout")
                            .resizable()
                            .frame(width: 32, height: 32)
                        Text("LogOut")
                            .font(.system(size: 10, weight: .regular))
                            .foregroundColor(.white)
                    }
                }
                
                ZStack {
                    Image("profile")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .padding(.horizontal, 24)
                    Circle()
                        .stroke(Color("top"))
                        .frame(width: 70, height: 70)
                        .offset(x: -2, y: -1)
                    Circle()
                        .stroke(Color("bottom"))
                        .frame(width: 70, height: 70)
                        .offset(x: 2, y: 1)
                    
                }
                Button(action: {
                    print("Edit Profile Launch")
                }){
                    VStack {
                        Image(systemName: "pencil")
                            .font(.system(size: 24, weight: .heavy))
                            .frame(width: 32, height: 32)
                            .foregroundColor(.white)
                        Text("Edit")
                            .font(.system(size: 10, weight: .regular))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.top, 30)
            Text("Ankit Singh")
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .bold))
            Text("ankitmiyan30@gmail.com")
                .foregroundColor(.white)
                .font(.system(size: 18))
                .padding(.top, 2)
            ForEach(drawerMenuText.indices){ index in
                if index != drawerMenuImage.count  {
//                    if index == 0 {
                    MenuRow(rowActive: index == screenIndex ? true : false, rowText: drawerMenuText[index], rowIcon: drawerMenuImage[index], menuItemIndex: index, showDrawer: $showDrawer, screenIndex: $screenIndex)
//                    } else {
//                        MenuRow(rowActive: false, rowText: drawerMenuText[index], rowIcon: drawerMenuImage[index], showDrawer: $showDrawer)
//                    }
                }
            }
            .padding(.vertical, 10)
            Spacer()
            HStack {
                Spacer()
                Text("Version: 1.0.0")
                    .padding(.trailing, 12)
                    .padding(.bottom, 30)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color.white.opacity(0.6))
            }
        }
        .background(LinearGradient(gradient: .init(colors: [Color("top"),Color("bottom")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all))
        .padding(.top, 30)
        .padding(.trailing, 80)
        .offset(x: showDrawer ? 0 : -UIScreen.main.bounds.width)
        .ignoresSafeArea(.all, edges: .top)
        .animation(.default)
//        .rotation3DEffect(
//            Angle(degrees: showDrawer ? 0 : 10),
//            axis: (x: 0, y: 20, z: 0))
        .gesture(
                DragGesture(minimumDistance: 100)
                    .onEnded { _ in
                        self.showDrawer.toggle()
                    }
        )
    }
}

