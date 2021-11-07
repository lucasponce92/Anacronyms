//
//  HomeView.swift
//  anacronysm
//
//  Created by Lucas Ponce on 06-11-21.
//

import SwiftUI
import ActivityIndicatorView
import AlertToast

struct HomeView: View {
    
    @State var text = String()
    @State private var resultsActive = false
    @StateObject var anacronymVM = AnacronymVM()
    
    var body: some View {
        
        NavigationView{
            ZStack{
                
                LinearGradient(gradient: Gradient(colors: [Color.hex("1CA7EC"), Color.hex("1F2F98")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                
                ScrollView{
                    VStack(spacing: 32){
                        
                        Image(systemName: "person.fill.questionmark")
                            .resizable()
                            .frame(width: 120, height: 100)
                            .foregroundColor(Color.black.opacity(0.4))
                            .padding(.top, 32)

                        
                        Text("Enter your anacronym here and find out the full form!")
                            .fontWeight(.bold)
                            .font(.system(.largeTitle, design: .rounded))
                            .foregroundColor(Color.hex("001833"))
                            .padding()
                        
                        CustomTextField(image: "abc", placeHolder: Text("Anacronym").foregroundColor(Color.black.opacity(0.4)), txt: $text)
                            .autocapitalization(.allCharacters)
                        
                        NavigationLink(destination: ResultsView(longForms: anacronymVM.longFormResults, shortForm: anacronymVM.shortForm), isActive: $resultsActive){ EmptyView() }
                            .frame(width:0,height: 0)
                            .opacity(0)
                        
                        Button(action: {
                            
                            if text.isEmpty {
                                anacronymVM.toastMsg = "Type an anacronym"
                                anacronymVM.showToast = true
                            }else if anacronymVM.validateText(text: text){
                                anacronymVM.activityIndicator = true
                                anacronymVM.longFormResults.removeAll()
                                anacronymVM.findLongForm(anacronym: text)
                            }
                            
                        }) {
                            Text("Find")
                                .font(.system(size: 22))
                                .fontWeight(.bold)
                                .foregroundColor(Color.hex("001833"))
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(Color.orange)
                                        .shadow(color: .black.opacity(0.6), radius: 2, x: 0, y: 2)
                            )
                            .padding()
                        }
                        
                        Spacer()
                            
                    }
                    .padding()
                }
                
                ActivityIndicatorView(isVisible: $anacronymVM.activityIndicator, type: .growingCircle)
                    .background(Color.black.opacity(0.5))
                    .ignoresSafeArea()
            }
            .onTapGesture { self.hideKeyboard() }
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
            .onChange(of: anacronymVM.longFormResults, perform: { value in
                if value.count > 0 {
                    anacronymVM.activityIndicator = false
                    resultsActive = true
                }
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .toast(isPresenting: $anacronymVM.showToast){
            AlertToast(type: .regular, title: anacronymVM.toastMsg)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
