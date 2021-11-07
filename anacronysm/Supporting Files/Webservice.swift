//
//  Webservice.swift
//  anacronysm
//
//  Created by Lucas Ponce on 06-11-21.
//

import Foundation

class Webservice{
    
    class func invoke(urlPath: String, parameters: [String: String], httpMethod: String, finished: @escaping (_ isSuccess: Data?, Bool, String?)-> Void) {
        
        var components = URLComponents(string: urlPath)!
        
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            
        var request = URLRequest(url: components.url!)
        request.httpMethod = httpMethod
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            do {
                if let httpResponse = response as? HTTPURLResponse {
                    
                    if httpResponse.statusCode == HttpStatus.ok.rawValue {
                        
                        /*guard let readableJson = try JSONSerialization.jsonObject(with: data ?? Data(), options:[]) as? NSDictionary else {
                            return
                        }
                        
                        print(readableJson)*/
                        
                        finished (data!, true, nil)
                    }
                    
                    if httpResponse.statusCode == HttpStatus.created.rawValue { finished (data!, true, nil) }
                    
                    if httpResponse.statusCode == HttpStatus.noContent.rawValue { finished (nil, true, nil) }
                    
                    if httpResponse.statusCode == HttpStatus.movedPermanently.rawValue { finished (nil, false, "Se debe actualizar la aplicación") }
                    
                    if httpResponse.statusCode == HttpStatus.badRequest.rawValue { finished (data!, false, "Debes completar todos los campos") }
                    
                    if httpResponse.statusCode == HttpStatus.unauthorized.rawValue { finished (nil, false, "Tu sesión ha expirado") }
                    
                    if httpResponse.statusCode == HttpStatus.forbidden.rawValue { finished (nil, false, "No tienes los permisos para realizar esta operación") }
                    
                    if httpResponse.statusCode == HttpStatus.notFound.rawValue { finished (nil, false, "URL no encontrada") }
                    
                    if httpResponse.statusCode == HttpStatus.unsupportedMediaType.rawValue { finished (nil, false, "Se debe actualizar la aplicación") }
                    
                    if httpResponse.statusCode == HttpStatus.internalServerError.rawValue { finished (nil, false, "Ha ocurrido un problema al procesar tu solicitud. Vuelve a intentarlo más tarde") }
                    
                    if httpResponse.statusCode == HttpStatus.badGateway.rawValue { finished (nil, false, "Ha ocurrido un problema al procesar tu solicitud. Vuelve a intentarlo más tarde") }
                    
                    if httpResponse.statusCode == HttpStatus.gatewayTimeout.rawValue { finished (nil, false, "No ha sido posible obtener la información, intenta nuevamente") }
                }
            }
        }.resume()
    }
}
