//
//  CustomTextField.swift
//  CodingAChat
//
//  Created by Samuele Francesco Rizzo on 09/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

class CustomTextField : UITextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 9.0
        self.layer.borderColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        self.layer.borderWidth = 2.0
        self.backgroundColor = .white
        
        // Paddings
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        self.leftViewMode = .always
        self.rightViewMode = .always
        
        self.addTarget(self, action: #selector(textFieldTouched(_:)), for: UIControl.Event.editingDidBegin)
        self.addTarget(self, action: #selector(textFieldExit(_:)), for: UIControl.Event.editingDidEnd)
    }
    
    @objc func textFieldTouched(_ sender: Any) {
        self.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    @objc func textFieldExit(_ sender: Any) {
        self.layer.borderColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
    }
    
}

