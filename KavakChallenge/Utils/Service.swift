//
//  ServiceViewModel.swift
//  KavakChallenge
//
//  Created by Pablo Ramirez on 6/25/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import Foundation

public class Service{
    
    public var onSuccessKavakService:((_ response: Gnome) -> ())?
    public var onServiceError: ((_ error: ServiceError)->())?
    
    private let manager = ServiceManager()

    public func performKavakService(){
        
        manager.performKavakService(completion: { ( _ error:
            ServiceError ,_ response: Gnome?) in
            
            if let response = response {
                
                self.onSuccessKavakService?(response)
            }else {
                
                self.onServiceError?(error)
            }
        })
    }
    
}
