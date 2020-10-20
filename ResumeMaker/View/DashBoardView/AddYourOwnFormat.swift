//
//  AddYourOwnFormat.swift
//  ResumeMaker
//
//  Created by Anthony Ankit on 15/10/20.
//

import SwiftUI

struct AddYourOwnFormat: View {
    var body: some View {
        VStack {
            HStack{
                Spacer()
            }
            Spacer()
            Button(action: {
                
            }){
                Image(systemName: "link")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .shadow(radius: 10)
                    .foregroundColor(.white)
            }
            Spacer()
        }
    }
}

struct AddYourOwnFormat_Previews: PreviewProvider {
    static var previews: some View {
        AddYourOwnFormat()
    }
}
