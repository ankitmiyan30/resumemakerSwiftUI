//
//  ResumeFormatViewModel.swift
//  ResumeMaker
//
//  Created by Anthony Ankit on 14/10/20.
//

import SwiftUI

class ResumeViewModel: ObservableObject {
    
    @Published var resumes: [ResumeFormatModel] = []
    @Published var Grid: [Int] = []
    
    func getListofResume(){
        resumes = []
        let resumepic = ["sample-smart-and-balanced-resume"]//, "sample-corporate-resume", "sample-lean-and-cool-resume", "sample-the-seeker-resume", "sample-smartandsecure-resume"]
        let resumetype = ["Smart and Balanced"]//, "Corporate", "Lean and Cool", "The Seeker", "Smartandsecure Resume"]
        for index in 0..<resumetype.count {
            let number = Int.random(in: 0...10)
            let rating = Int.random(in: 1...5)
            Grid.append(index)
            resumes.append(ResumeFormatModel(rid: "\(number)", resumetype: resumetype[index], rating: rating, resumeview: resumepic[index]))
            
        }
    }
}
