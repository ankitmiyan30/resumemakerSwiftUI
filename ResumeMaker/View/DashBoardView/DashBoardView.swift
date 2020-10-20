//
//  DashBoardView.swift
//  ResumeMaker
//
//  Created by Anthony Ankit on 13/10/20.
//

import SwiftUI

struct DashBoardView: View {
    @State var userName = "John Doe"
    @State var showDrawer = false
    @State var launch = false
    @ObservedObject var resumeViewModel = ResumeViewModel()
    @State var resume: ResumeFormatModel!
    @State var screenIndex = 0
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink("", destination: ResumePreview(resume: $resume), isActive: $launch).hidden()
                LinearGradient(gradient: .init(colors: [Color("top"),Color("bottom")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all)
                VStack(spacing: 0){
                    ZStack {
                        HStack {
                            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                            Button(action:{
                                self.showDrawer.toggle()
                            }){
                                Image(systemName: "line.horizontal.3.circle")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                        }
                        Text("1PageResume")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 5, y: 5 )
                    .background(Color.white.opacity(0.5).ignoresSafeArea(.all, edges: .all))
                    if screenIndex == 0 {
                        ScrollView(.vertical, showsIndicators: false, content:  {
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 15), count: 2),spacing: 15){
                                ForEach(resumeViewModel.resumes){ resumeObj in
                                    GridCardView(data: resumeObj)
                                        .onTapGesture {
                                            resume = resumeObj
                                            self.launch.toggle()
                                        }
                                }
                            }
                            .padding(.vertical, 10)
                            
                        })
                    }
                    if screenIndex == 1 {
                        Spacer(minLength: 0)
                        MyResumeView()
                    }
                    
                    if screenIndex == 2 {
                        Spacer(minLength: 0)
                        LatestResumeFormats()
                    }
                    
                    if screenIndex == 3 {
                        Spacer(minLength: 0)
                        AddYourOwnFormat()
                    }
                    
                    //                    })
                }
                MenuView(showDrawer: $showDrawer, screenIndex: $screenIndex)
            }
            .ignoresSafeArea(.all, edges: .top)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea([.top, .bottom])
            .onAppear(){
                self.resumeViewModel.getListofResume()
            }
        }
    }
}

struct DashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardView()
    }
}


