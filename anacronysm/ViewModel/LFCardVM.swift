//
//  LFCardVM.swift
//  anacronyms
//
//  Created by Lucas Ponce on 07-11-21.
//

import Foundation

class LFCardVM: ObservableObject {
    
    func getButtonTitle(vars: [LongForm]?) -> String{
        
        if vars != nil && vars!.count < 2 {
            return "There are no other variants to show"
        }else{
            return "Tap to see \(vars!.count) more variants"
        }
    }
}
