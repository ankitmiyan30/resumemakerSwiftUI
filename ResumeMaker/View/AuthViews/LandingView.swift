//
//  LandingView.swift
//  ResumeMaker
//
//  Created by Anthony Ankit on 13/10/20.
//

import SwiftUI

struct LandingView: View {
    @AppStorage("login_status") var status = true
    var body: some View {
        if status {
            DashBoardView()
        }else{
            LoginView()
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
