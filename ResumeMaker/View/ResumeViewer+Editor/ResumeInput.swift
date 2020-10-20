//
//  ResumeInput.swift
//  ResumeMaker
//
//  Created by Anthony Ankit on 15/10/20.
//

import SwiftUI
import PDFKit
struct ResumeInput: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var resume:ResumeFormatModel!
    @State var dataInputModel: [DataInputModel] = []
    @State var personeName = "Ankit Singh"
    @State var previewData = false
    @State var pdfData = Data()
    @State private var image: Image? = Image(systemName: "person.crop.circle.fill.badge.plus")
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    var pdfCreator = PDFCreator()
    var body: some View {
        
        ZStack {
            NavigationView {
                Text("")
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            NavigationLink("", destination: CreatedPDFViewer(documentData: pdfData), isActive: $previewData)
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
                            self.pdfData = pdfCreator.createFlyer(image: image!)
                            self.previewData.toggle()
                        }){
                            Image(systemName: "eye")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                    }
                    Text(resume.resumetype + " Edit")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding()
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 5, y: 5 )
                .background(Color.white.opacity(0.5).ignoresSafeArea(.all, edges: .all))
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    VStack {
                        VStack{
                            HStack{
                                Text("Enter You Name")
                                    .padding(.leading,4)
                                    .padding(.bottom, -8)
                                    .padding(.top, 4)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding(.horizontal)
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                Image(systemName: "doc.text.below.ecg")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color.black)
                                    .frame(width: 60, height: 60)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                TextField("", text: $personeName)
                                    .padding(.horizontal)
                                    .padding(.leading,65)
                                    .frame(height: 60)
                                    .background(Color.white.opacity(0.4))
                                    .clipShape(Capsule())
                                    .disableAutocorrection(true)
                            }
                            .padding(.horizontal)
                        }
                        image!
                            .resizable()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                            .onTapGesture { self.shouldPresentActionScheet = true }
                            .sheet(isPresented: $shouldPresentImagePicker) {
                                SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$image, isPresented: self.$shouldPresentImagePicker)
                            }.actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
                                ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                                    self.shouldPresentImagePicker = true
                                    self.shouldPresentCamera = true
                                }), ActionSheet.Button.default(Text("Photo Library"), action: {
                                    self.shouldPresentImagePicker = true
                                    self.shouldPresentCamera = false
                                }), ActionSheet.Button.cancel()])
                            }
                    }
                    
                })
            }
        }
        .ignoresSafeArea(.all, edges: .top)
        .edgesIgnoringSafeArea([.top, .bottom])
        .onAppear(){
            for i in 0..<20 {
                dataInputModel.append(DataInputModel(placeHolder: "PlaceHolder - \(i)", text: ""))
            }
        }
    }
}

struct ResumeInput_Previews: PreviewProvider {
    static var previews: some View {
        ResumeInput(resume: .constant(nil))
    }
}



//extension ResumeInput {
class PDFCreator {
    lazy var pageWidth : CGFloat  = {
        return 8.5 * 72.0
    }()
    
    lazy var pageHeight : CGFloat = {
        return 11 * 72.0
    }()
    
    lazy var pageRect : CGRect = {
        CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
    }()
    
    lazy var marginPoint : CGPoint = {
        return CGPoint(x: 10, y: 10)
    }()
    
    lazy var marginSize : CGSize = {
        return CGSize(width: self.marginPoint.x * 2 , height: self.marginPoint.y * 2)
    }()
    
