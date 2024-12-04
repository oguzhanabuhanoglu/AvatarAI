//
//  CustomLabels.swift
//  AvatarAI
//
//  Created by Oğuzhan Abuhanoğlu on 26.11.2024.
//

import Foundation
import UIKit

// MARK: LABELS
class CustomLabel: UILabel {
    
    init(text: String,fontName: String, fontSize: CGFloat, textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = .white
        self.textAlignment = textAlignment
        self.font = UIFont(name: "Poppins", size: fontSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
