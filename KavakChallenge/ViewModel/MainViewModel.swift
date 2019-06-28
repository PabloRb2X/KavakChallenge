//
//  MainViewModel.swift
//  KavakChallenge
//
//  Created by Pablo Ramirez on 6/26/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import Foundation
import UIKit

protocol MainProtocol {
    func didStartService()
    func didSuccessService(isLoadData: Bool)
    func didErrorService()
}

class MainViewModel{
    
    let service: Service = Service()
    var mainDelegate: MainProtocol?
    
    var gnomes: Gnome = Gnome()
    var filter: [Brastlewark] = []
    var images: [UIImage]? = []
    
    var selectedBrastlewark: Brastlewark!
    var selectedImage: UIImage!
    
    init() {
        
    }
    
    func getGnomesTown(isLoadData: Bool){
        
        if !isLoadData{
            mainDelegate?.didStartService()
            
            service.performKavakService()
            service.onSuccessKavakService = {(_ response: Gnome) -> Void in
                
                print("response = ", response)
                self.gnomes = response
                
                self.mainDelegate?.didSuccessService(isLoadData: true)
            }
            service.onServiceError = {(_ error: ServiceError)  -> Void in
                
                print("Error en el servicio: ", error)
                self.mainDelegate?.didErrorService()
            }
        }
        else{
            self.mainDelegate?.didSuccessService(isLoadData: true)
        }
        
    }
    
    func filterResults(text: String){
        filter = gnomes.brastlewark.filter{
            $0.name.contains(text)
        }
    }
    
    func emptyFilter(){
        
        filter.removeAll()
    }
}

//        let jsonUrlString = "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json"
//
//        guard let url = URL(string: jsonUrlString) else{
//            print("Error en el servicio")
//
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            /// validar si hay error
//            if let error = error{
//                print("ocurrió un error: ", error)
//                return
//            }
//
/// checar el status 200 OK
//            if let httpResponse = response as? HTTPURLResponse{
//                if httpResponse.statusCode == 400{
//                    print("Error")
//                    return
//                }
//            }
//
//            guard let data = data else { return }
//
//            do{
//                let gnomes = try JSONDecoder().decode([Gnome].self, from: data)
//
//                print(gnomes)
//                self.gnomes = gnomes
//            }catch let jsopErr{
//
//                print("error serializing json object:", jsopErr)
//            }
//        }.resume()
