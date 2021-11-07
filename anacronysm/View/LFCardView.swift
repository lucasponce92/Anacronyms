//
//  ResultCardView.swift
//  anacronyms
//
//  Created by Lucas Ponce on 06-11-21.
//

import SwiftUI

struct LFCardView: View {
    
    var longForm: LongForm
    var shortForm: String
    @StateObject var lfCardVM = LFCardVM()
    @State private var variantsActive = false
    
    var body: some View {
        
        ZStack {
            
            VStack(alignment: .leading, spacing: 1.0) {
                
                HStack{
                    Spacer()
                    
                    Text("SF: \(shortForm)")
                        .fontWeight(.semibold)
                        .font(.subheadline).italic()
                        .foregroundColor(Color.hex("001833"))
                        .italic()
                }
                .padding(.top).padding(.trailing)
                
                VStack(alignment: .leading, spacing:2){
                    
                    HStack{
                        Text("Full form:")
                            .fontWeight(.semibold)
                            .font(.system(.title3, design: .rounded))
                            .foregroundColor(Color.hex("001833"))
                        
                        Text("\(longForm.lf)")
                            .fontWeight(.heavy)
                            .font(.system(.title3, design: .rounded))
                            .foregroundColor(Color.hex("001833"))
                    }
                    
                    Text("Frequency: \(longForm.freq)")
                        .fontWeight(.semibold)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(Color.hex("001833"))
                    
                    
                    Text("Since: \(longForm.since)")
                    .fontWeight(.semibold)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(Color.hex("001833"))
                    
                    NavigationLink(destination: VariantsView(longForms: longForm.vars!), isActive: $variantsActive){ EmptyView() }
                        .frame(width:0,height: 0)
                        .opacity(0)
                    
                    Button(action: {
                        self.variantsActive = true
                    }) {
                        
                        HStack{
                            
                            Text(lfCardVM.getButtonTitle(vars: longForm.vars))
                            .fontWeight(.semibold)
                            .font(.system(.subheadline, design: .rounded))
                                .foregroundColor((longForm.vars != nil && longForm.vars!.count > 1) ? Color.hex("EB5838") : Color.hex("001833"))
                            
                            if longForm.vars != nil && longForm.vars!.count > 1{
                                Image(systemName: "arrow.right")
                                    .font(.title2)
                                    .foregroundColor(Color.hex("EB5838"))
                            }
                        }
                    }
                }
                .padding()
                
            }
            .background(Color.white.opacity(0.6))
        }
    }
}

struct ResultCardView_Previews: PreviewProvider {
    static var previews: some View {
        
        LFCardView(longForm: LongForm(lf: "herba life", freq: 200, since: "", vars: []), shortForm: "HMM")
    }
}
