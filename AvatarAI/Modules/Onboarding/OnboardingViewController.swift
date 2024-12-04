//
//  ViewController.swift
//  AvatarAI
//
//  Created by Oğuzhan Abuhanoğlu on 21.11.2024.
//

import UIKit
import NeonSDK
import FirebaseAuth
import FirebaseFirestore

class OnboardingViewController: NeonOnboardingController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        
        let width = view.frame.width
        let height = view.frame.height
        
        self.configureButton(
            title: "Get Started",
            titleColor: .black,
            font: Font.custom(size: 24, fontWeight: .Bold),
            cornerRadious: 32,
            height: 55,
            horizontalPadding: width * 0.1,
            bottomPadding: height * 0.05,
            backgroundColor: UIColor(red: 51/255, green: 219/255, blue: 35/255, alpha: 1.0),
            borderColor: nil,
            borderWidth: nil
        )
        
        self.configureBackground(
            type: .halfBackgroundImage(
                backgroundColor: .black,
                offset: 130,
                isFaded: true)
        )
        
        self.configurePageControl(
            type: .V1,
            currentPageTintColor: .white,
            tintColor: .lightGray,
            radius: 4,
            padding: 8
        )
        
        self.addPage(
            title: "Introducing Image AI",
            subtitle: "Create a digital representation of yourself with AI technology",
            image: UIImage(named: "Onboarding1")!
        )
        
        self.addPage(
            title: "Get Infinite versions of you with AI",
            subtitle: "Design your avatar with a wide range of customizable features.",
            image: UIImage(named: "Onboarding2")!
        )
        
        self.addPage(
            title: "Turn your words to art",
            subtitle: "Generate amazing images from basic text prompts",
            image: UIImage(named: "Onboarding3")!
        )
        
        self.addPage(
            title: "Ready to Share",
            subtitle: "Once you’ve created yourimages, share them with the world on social media",
            image: UIImage(named: "Onboarding4")!
        )
       
        
    }
    
    // MARK: Anonymous signin
    override func onboardingCompleted() {
        AuthManager.shared.signInAnonymously { result in
            switch result {
            case .success:
                let destinationVC = PaywallViewController()
                self.present(destinationVC: destinationVC, slideDirection: .up)
            case .failure:
                self.createAlert(title: "Upss!", message: "Something went wrong...")
            }
        }
        
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }


}

