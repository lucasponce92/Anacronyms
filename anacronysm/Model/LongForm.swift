//
//  LongForm.swift
//  anacronysm
//
//  Created by Lucas Ponce on 06-11-21.
//

import Foundation

struct LongForms: Codable {
    var sf : String
    var lfs : [LongForm]
    
    init() {
        self.sf = ""
        self.lfs = []
    }

    enum CodingKeys: CodingKey {
        case sf, lfs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        sf = try container.decode(String.self, forKey: .sf)
        lfs = try container.decode([LongForm].self, forKey: .lfs)
    }
}

struct LongForm: Codable, Equatable {
    
    var lf : String
    var freq: Int
    var since : String
    var vars : [LongForm]?
    
    init(lf:String, freq:Int, since:String, vars: [LongForm]) {
        self.lf = lf
        self.freq = freq
        self.since = since
        self.vars = vars
    }
    
    init(){
        self.init(lf:"", freq: 0, since:"", vars:[])
    }
    
    enum CodingKeys: CodingKey {
        case lf, freq, since, vars
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(lf, forKey: .lf)
        try container.encode(freq, forKey: .freq)
        try container.encode(since, forKey: .since)
        try container.encode(vars, forKey: .vars)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        lf = try container.decode(String.self, forKey: .lf)
        freq = try container.decode(Int.self, forKey: .freq)
        let s = try container.decode(Int.self, forKey: .since)
        
        let formatter = NumberFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale  // locale determines the decimal point (. or ,); English locale has "."
        formatter.groupingSeparator = ""  // you will never get thousands separator as output
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.numberStyle = .decimal
        since = formatter.string(from: s as NSNumber)!
        
        if let v = try? container.decode([LongForm].self, forKey: .vars) { vars = v }
    }
}
