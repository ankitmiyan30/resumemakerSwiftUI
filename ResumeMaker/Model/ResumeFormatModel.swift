//
//  PdfModel.swift
//  ResumeMaker
//
//  Created by Anthony Ankit on 14/10/20.
//

import SwiftUI

struct ResumeFormatModel : Identifiable, Decodable {
    let id = UUID()
    let rid: String
    let resumetype: String
    var rating: Int
    let resumeview: String
}
