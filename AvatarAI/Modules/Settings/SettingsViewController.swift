//
//  SettingsViewController.swift
//  AvatarAI
//
//  Created by Oğuzhan Abuhanoğlu on 22.11.2024.
//

import Foundation
import UIKit
import NeonSDK

class SettingsViewController: NeonSettingsController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureUI()
        configureSections()
    }
    

    func configureUI() {
        configure(
            buttonTextColor: .white,
            buttonBackgroundColor: .darkText,
            buttonBorderColor: .clear,
            buttonCornerRadius: 10.0,
            iconTintColor: .white,
            primaryTextColor: .white,
            mainColor: .black,
            controller: self
        )
    }
    
    private func configureSections() {
        addSection(
            .premiumButton(
                title: "Go Premium",
                icon: NeonSymbols.crown,
                backgroundColor:  UIColor(red: 51/255, green: 219/255, blue: 35/255, alpha: 1.0),
                borderColor: .clear,
                titleColor: .black,
                iconTintColor: .black,
                completion: {
                    let destinationVC = UINavigationController(rootViewController: PaywallViewController())
                    destinationVC.modalPresentationStyle = .fullScreen
                    self.present(destinationVC, animated: true)
                }
            )
        )
        
        addSection(
            .titleSection(
                title: "General"
            )
        )
        
        addSection(
            .restorePurchaseButton(
                icon: NeonSymbols.arrow_counterclockwise,
                service: .adapty
            )
        )

        addSection(
            .linkButton(
                title: "Privacy Policy",
                url: "https://example.com/privacy",
                icon: NeonSymbols.shield
            )
        )
        
        addSection(
            .linkButton(
                title: "Terms of Service",
                url: "https://example.com/terms",
                icon: NeonSymbols.doc_text
            )
        )
        
        addSection(
            .rateButton(
                title: "Rate Us",
                icon: NeonSymbols.star
            )
        )
    
        
    
 
    }
}
