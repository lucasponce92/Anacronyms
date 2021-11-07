//
//  Endpoints.swift
//  anacronysm
//
//  Created by Lucas Ponce on 06-11-21.
//

import Foundation

class Endpoints {
    
    static var urlPath = "http://www.nactem.ac.uk/software/acromine/dictionary.py"
    
    class func getLfs() -> String {
        
        return urlPath
    }
}
