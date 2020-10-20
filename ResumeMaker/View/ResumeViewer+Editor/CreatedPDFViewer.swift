//
//  CreatedPDFViewer.swift
//  ResumeMaker
//
//  Created by Anthony Ankit on 15/10/20.
//
import SwiftUI
import PDFKit
struct CreatedPDFViewer: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var share = false
    public var documentData: Data
    var body: some View {
        ZStack {
            NavigationView {
                Text("")
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            LinearGradient(gradient: .init(colors: [Color("top"),Color("bottom")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all)
//            if share{
//                ActivityViewController(text: documentData, showing: $share)
//                                    .frame(width: 0, height: 0)
//            }
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
                            share.toggle()
                        }){
                            Image("ic_share")
                                .font(.title)
                                .foregroundColor(.white)
                        }.sheet(isPresented: $share, content: { ActivityView(activityItems: [documentData], applicationActivities: []) })
                    }
                    Text("Preivew")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding()
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 5, y: 5 )
                .background(Color.white.opacity(0.5).ignoresSafeArea(.all, edges: .all))
                PDFKitRepresentedView(Bundle.main.url(forResource: "sample-smartandsecure-resume", withExtension: "pdf")!, 1, documentData)
                    .padding(.vertical)
                    .padding(.horizontal, 4)
            }
            
        }
        .ignoresSafeArea(.all, edges: .top)
        .edgesIgnoringSafeArea([.top, .bottom])
    }
}

struct ActivityView: UIViewControllerRepresentable {

    let activityItems: [Any]
    let applicationActivities: [UIActivity]?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems,
                                        applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: UIViewControllerRepresentableContext<ActivityView>) {

    }
}
