//
//  MainViewModel.swift
//  KavakChallenge
//
//  Created by Pablo Ramirez on 6/26/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import Foundation

class MainViewModel{
    
    var gnomes: [Gnome] = []
    
    init() {
        
    }
    
    func getGnomesTown(){
        let jsonUrlString = "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json"
        
        guard let url = URL(string: jsonUrlString) else{
            print("Error en el servicio")
        
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            /// validar si hay error
            if let error = error{
                print("ocurrió un error: ", error)
                return
            }
            
            /// checar el status 200 OK
//            if let httpResponse = response as? HTTPURLResponse{
//                if httpResponse.statusCode == 400{
//                    print("Error")
//                    return
//                }
//            }
            
            guard let data = data else { return }
            
            do{
                let gnomes = try JSONDecoder().decode([Gnome].self, from: data)
                
                print(gnomes)
                self.gnomes = gnomes
            }catch let jsopErr{
                
                print("error serializing json object:", jsopErr)
            }
        }.resume()
    }
}
