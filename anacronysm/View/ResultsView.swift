//
//  ResultsView.swift
//  anacronysm
//
//  Created by Lucas Ponce on 06-11-21.
//

import SwiftUI

struct ResultsView: View {
    
    @Environment(\.presentationMode) var present
    var longForms: [LongForm]
    var shortForm: String
    
    var body: some View {
        
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [Color.hex("1CA7EC"), Color.hex("1F2F98")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            VStack(spacing: 8){
                
                HStack{
                    
                    Button(action: {present.wrappedValue.dismiss()}){
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.black)
                    }.padding(.leading, 16).padding(.top, 32)
                    
                    Spacer()
                }
                
                Text("Showing \(longForms.count) found results for \"\(shortForm)\"")
                    .fontWeight(.bold)
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(Color.hex("001833"))
                    .padding()
                
                ScrollView{
                    
                    ForEach(longForms, id: \.self.lf){ longForm in
                        
                        LFCardView(longForm: longForm, shortForm: shortForm)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .listRowInsets(EdgeInsets())
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.3), radius: 3, x:0, y:3)
                            .padding(.vertical, 5.0).padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(longForms: [], shortForm: "")
    }
}
