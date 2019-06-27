//
//  Extensions.swift
//  KavakChallenge
//
//  Created by Pablo Ramirez on 6/25/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

extension UIViewController{
    public func showLoadingView(){
        self.view.endEditing(true)
        let loadingView = LoadingView()
        loadingView.tag = 500
        //loadingView.alpha = 0.5
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        loadingView.frame = CGRect.init(x: keyWindow.bounds.origin.x, y: keyWindow.bounds.origin.y, width: keyWindow.bounds.size.width, height: keyWindow.bounds.size.height)
        UIView.animate(withDuration: 1) {
            keyWindow.rootViewController?.view.isUserInteractionEnabled = false
            keyWindow.addSubview(loadingView)
        }
    }
    
    public func dismissLoadingView(){
        if let viewWithTag = UIApplication.shared.keyWindow?.viewWithTag(500) {
            UIApplication.shared.keyWindow?.rootViewController?.view.isUserInteractionEnabled = true
            viewWithTag.removeFromSuperview()
        }
    }
}

extension UIImageView{
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from stringURL: String) {
        if let url = URL(string: stringURL){
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                //print(response?.suggestedFilename ?? url.lastPathComponent)
                DispatchQueue.main.async() {
                    self.image = UIImage(data: data)
                }
            }
        }
        else{
            self.backgroundColor = UIColor.lightGray
        }
    }
    
    func downloadImageWithAF(urlStr: String){
        if let url = URL(string: urlStr){
            self.af_setImage(withURL: url)
        }
        else{
            self.backgroundColor = UIColor.lightGray
        }
    }
}
