//
//  Materials.swift
//  DreamList
//
//  Created by Hardik Wason on 23/08/17.
//  Copyright © 2017 Hardik Wason. All rights reserved.
//

import UIKit

private var materialKey = false

class Materials: UIView {

    
    @IBInspectable var materialsDesign : Bool {
        
        get {
            return materialKey
            
        }
        
        set {
            materialKey = newValue
            
            if materialKey {
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 3.0
                self.layer.shadowOpacity = 0.8
                self.layer.shadowRadius = 3.0
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
            }
            else {
                
                self.layer.shadowRadius = 0
                self.layer.shadowColor = nil
                self.layer.shadowOpacity = 0
                self.layer.cornerRadius = 0
                
            }
        }
        
            }
    
    
    
    
    
    
    
}
