//
//  LoadingView.swift
//  KavakChallenge
//
//  Created by Pablo Ramirez on 6/5/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import Foundation
import UIKit

class LoadingView: UIView {

    @IBOutlet weak var loadingView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        setup()
    }
    
    private func setup() {
        let view = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)?[0] as! UIView
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        loadingView.layer.cornerRadius = 10
    }
    
}
