//
//  CustomButtons.swift
//  AvatarAI
//
//  Created by Oğuzhan Abuhanoğlu on 26.11.2024.
//

import Foundation
import UIKit

// MARK: BUTTONS
class continueButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        self.setTitle("Continue", for: .normal)
        self.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 24)
        self.setTitleColor(.black, for: UIControl.State.normal)
        self.backgroundColor = UIColor(red: 51/255, green: 219/255, blue: 35/255, alpha: 1.0)
        self.frame.size.height = 64
        self.layer.cornerRadius = 32
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class primaryButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont(name: "Poppins", size: 18)
        self.setTitleColor(.black, for: UIControl.State.normal)
        self.backgroundColor = UIColor(red: 51/255, green: 219/255, blue: 35/255, alpha: 1.0)
        self.frame.size.height = 64
        self.layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class menuContentButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont(name: "Poppins", size: 12)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor =  UIColor(red: 64/255, green: 64/255, blue: 64/255, alpha: 1.0)
        self.layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
