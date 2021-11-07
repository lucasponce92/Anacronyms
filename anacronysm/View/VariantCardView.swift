//
//  VariantCardView.swift
//  anacronyms
//
//  Created by Lucas Ponce on 07-11-21.
//

import SwiftUI

struct VariantCardView: View {
    
    var longForm: LongForm
    @StateObject var lfCardVM = LFCardVM()
    
    var body: some View {
        
        ZStack {
            
            HStack{
                
                VStack(alignment: .leading, spacing: 2) {
                    
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
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading )
                .padding()
                .background(Color.white.opacity(0.6))
            }
        }
    }
}

struct VariantCardView_Previews: PreviewProvider {
    static var previews: some View {
        VariantCardView(longForm: LongForm())
    }
}
