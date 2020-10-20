//
//  MenuRow.swift
//  ResumeMaker
//
//  Created by Anthony Ankit on 14/10/20.
//

import SwiftUI

struct MenuRow: View {
    var rowActive: Bool
    var rowText = ""
    var rowIcon = ""
    var menuItemIndex:Int
    @Binding var showDrawer: Bool
    @Binding var screenIndex: Int
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(rowActive ? (menuItemIndex == 0 ? "ic_home1" : rowIcon) : rowIcon)
                .foregroundColor(rowActive ? Color("top") : .white)
                .frame(width: 24, height: 24)
                .font(.system(size: 15, weight: rowActive ? .bold : .regular))
            Text(rowText)
                .padding(.leading)
                .foregroundColor(rowActive ? Color("top") : .white)
                .foregroundColor(.white)
                .offset(y: -6)
            Spacer()
        }
        .accentColor(rowActive ? Color("top") : .white)
        .padding(4)
        .background(rowActive ? Color.white : Color.white.opacity(0.0))
        .padding(.trailing, 20)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .offset(x: 22)
        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
            self.menutItemClick(rowText: rowText, tappedIndex: menuItemIndex)
        })
        
    }
    
    func menutItemClick(rowText: String, tappedIndex: Int){
        screenIndex = tappedIndex
        showDrawer.toggle()
    }
}
