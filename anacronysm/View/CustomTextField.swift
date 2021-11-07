//
//  CustomTextField.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import SwiftUI

struct CustomTextField: View {
    
    var image : String
    var placeHolder : Text
    @Binding var txt : String
    
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View{
        
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            
            ZStack{
                
                if txt.isEmpty { placeHolder.frame(maxWidth: .infinity, alignment: .leading) }
                TextField("", text: $txt, onEditingChanged: editingChanged, onCommit: commit)
                    .accentColor(.orange)
                    .foregroundColor(Color.hex("001833"))
                
            }
                .padding(.horizontal)
                .padding(.leading,80)
                .frame(height: 60)
                .background(Color.white.opacity(0.2))
                .clipShape(Capsule())
            
            Image(systemName: image)
                .font(.system(size: 24))
                .foregroundColor(Color.orange)
                .frame(width: 80, height: 80)
                .background(Color.hex("001833"))
                .clipShape(Circle())
        }
        .padding(.horizontal)
    }
}

