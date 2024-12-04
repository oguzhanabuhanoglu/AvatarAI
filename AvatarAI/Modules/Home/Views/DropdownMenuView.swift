//
//  DropdownMenuViewController.swift
//  AvatarAI
//
//  Created by Oğuzhan Abuhanoğlu on 26.11.2024.
//

import UIKit

class DropdownMenuView: UIView {
    
    let menuButton = UIButton()
    let dropdownMenu = UIView()

    var onToggleIsHidden: ((Bool) -> Void)?
    private var isMenuHidden = true
    
    init() {
        super.init(frame: .zero)
        self.isMenuHidden = true
        self.setupMenuButton()
        self.setupDropdownMenu()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let menuButtonMaskPath = UIBezierPath(roundedRect: menuButton.bounds,
                                              byRoundingCorners: [.topLeft, .topRight],
                                              cornerRadii: CGSize(width: 17, height: 17))
        let menuButtonShapeLayer = CAShapeLayer()
        menuButtonShapeLayer.path = menuButtonMaskPath.cgPath
        menuButton.layer.mask = menuButtonShapeLayer

        let dropdownMenuMaskPath = UIBezierPath(roundedRect: dropdownMenu.bounds,
                                                byRoundingCorners: [.bottomLeft, .bottomRight],
                                                cornerRadii: CGSize(width: 17, height: 17))
        let dropdownMenuShapeLayer = CAShapeLayer()
        dropdownMenuShapeLayer.path = dropdownMenuMaskPath.cgPath
        dropdownMenu.layer.mask = dropdownMenuShapeLayer
    }

    
    func setupMenuButton() {
        
        menuButton.setTitle("  Prompt Suggestions", for: .normal)
        menuButton.setTitleColor(.white, for: .normal)
        menuButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        menuButton.backgroundColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)
        menuButton.clipsToBounds = true
        menuButton.tintColor = .white
        menuButton.semanticContentAttribute = .forceRightToLeft
        menuButton.contentHorizontalAlignment = .left
        menuButton.addTarget(self, action: #selector(toggleMenuView), for: .touchUpInside)
        
        addSubview(menuButton)
        
        menuButton.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        
    }
    
    
    
    func setupDropdownMenu() {
        
        dropdownMenu.backgroundColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)
        dropdownMenu.clipsToBounds = true
        dropdownMenu.isHidden = true
        addSubview(dropdownMenu)

        dropdownMenu.translatesAutoresizingMaskIntoConstraints = false
        dropdownMenu.snp.makeConstraints { make in
            make.top.equalTo(menuButton.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(146)
        }
        
        let button1 = menuContentButton(title: "Midsommar, elegant")
        button1.addTarget(self, action: #selector(menuOption1Tapped), for: .touchUpInside)
        dropdownMenu.addSubview(button1)
        button1.snp.makeConstraints { make in
            make.width.equalTo(169)
            make.height.equalTo(38)
            make.left.equalToSuperview().offset(17)
            make.top.equalToSuperview().offset(8)
        }
        
        let button2 = menuContentButton(title: "Midsommar, elegant")
        button2.addTarget(self, action: #selector(menuOption2Tapped), for: .touchUpInside)
        dropdownMenu.addSubview(button2)
        button2.snp.makeConstraints { make in
            make.width.equalTo(169)
            make.height.equalTo(38)
            make.left.equalToSuperview().offset(17)
            make.top.equalTo(button1.snp.bottom).offset(8)
        }
        
        let button3 = menuContentButton(title: "Midsommar, elegant")
        button3.addTarget(self, action: #selector(menuOption3Tapped), for: .touchUpInside)
        dropdownMenu.addSubview(button3)
        button3.snp.makeConstraints { make in
            make.width.equalTo(169)
            make.height.equalTo(38)
            make.left.equalToSuperview().offset(17)
            make.top.equalTo(button2.snp.bottom).offset(8)
        }
        
        let button4 = menuContentButton(title: "Midsommar, elegant")
        button4.addTarget(self, action: #selector(menuOption4Tapped), for: .touchUpInside)
        dropdownMenu.addSubview(button4)
        button4.snp.makeConstraints { make in
            make.width.equalTo(169)
            make.height.equalTo(38)
            make.left.equalTo(button1.snp.right).offset(8)
            make.top.equalToSuperview().offset(8)

        }
        
        let button5 = menuContentButton(title: "Midsommar, elegant")
        button5.addTarget(self, action: #selector(menuOption5Tapped), for: .touchUpInside)
        dropdownMenu.addSubview(button5)
        button5.snp.makeConstraints { make in
            make.width.equalTo(169)
            make.height.equalTo(38)
            make.left.equalTo(button2.snp.right).offset(8)
            make.top.equalTo(button4.snp.bottom).offset(8)
        }
        
        let button6 = menuContentButton(title: "Midsommar, elegant")
        button6.addTarget(self, action: #selector(menuOption6Tapped), for: .touchUpInside)
        dropdownMenu.addSubview(button6)
        button6.snp.makeConstraints { make in
            make.width.equalTo(169)
            make.height.equalTo(38)
            make.left.equalTo(button3.snp.right).offset(8)
            make.top.equalTo(button5.snp.bottom).offset(8)
        }
        
        
    }
    
    @objc func toggleMenuView() {
        isMenuHidden.toggle()
        onToggleIsHidden?(isMenuHidden)
        
        let newHeight: CGFloat = isMenuHidden ? 50 : 196
        menuButton.setImage(isMenuHidden ? UIImage(systemName: "chevron.down") : UIImage(systemName: "chevron.up") , for: .normal)
        dropdownMenu.isHidden = isMenuHidden
        
        UIView.animate(withDuration: 0.3, animations: {
            self.snp.updateConstraints { make in
                make.height.equalTo(newHeight)
            }

            self.layoutIfNeeded()
        })
        
    }

    
    
    @objc func menuOption1Tapped() {
        print("Option 1 selected")
    }
    @objc func menuOption2Tapped() {
        print("Option 2 selected")
    }
    @objc func menuOption3Tapped() {
        print("Option 3 selected")
    }
    @objc func menuOption4Tapped() {
        print("Option 4 selected")
    }
    @objc func menuOption5Tapped() {
        print("Option 5 selected")
    }
    @objc func menuOption6Tapped() {
        print("Option 6 selected")
    }
}




