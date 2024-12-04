//
//  PromptViews.swift
//  AvatarAI
//
//  Created by Oğuzhan Abuhanoğlu on 27.11.2024.
//

import Foundation
import UIKit

// MARK: PromptView
class ChooseAspectRatioView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Aspect Ratio:"
        label.font = UIFont(name: "Poppins", size: 16)
        label.textColor = .white
        return label
    }()
    
    var selectedOption: AspectRatioOptionView?
    
    let option1 = AspectRatioOptionView(option: "1:1", imageName: "Rectangle1:1")
    let option2 = AspectRatioOptionView(option: "3:2", imageName: "Rectangle3:2")
    let option3 = AspectRatioOptionView(option: "2:3", imageName: "Rectangle2:3")
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .black
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupActions() {
        let options = [option1, option2, option3]
        options.forEach { option in
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(optionTapped(_:)))
            option.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc private func optionTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedOption = sender.view as? AspectRatioOptionView else { return }
        
        selectedOption?.isSelected = false
        tappedOption.isSelected = true
        selectedOption = tappedOption
        
        

    }

    func updateIsHidden(_ isHidden: Bool) {
        self.isHiddenConstraint = isHidden
    }
    
    private var isHiddenConstraint: Bool = false {
        didSet {
            updateConstraintsForIsHidden()
        }
    }
    
    func setupUI() {
        
        addSubview(titleLabel)
        addSubview(option1)
        addSubview(option2)
        addSubview(option3)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        option1.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)

        }
        
        option2.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.left.equalTo(option1.snp.right).offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        option3.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.left.equalTo(option2.snp.right).offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
    }
    
    private func updateConstraintsForIsHidden() {
           if isHiddenConstraint {
               titleLabel.snp.remakeConstraints { make in
                   make.left.equalToSuperview().offset(10)
                   make.top.equalToSuperview().offset(10)
                   make.width.equalTo(150)
                   make.height.equalTo(30)
               }
               
               option1.snp.remakeConstraints { make in
                   make.width.height.equalTo(100)
                   make.left.equalToSuperview().offset(20)
                   make.top.equalTo(titleLabel.snp.bottom).offset(5)

               }
               
               option2.snp.remakeConstraints { make in
                   make.width.height.equalTo(100)
                   make.left.equalTo(option1.snp.right).offset(20)
                   make.top.equalTo(titleLabel.snp.bottom).offset(5)
               }
               
               option3.snp.remakeConstraints { make in
                   make.width.height.equalTo(100)
                   make.left.equalTo(option2.snp.right).offset(20)
                   make.top.equalTo(titleLabel.snp.bottom).offset(5)
               }
           } else {
               titleLabel.snp.remakeConstraints { make in
                   make.left.equalToSuperview().offset(10)
                   make.top.equalToSuperview().offset(20)
               }
              
               option1.snp.remakeConstraints { make in
                   make.left.equalTo(titleLabel.snp.right).offset(10)
                   make.width.equalTo(70)
                   make.height.equalTo(50)
                   make.centerY.equalTo(titleLabel)
               }
               
               option2.snp.remakeConstraints { make in
                   make.left.equalTo(option1.snp.right).offset(10)
                   make.width.equalTo(70)
                   make.height.equalTo(50)
                   make.centerY.equalTo(titleLabel)
               }
               
               option3.snp.remakeConstraints { make in
                   make.left.equalTo(option2.snp.right).offset(10)
                   make.width.equalTo(70)
                   make.height.equalTo(50)
                   make.centerY.equalTo(titleLabel)
               }

           }
           self.layoutIfNeeded()
       }
    
}




// MARK: SingleOptionView
class AspectRatioOptionView: UIView {
    
    let imageView = UIImageView()
    let label = UILabel()
    
    init(option: String, imageName: String) {
        super.init(frame: .zero)
        setupUI(option: option, imageName: imageName)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
       
    }
    
    var isSelected: Bool = false {
        didSet {
            updateBackground()
        }
    }
    
    private func updateBackground() {
        backgroundColor = isSelected ? UIColor(red: 51/255, green: 219/255, blue: 35/255, alpha: 1.0) : UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)
    }
    
    @objc private func handleTap() {
        isSelected.toggle()
    }
    
    
    func setupUI(option: String, imageName: String) {
        
        backgroundColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)
        layer.cornerRadius = 15
        
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.center.equalToSuperview()
        }
        
        label.text = option
        label.textColor = .white
        label.textAlignment = .center
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.width.equalTo(35)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
        }
    }
    
}
    