    func createFlyer(image: Image) -> Data{
        var defaultX: CGFloat = 24
        var defaultY: CGFloat = 24
        var newXYValue:(CGFloat, CGFloat)!
        let pdfMetaData = [
            kCGPDFContextCreator: "Resume Builder",
            kCGPDFContextAuthor: "ankitmiyan30@gmail.com"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        let pageWidth = 8.5 * 71.0
        let pageHeight = 15 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = renderer.pdfData { (context) in
            context.beginPage()
            // Title of Resume
            newXYValue = addImage(image1: image, x: defaultX, y: defaultY)
            defaultX = newXYValue.0 + 230
            defaultY = newXYValue.1
            newXYValue = drawText(context: context, text: "Ankit Singh",index: 0, x: defaultX, y: defaultY)
            defaultX = newXYValue.0
            defaultY = newXYValue.1 + 60
            newXYValue = drawText(context: context, text: "Software Engineer" , index: 2, x: defaultX, y: defaultY)
            defaultX = newXYValue.0
            defaultY = newXYValue.1 + 80
            newXYValue = drawText(context: context, text: "Phone : +91.7507015366" , index: 1, x: defaultX, y: defaultY)
            defaultX = newXYValue.0
            defaultY = newXYValue.1 + 35
            newXYValue = drawText(context: context, text: "Email : xyz@gmail.com" , index: 1, x: defaultX, y: defaultY)
            defaultX = newXYValue.0
            defaultY = newXYValue.1 + 35
            newXYValue = drawText(context: context, text: "LinkedIN : Linked Profile" , index: 1, x: defaultX, y: defaultY)
            
            defaultX = newXYValue.0
            defaultY = newXYValue.1 + 80
            newXYValue = drawLine(x: defaultX, y: defaultY)
            defaultX = 24
            defaultY = newXYValue.1 + 20
            newXYValue = drawText(context: context, text: "WORK EXPERIENCE" , index: 4, x: defaultX, y: defaultY)
            defaultX = newXYValue.0 + 230
            defaultY = newXYValue.1
            newXYValue = drawText(context: context, text: "About ME" , index: 4, x: defaultX, y: defaultY)
            defaultX = 24
            defaultY = newXYValue.1 + 30
            newXYValue = drawText(context: context, text: "3 Years" , index: 1, x: defaultX, y: defaultY)
            defaultX = newXYValue.0 + 230
            defaultY = newXYValue.1
            newXYValue = drawText(context: context, text: "A software developer professional with an extensive experience of 2.5 years in iOS/ Android/ React-native development. Highly sincere and recognized as a result-oriented and work-focused individual." , index: 5, x: defaultX, y: defaultY)
            defaultX = 24
            defaultY = defaultY + 40
            newXYValue = drawText(context: context, text: "AGE" , index: 4, x: defaultX, y: defaultY)
            defaultX = 24
            defaultY = newXYValue.1 + 30
            newXYValue = drawText(context: context, text: "26" , index: 1, x: defaultX, y: defaultY)
            
            defaultY = newXYValue.1 + 65
            defaultX = pageRect.width / 2 - 36
            newXYValue = drawText(context: context, text: "Education" , index: 2, x: defaultX, y: defaultY)
            defaultX = 24
            defaultY = newXYValue.1 + 36
            newXYValue = drawLine(x: defaultX, y: defaultY)
            
            defaultX = 24
            defaultY = newXYValue.1 + 20
            newXYValue = drawText(context: context, text: "BCA", index: 6, x: defaultX, y: defaultY)
            
            defaultX = pageRect.width / 2 + 20
            defaultY = newXYValue.1
            newXYValue = drawText(context: context, text: "Graduated, July 2015", index: 6, x: defaultX, y: defaultY)
            
            defaultX = 24
            defaultY = newXYValue.1 + 20
            newXYValue = drawText(context: context, text: "Symbiosis Institute of Management", index: 1, x: defaultX, y: defaultY)
            
            defaultX = pageRect.width / 2 + 20
            defaultY = newXYValue.1
            newXYValue = drawText(context: context, text: "Marks 67%", index: 1, x: defaultX, y: defaultY)
            
            defaultX = 24
            defaultY = newXYValue.1 + 20
            newXYValue = drawText(context: context, text: "Studies, Pune, Maharastra", index: 1, x: defaultX, y: defaultY)
            
            defaultX = pageRect.width / 2  + 20
            defaultY = newXYValue.1
            newXYValue = drawText(context: context, text: "Division 2", index: 1, x: defaultX, y: defaultY)
            
            defaultX = 24
            defaultY = newXYValue.1 + 30
            newXYValue = drawText(context: context, text: "10+2", index: 6, x: defaultX, y: defaultY)
            
            defaultX = pageRect.width / 2  + 20
            defaultY = newXYValue.1
            newXYValue = drawText(context: context, text: "Completed, July 2012", index: 6, x: defaultX, y: defaultY)
            
            defaultX = 24
            defaultY = newXYValue.1 + 20
            newXYValue = drawText(context: context, text: "DPS, CBSE Board, New Delhi", index: 1, x: defaultX, y: defaultY)
            
            defaultX = pageRect.width / 2  + 20
            defaultY = newXYValue.1
            newXYValue = drawText(context: context, text: "Marks 57%", index: 1, x: defaultX, y: defaultY)
            
            defaultY = newXYValue.1 + 50
            defaultX = pageRect.width / 2 - 60
            newXYValue = drawText(context: context, text: "Career Highlights" , index: 2, x: defaultX, y: defaultY)
            defaultX = 24
            defaultY = newXYValue.1 + 36
            newXYValue = drawLine(x: defaultX, y: defaultY)
            defaultX = 24
            defaultY = newXYValue.1 + 20
            newXYValue = drawText(context: context, text: "A software developer professional with an extensive experience of 2.5 years in iOS/ Android/ React-native development. Highly sincere and recognized as a result-oriented and work-focused individual.", index: 7, x: defaultX, y: defaultY)
            
            defaultY = newXYValue.1 + 70
            defaultX = pageRect.width / 2 - 60
            newXYValue = drawText(context: context, text: "Work Experience" , index: 2, x: defaultX, y: defaultY)
            defaultX = 24
            defaultY = newXYValue.1 + 36
            newXYValue = drawLine(x: defaultX, y: defaultY)
            defaultX = 24
            defaultY = newXYValue.1 + 20
            newXYValue = drawText(context: context, text: "Jan 2018 - Sep 2020", index: 1, x: defaultX, y: defaultY)
            defaultX = 24
            defaultY = newXYValue.1 + 20
            newXYValue = drawText(context: context, text: "Software Engineer", index: 6, x: defaultX, y: defaultY)
            defaultX = 24
            defaultY = newXYValue.1 + 20
            newXYValue = drawText(context: context, text: "GS Lab, Pune, Maharastra", index: 1, x: defaultX, y: defaultY)
            defaultX = 24
            defaultY = newXYValue.1 + 30
            newXYValue = drawText(context: context, text: "Understand the requirements from Business/Functional Requirement documents. Design the development workflow and diagram. Test Strategy document and written manual test cases. Conducting walkthrough calls with Project Manager, Clients, and Application Development team.", index: 7, x: defaultX, y: defaultY)
            defaultX = 24
            defaultY = newXYValue.1 + 100
            newXYValue = drawText(context: context, text: "Place: Pune", index: 1, x: defaultX, y: defaultY)
            defaultX = 24 + 400
            defaultY = newXYValue.1
            newXYValue = drawText(context: context, text: "Ankit Singh", index: 6, x: defaultX, y: defaultY)
            
        }
        
        
        
        return data
    }
    
    
    func addImage(image1: Image, x: CGFloat, y: CGFloat) -> (CGFloat, CGFloat) {
        let image = image1.asUIImage()
//        let image =  UIImage(named: "profile")!
        let maxHeight = CGFloat(240.0)
        let maxWidth = CGFloat(200.0)
        let imageRect = CGRect(x: x, y: y, width: maxWidth, height: maxHeight)
        image.draw(in: imageRect)
        return (x , y)
    }
    func drawLine(x: CGFloat, y: CGFloat) -> (CGFloat, CGFloat) {
        let aPath = UIBezierPath()
        
        aPath.move(to: CGPoint(x: x, y: y))
        
        let pageWidth:CGFloat = 8.5 * 72.0 - 20
        aPath.addLine(to: CGPoint(x: pageWidth , y: y))
        aPath.close()
        UIColor.blue.set()
        aPath.lineWidth = 2
        aPath.stroke()
        
        return (x, y)
    }
    
    @discardableResult
    func drawText(context : UIGraphicsPDFRendererContext, text: String, index: Int, x: CGFloat, y: CGFloat) -> (CGFloat, CGFloat){
        //0 = Bold Big Title Text 1 = Normal Text 2 = Blue Link Text 3 = Bold Normal Text 4 = Blue Bold Text 5 = Paragraph Style
        if index == 0 {
            let attributes = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
            let text = text
            text.draw(at: CGPoint(x: x, y: y), withAttributes: attributes)
        }
        if index == 1 {
            let attributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
            let text = text
            text.draw(at: CGPoint(x: x, y: y), withAttributes: attributes)
        }
        if index == 2 {
            let attributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24),
                NSAttributedString.Key.foregroundColor: UIColor.blue
            ]
            let text = text
            text.draw(at: CGPoint(x: x, y: y), withAttributes: attributes)
        }
        if index == 3 {
            let attributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30),
                NSAttributedString.Key.foregroundColor: UIColor.blue
            ]
            let text = text
            text.draw(at: CGPoint(x: x, y: y), withAttributes: attributes)
        }
        if index == 4 {
            let attributes = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
                NSAttributedString.Key.foregroundColor: UIColor.blue
            ]
            let text = text
            text.draw(at: CGPoint(x: x, y: y), withAttributes: attributes)
        }
        if index == 5 {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .natural
            paragraphStyle.lineBreakMode = .byWordWrapping
            
            let attributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
            let attributedText = NSAttributedString(
                string: text,
                attributes: attributes
            )
            let pageWidth:CGFloat = 8.5 * 72.0 - 264
            let pageHeight:CGFloat = 11 * 72.0
            let height:CGFloat = (pageHeight - y - pageHeight / 5.0)
            let textRect = CGRect(
                x: x,
                y: y,
                width: pageWidth,
                height: height
            )
            attributedText.draw(in: textRect)
        }
        if index == 6 {
            let attributes = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
            let text = text
            text.draw(at: CGPoint(x: x, y: y), withAttributes: attributes)
        }
        if index == 7 {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .natural
            paragraphStyle.lineBreakMode = .byWordWrapping
            
            let attributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
            let attributedText = NSAttributedString(
                string: text,
                attributes: attributes
            )
            let pageWidth:CGFloat = 8.5 * 72.0 - 10
            let pageHeight:CGFloat = 11 * 72.0
            let height:CGFloat = (pageHeight)
            let textRect = CGRect(
                x: x,
                y: y,
                width: pageWidth,
                height: height
            )
            attributedText.draw(in: textRect)
        }
        return (x, y)
    }
    
    
    func drawPageNumber(_ pageNum: Int) {
        
        let theFont = UIFont.systemFont(ofSize: 20)
        
        let pageString = NSMutableAttributedString(string: "Page \(pageNum)")
        pageString.addAttribute(NSAttributedString.Key.font, value: theFont, range: NSRange(location: 0, length: pageString.length))
        
        let pageStringSize =  pageString.size()
        
        let stringRect = CGRect(x: (pageRect.width - pageStringSize.width) / 2.0,
                                y: pageRect.height - (pageStringSize.height) / 2.0 - 15,
                                width: pageStringSize.width,
                                height: pageStringSize.height)
        
        pageString.draw(in: stringRect)
        
    }
    
    func renderPage(_ pageNum: Int, withTextRange currentRange: CFRange) -> CFRange {
        var currentRange = currentRange
        // Get the graphics context.
        let currentContext = UIGraphicsGetCurrentContext()
        
        // Put the text matrix into a known state. This ensures
        // that no old scaling factors are left in place.
        currentContext?.textMatrix = .identity
        
        // Create a path object to enclose the text. Use 72 point
        // margins all around the text.
        let frameRect = CGRect(x: self.marginPoint.x, y: self.marginPoint.y, width: self.pageWidth - self.marginSize.width, height: self.pageHeight - self.marginSize.height)
        let framePath = CGMutablePath()
        framePath.addRect(frameRect, transform: .identity)
        
        // Get the frame that will do the rendering.
        // The currentRange variable specifies only the starting point. The framesetter
        // lays out as much text as will fit into the frame.
        //        let frameRef = CTFramesetterCreateFrame(framesetter!, currentRange, framePath, nil)
        
        // Core Text draws from the bottom-left corner up, so flip
        // the current transform prior to drawing.
        currentContext?.translateBy(x: 0, y: self.pageHeight)
        currentContext?.scaleBy(x: 1.0, y: -1.0)
        
        // Draw the frame.
        //        CTFrameDraw(frameRef, currentContext!)
        
        // Update the current range based on what was drawn.
        //        currentRange = CTFrameGetVisibleStringRange(frameRef)
        currentRange.location += currentRange.length
        currentRange.length = CFIndex(0)
        
        return currentRange
    }
}

extension View {
// This function changes our View to UIView, then calls another function
// to convert the newly-made UIView to a UIImage.
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
// here is the call to the function that converts UIView to UIImage: `.asImage()`
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {
// This is the function to convert UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
