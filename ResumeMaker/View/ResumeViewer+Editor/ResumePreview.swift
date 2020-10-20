//
//  ResumePreview.swift
//  ResumeMaker
//
//  Created by Anthony Ankit on 14/10/20.
//

import SwiftUI
import PDFKit
struct ResumePreview: View {
    @State var editResume = false
    @Binding var resume:ResumeFormatModel!
    @State private var showPreview = true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    public var documentData = Data()
    var body: some View {
        ZStack {
            NavigationView {
                Text("")
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            NavigationLink("", destination: ResumeInput(resume: $resume), isActive: $editResume)
            LinearGradient(gradient: .init(colors: [Color("top"),Color("bottom")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 0){
                ZStack {
                    HStack {
                        Button(action:{
                            withAnimation(.easeOut){
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }){
                            Image(systemName: "chevron.backward.circle")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                        Button(action:{
                            self.editResume.toggle()
                        }){
                            Image(systemName: "pencil.circle")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                    }
                    Text(resume.resumetype)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding()
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 5, y: 5 )
                .background(Color.white.opacity(0.5).ignoresSafeArea(.all, edges: .all))
                
                PDFKitRepresentedView(Bundle.main.url(forResource: resume.resumeview, withExtension: "pdf")!, 0, documentData)
                    .padding(.vertical)
                    .padding(.horizontal, 4)
//                WebViewRepresentedView(request: openPdf(pdfName: resume.resumeview))
//                    .padding(.vertical)
//                    .padding(.horizontal, 4)
                
//                DocumentPreview($showPreview, url: Bundle.main.url(forResource: resume.resumeview, withExtension: "pdf")!)
            }
            
        }
        .ignoresSafeArea(.all, edges: .top)
        .edgesIgnoringSafeArea([.top, .bottom])
    }
    
    
    func openPdf(pdfName: String) -> URLRequest {
        let url = Bundle.main.url(forResource: resume.resumeview, withExtension: "pdf")!
        return URLRequest(url: url)
    }
    
    
    
}

//struct ResumePreview_Previews: PreviewProvider {
//    static var previews: some View {
//        ResumePreview()
//    }
//}
