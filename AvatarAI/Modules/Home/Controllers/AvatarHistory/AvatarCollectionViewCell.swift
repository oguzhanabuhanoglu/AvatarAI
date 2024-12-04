//
//  AvatarCollectionViewCell.swift
//  AvatarAI
//
//  Created by Oğuzhan Abuhanoğlu on 29.11.2024.
//

import Foundation
import NeonSDK
import UIKit
import SDWebImage

class AvatarCollectionViewCell: NeonCollectionViewCell<Avatar> {

    private let avatarImageView = UIImageView()
    private let promptLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure(with avatar: Avatar) {
        super.configure(with: avatar)
        avatarImageView.sd_setImage(with: URL(string: avatar.imageUrl))
        promptLabel.text = avatar.prompt
    }
    
    
    private func setupSubviews() {
        
        promptLabel.textAlignment = .left
        promptLabel.numberOfLines = 0
        promptLabel.textColor = .white
        promptLabel.font = UIFont(name: "Poppins", size: 15)
        contentView.addSubview(promptLabel)
        promptLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.width.equalToSuperview()
        }
        
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        contentView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(frame.width)
            make.top.equalTo(promptLabel.snp.bottom).offset(5)
        }
        
        
    }
    
   
        
 
}
