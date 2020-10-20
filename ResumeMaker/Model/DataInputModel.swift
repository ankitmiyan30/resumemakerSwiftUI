//
//  DataInputModel.swift
//  ResumeMaker
//
//  Created by Anthony Ankit on 15/10/20.
//

import Foundation

struct DataInputModel : Identifiable, Decodable {
    let id = UUID()
    var placeHolder: String
    var text: String
}
