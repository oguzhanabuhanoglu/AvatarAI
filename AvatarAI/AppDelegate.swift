//
//  AppDelegate.swift
//  AvatarAI
//
//  Created by Oğuzhan Abuhanoğlu on 21.11.2024.
//

import UIKit
import NeonSDK
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        let onboardingVC = OnboardingViewController()
        let paywallVC = PaywallViewController()
        let homeVC = HomeViewController()
        
        Font.configureFonts(font: .Poppins)
        
        let splashVC = NeonSplashVC(appIcon: UIImage(named: "Onboarding1")!,
                                    appName: "Avatar AI",
                                    progressBarColors: [.systemGreen, .green],
                                    animationDuration: 3,
                                    backgroundColor: .black,
                                    textColor: .white
                                    )
        
        Neon.configure(window: &window,
                       onboardingVC: onboardingVC,
                       paywallVC: paywallVC,
                       homeVC: homeVC,
                       splashVC: splashVC
                    )

        return true
        
    }

    


}

