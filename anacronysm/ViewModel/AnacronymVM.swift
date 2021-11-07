//
//  AnacronymVM.swift
//  anacronysm
//
//  Created by Lucas Ponce on 06-11-21.
//

import Foundation

class AnacronymVM: ObservableObject {
    
    @Published var longFormResults = [LongForm]()
    @Published var shortForm = String()
    @Published var showToast = false
    @Published var toastMsg = String()
    @Published var activityIndicator = false
    
    func findLongForm(anacronym: String){
        
        Webservice.invoke(urlPath: Endpoints.getLfs(), parameters: ["sf":anacronym], httpMethod: HttpMethod.GET, finished: { data, status, msg in
            if status && data != nil {
                
                let decodeLfs = try! JSONDecoder().decode([LongForms].self, from: data! )
                
                if decodeLfs.count > 0 {
                    DispatchQueue.main.async {
                        self.longFormResults = decodeLfs[0].lfs
                        self.shortForm = decodeLfs[0].sf
                    }
                }else{
                    self.showMsg()
                }
            }else{
                self.showMsg()
            }
        })
    }
    
    func showMsg(){
        
        DispatchQueue.main.async {
            self.toastMsg = "Not results found"
            self.showToast.toggle()
            self.activityIndicator = false
        }
    }
    
    func validateText(text: String) -> Bool {
        
        var allowed = false
        
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
            
            if regex.firstMatch(in: text, options: [], range: NSMakeRange(0, text.count)) != nil{
                self.toastMsg = "Anacronym must not contain numbers or symbols"
                self.showToast.toggle()

            }else {
                allowed = true
            }
        }
        catch {
            self.toastMsg = "Unable to continue: format error"
            self.showToast.toggle()
            
        }
        
        return allowed
    }
}
