//
//  AvatarHistoryViewController.swift
//  AvatarAI
//
//  Created by Oğuzhan Abuhanoğlu on 28.11.2024.
//

import UIKit

class AvatarHistoryViewController: UIViewController{

    let collectionView = AvatarCollectionViewController()
     
     override func viewDidLoad() {
         super.viewDidLoad()

         view.backgroundColor = .black
         setupUI()
        
     }
    
    @objc func didTapBackButton() {
        self.dismiss(animated: true)
    }
     
     
     func setupUI() {
         
         let backButton = UIButton()
         backButton.setTitle("Done", for: .normal)
         backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
         view.addSubview(backButton)
         backButton.snp.makeConstraints { make in
             make.top.equalTo(view.safeAreaLayoutGuide)
             make.right.equalToSuperview().offset(-10)
         }
         
         
         let navigationTitle = CustomLabel(text: "My Avatars", fontName: "Poppins-Bold", fontSize: 40, textAlignment: .left)
         navigationTitle.textColor = UIColor(red: 51/255, green: 219/255, blue: 35/255, alpha: 1.0)
         view.addSubview(navigationTitle)
         navigationTitle.snp.makeConstraints { make in
             make.top.equalTo(backButton.snp.bottom).offset(5)
             make.left.equalToSuperview().offset(15)
             make.width.equalToSuperview().multipliedBy(0.7)
         }
         
         
         view.addSubview(collectionView)
         collectionView.snp.makeConstraints { make in
             make.left.right.bottom.equalToSuperview()
             make.top.equalTo(navigationTitle.snp.bottom).offset(5)
         }
         
         
         
     }

   
}
