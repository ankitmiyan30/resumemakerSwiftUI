//
//  GridCardView.swift
//  ResumeMaker
//
//  Created by Anthony Ankit on 14/10/20.
//

import SwiftUI

struct GridCardView: View {
    var data : ResumeFormatModel
    
    var body: some View {
        VStack {
            Text(data.resumetype)
                .padding(.vertical, 4)
                .font(.system(size: 18, weight: .bold))
            Image(data.resumeview)
                .resizable()
                .frame(width: (UIScreen.main.bounds.width - 80) / 2, height: 250)
                .background(Color.white)
                .cornerRadius(12)
            HStack {
                ForEach(0..<5) { i in
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(data.rating >= i ? .yellow : .white)
                }
            }
            .padding(.vertical, 4)

            Button(action: {
                
            }) {
                HStack {
                    Image(systemName: "eye")
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                    Text("Preview")
                        .foregroundColor(.white)
                        
                        .padding(.vertical,10)
                }
                .frame(width: (UIScreen.main.bounds.width - 90) / 2)
                
                
            }.background(Color.red)
            .cornerRadius(10)
            .shadow(radius: 6)
            
        }
    }
}

//struct GridCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        GridCardView()
//    }
//}
