//
//  PaywallViewController.swift
//  AvatarAI
//
//  Created by Oğuzhan Abuhanoğlu on 21.11.2024.
//

import UIKit
import NeonSDK

class PaywallViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        print("paywall")
    }
    
    @objc func didTapContinue() {
        present(destinationVC: PricesViewController(), slideDirection: .right)
    }
    
    @objc func didTapDismissButton() {
        let navController = UINavigationController(rootViewController: HomeViewController())
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
    func setupUI() {
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "PaywallBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.borderWidth = 3
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.top.equalTo(0)
            make.height.equalTo(height)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "Choose Your Plan"
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Poppins-Bold", size: 28)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalTo(55)
            make.top.equalTo(height * 0.35)
        }
        
        let packetContentView = PlanView()
        view.addSubview(packetContentView)
        packetContentView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.width.equalTo(width * 0.7)
            make.centerX.equalTo(view).offset(30)
            make.height.equalTo(125)
        }
        
        let priceImage = UIImageView()
        priceImage.image = UIImage(named: "priceImage")
        view.addSubview(priceImage)
        priceImage.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(packetContentView.snp.bottom).offset(20)
            make.width.equalTo(width * 0.8)
            make.height.equalTo(height * 0.20)
            
        }
        
        let descriptionLabel = CustomLabel(text: "No commitment. Cancel anytime.", fontName: "Poppins", fontSize: 14, textAlignment: .center)
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(priceImage.snp.bottom).offset(15)
            make.width.equalToSuperview()
        }
        
        
        let continueButton = continueButton()
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        view.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-85)
            make.width.equalTo(width * 0.8)
            make.centerX.equalTo(view)
            make.height.equalTo(64)
        }
        
        
        let dismissButton = UIButton()
        dismissButton.setImage(UIImage(named: "greenXmark"), for: .normal)
        dismissButton.layer.cornerRadius = 25
        dismissButton.addTarget(self, action: #selector(didTapDismissButton), for: .touchUpInside)
        view.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(view).offset(40)
            make.width.height.equalTo(50)
        }
    }
  

}
