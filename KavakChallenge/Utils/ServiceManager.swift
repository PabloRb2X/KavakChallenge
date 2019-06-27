//
//  ServiceManager.swift
//  KavakChallenge
//
//  Created by Pablo Ramirez on 6/25/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

public class ServiceManager{
    
    func performKavakService(completion: @escaping (_ error:
        ServiceError, _ responseModel: Gnome?) -> Void) {
        
        let urlrequest = "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json"
        
        //let model = RequestModel(.......)
        let body = ""//Mapper().toJSONString(model) ?? ""
        
        ServiceUtils.defaultManager.request(ServiceUtils.createRequest(urlString: urlrequest, body: body)).responseJSON { (response) in
            
            print(response.result.value ?? "")
            var serviceError = ServiceError()
            
            if let error = response.result.error as? AFError {
                serviceError = ServiceError(httpCode: response.response?.statusCode ?? 0, exception:error.localizedDescription, message:error.errorDescription ?? "", cveDiagnostic: "")
            }
            
            if response.result.isSuccess {
                if let value = response.result.value as? [String:Any] {
                    if let resp = Mapper<Gnome>().map(JSONObject: value) {
                        
                        completion(serviceError, resp)
                    }
                    else {
                        serviceError.message = "Ocurrio un error al convertir JSON"
                        completion(serviceError , nil)
                    }
                }
            }
            else {
                completion(serviceError, nil)
            }
            
        }
    }
}
