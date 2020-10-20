//
//  DataInputCell.swift
//  ResumeMaker
//
//  Created by Anthony Ankit on 15/10/20.
//

import SwiftUI

struct DataInputCell: View {
//    @Binding var text:String
//    @Binding var placeHolder: String
    @State var text = ""
    @State var dataInputModel: DataInputModel
    var body: some View {
        VStack{
            HStack{
                Text(dataInputModel.placeHolder)
                    .padding(.leading,4)
                    .padding(.bottom, -8)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.horizontal)
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                Image(systemName: "doc.text.below.ecg")
                    .font(.system(size: 24))
                    .foregroundColor(Color("bottom"))
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
                TextField("", text: $text)
                    .padding(.horizontal)
                    .padding(.leading,65)
                    .frame(height: 60)
                    .background(Color.white.opacity(0.4))
                    .clipShape(Capsule())
                    .disableAutocorrection(true)
            }
            .padding(.horizontal)
        }
    }
}

//struct DataInputCell_Previews: PreviewProvider {
//    static var previews: some View {
//        DataInputCell()
//    }
//}
