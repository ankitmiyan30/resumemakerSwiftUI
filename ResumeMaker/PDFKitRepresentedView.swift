//
//  PDFKitRepresentedView.swift
//  ResumeMaker
//
//  Created by Anthony Ankit on 15/10/20.
//
import SwiftUI
import PDFKit

struct PDFKitRepresentedView: UIViewRepresentable {
    let url: URL
    let key: Int
    let data: Data
    
    init(_ url: URL, _ key: Int, _ data: Data) {
        self.url = url
        self.key = key
        self.data = data
    }

    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        let pdfView = PDFView()
        if key == 0 {
            pdfView.document = PDFDocument(url: self.url)
        } else {
            pdfView.document = PDFDocument(data: data)
        }
        
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.layer.cornerRadius = 8
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
        // Update the view.
    }
}
