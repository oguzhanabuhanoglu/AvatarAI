//
//  CustomComponents.swift
//  AvatarAI
//
//  Created by Oğuzhan Abuhanoğlu on 21.11.2024.
//

import Foundation
import UIKit
  
// MARK: Price View
class priceViewLabels: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setupUI() {
        
        let titleLabel = CustomLabel(text: "Check Out", fontName: "Poppins-Bold", fontSize: 28, textAlignment: .center)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(60)
            make.top.equalToSuperview().offset(100)
        }
        
        
        let subtitleLabel = CustomLabel(text: "Why is it pay?", fontName: "Poppins", fontSize: 16, textAlignment: .center)
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalTo(titleLabel.snp.bottom).offset(17)
        }
        
        let descriptionLabel = CustomLabel(text: "AI Avatar consume that tremendous computation power to create amazing avatars for you. It’s expensive, but we made it as affordable as possible.", fontName: "Poppins", fontSize: 14, textAlignment: .center)
        descriptionLabel.numberOfLines = 3
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(10).inset(10)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(7)
            make.bottom.equalToSuperview().offset(-7)
        }
    }
    
}


// MARK: Paywall
class PlanView: UIView {
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupUI()
        }
        
    
    
    func setupUI() {
    
        // MARK: Content 1
        let infinityImage = UIImageView()
        infinityImage.image = UIImage(named: "infinity")
        infinityImage.tintColor = .white
        addSubview(infinityImage)
        infinityImage.snp.makeConstraints { make in
            make.left.top.equalTo(5)
            make.width.height.equalTo(30)
        }
        
        
        let contentLabel1 = CustomLabel(text: "Unlimited Art Creation", fontName: "Poppins", fontSize: 16, textAlignment: .left)
        addSubview(contentLabel1)
        contentLabel1.snp.makeConstraints { make in
            make.left.equalTo(infinityImage.snp.rightMargin).offset(15)
            make.centerY.equalTo(infinityImage.snp.centerY)
            make.height.equalTo(35)
            make.right.equalToSuperview().offset(-10)
        }
        
        
        
        // MARK: Content 2
        let blockImage = UIImageView()
        blockImage.image = UIImage(named: "block")
        blockImage.tintColor = .white
        addSubview(blockImage)
        blockImage.snp.makeConstraints { make in
            make.left.equalTo(5)
            make.top.equalTo(infinityImage.snp.bottomMargin).offset(12)
            make.width.height.equalTo(27)
        }
        
        
        let contentLabel2 = CustomLabel(text: "Ad - Free Experience", fontName: "Poppins", fontSize: 16, textAlignment: .left)
        addSubview(contentLabel2)
        contentLabel2.snp.makeConstraints { make in
            make.left.equalTo(blockImage.snp.right).offset(9)
            make.centerY.equalTo(blockImage.snp.centerY)
            make.height.equalTo(35)
            make.right.equalToSuperview().offset(-10)
        }
        
        // MARK: Content 3
        let checkImage = UIImageView()
        checkImage.image = UIImage(named: "check")
        checkImage.tintColor = .white
        addSubview(checkImage)
        checkImage.snp.makeConstraints { make in
            make.left.equalTo(5)
            make.top.equalTo(blockImage.snp.bottom).offset(10)
            make.width.height.equalTo(27)
        }
        
        let contentLabel3 = CustomLabel(text: "Unlimited Art Creation", fontName: "Poppins", fontSize: 16, textAlignment: .left)
        addSubview(contentLabel3)
        contentLabel3.snp.makeConstraints { make in
            make.left.equalTo(checkImage.snp.right).offset(9)
            make.centerY.equalTo(checkImage.snp.centerY)
            make.height.equalTo(35)
            make.right.equalToSuperview().offset(-10)
        }
        
    }
    
}


