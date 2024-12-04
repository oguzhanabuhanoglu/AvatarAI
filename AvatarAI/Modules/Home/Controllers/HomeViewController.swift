//
//  HomeViewController.swift
//  AvatarAI
//
//  Created by Oğuzhan Abuhanoğlu on 21.11.2024.
//

import UIKit
import NeonSDK

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("home")
        setupUI()

    }

    
    @objc func didTapSettings() {
        print("tapped")
        let destinationVC = SettingsViewController()
        present(destinationVC: destinationVC, slideDirection: .right)
    }
    
    @objc func didTapStartButton() {
        let destinationVC = PromptViewController()
        destinationVC.modalPresentationStyle = .fullScreen
        present(destinationVC: destinationVC, slideDirection: .right)
        
    }
    
    func setupUI() {
        
        view.backgroundColor = .black
        
        let width = view.frame.width
        let height = view.frame.height
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let navigationTitle = CustomLabel(text: "Create Avatar", fontName: "Poppins-Bold", fontSize: 20, textAlignment: .center)
        navigationTitle.font = Font.custom(size: 23, fontWeight: .Bold)
        view.addSubview(navigationTitle)
        navigationTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(13)
        }
        
        
        let settingButton = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
        let gear = UIImage(systemName: "gear", withConfiguration: configuration)
        settingButton.setImage(gear, for: .normal)
        settingButton.tintColor = .white
        settingButton.isUserInteractionEnabled = true
        settingButton.isHidden = false
        settingButton.alpha = 1.0
        settingButton.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
        view.addSubview(settingButton)
        settingButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.right.equalToSuperview().offset(-10)
        }
      
        
        let titleLabel = CustomLabel(text: "Start Here", fontName: "Poppins-Bold", fontSize: 28, textAlignment: .center)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(height * 0.1)
            make.top.equalTo(height * 0.37)
        }
        
        let descriptionLabel = CustomLabel(text: "Create your first avatar with the power of artificial intelligence.", fontName: "Poppins", fontSize: 16, textAlignment: .center)
        descriptionLabel.numberOfLines = 2
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.width.equalTo(width * 0.7)
            make.centerX.equalTo(view)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(height * 0.1)
        }
        
        
        let startButton = primaryButton(title: "Create New Avatar")
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-85)
            make.width.equalTo(width * 0.7)
            make.centerX.equalTo(view)
            make.height.equalTo(64)
        }
        
        
        let arrowImage = UIImageView()
        arrowImage.image = UIImage(named: "arrow")
        view.addSubview(arrowImage)
        arrowImage.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            make.bottom.equalTo(startButton.snp.top).offset(-30)
            make.width.equalTo(15)
            make.centerX.equalTo(view)
        }
        
    }

    

}


