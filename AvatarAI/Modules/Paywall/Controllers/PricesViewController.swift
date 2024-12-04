//
//  PricesViewController.swift
//  AvatarAI
//
//  Created by Oğuzhan Abuhanoğlu on 22.11.2024.
//

import UIKit

class PricesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupIU()
    }
    
    @objc func didTapContinue() {
        let navController = UINavigationController(rootViewController: HomeViewController())
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
    @objc func didTapDismissButton() {
        let navController = UINavigationController(rootViewController: HomeViewController())
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
    func setupIU() {
        
        view.backgroundColor = .black
        
        let width = view.frame.width
        let height = view.frame.height
       
        let labels = priceViewLabels()
        view.addSubview(labels)
        labels.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(height * 0.35)
        }
        
        let imageView = UIImageView(image: UIImage(named: "priceOptions"))
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(labels.snp.bottom).offset(10)
            make.width.equalTo(width * 0.8)
            make.height.equalTo(height * 0.4)
            make.centerX.equalTo(view)
        }
        
        let descriptionLabel = CustomLabel(text: "Get Up to %50 off with Subscription", fontName: "Poppins", fontSize: 14, textAlignment: .center)
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.bottom).offset(10)
            make.width.equalToSuperview()
        }
        
        let seePlansButton = UIButton()
        seePlansButton.setTitle("See Plans", for: .normal)
        seePlansButton.setTitleColor(UIColor(red: 51/255, green: 219/255, blue: 35/255, alpha: 1.0), for: .normal)
        seePlansButton.titleLabel?.font = UIFont(name: "Poppins", size: 15)
        view.addSubview(seePlansButton)
        seePlansButton.snp.makeConstraints { make in
            make.width.equalTo(width).dividedBy(2)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(3)
            make.height.equalTo(35)
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
        dismissButton.setImage(UIImage(named: "xMark"), for: .normal)
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
