//
//  ResultViewController.swift
//  AvatarAI
//
//  Created by Oğuzhan Abuhanoğlu on 26.11.2024.
//

import UIKit
import SDWebImage
import NeonSDK

class ResultViewController: UIViewController {
    
    let resulImageView = UIImageView()
    let animationView = UIView()
    var imageUrl: String = ""
    var prompt: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
    
    
    @objc func didTapBackButton() {
        dismiss(animated: true)
    }
    
    @objc func didTapShareButton() {
        let shareText = "Check out this amazing result!"
        let shareImage = UIImage(named: "share")
        let activityItems: [Any] = [shareText, shareImage as Any]
        
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = self.view
        activityVC.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX,
                                                                      y: self.view.frame.midY,
                                                                      width: 0,
                                                                      height: 0)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @objc func didTapSaveButton() {
        guard let image = resulImageView.image else {
            print("There is no image!")
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveImageCompletion(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    
    @objc func saveImageCompletion(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            self.createAlert(title: "Error", message: error.localizedDescription)
        } else {
            createSuccessAnimation()
        }
    }
    
    
    func createSuccessAnimation() {
        let lottie = LottieManager.createLottie(animation: .custom(name: "success"))
        lottie.loopMode = .playOnce
        view.addSubview(lottie)
        lottie.snp.makeConstraints({make in
            make.center.equalToSuperview()
            make.width.height.equalTo(view.frame.size.width * 0.4)
        })
    }
    
    
   func setupUI() {
       view.backgroundColor = .black
       let width = view.frame.width
       let height = view.frame.height
       
       let backButton = UIButton()
       backButton.setTitle("Done", for: .normal)
       backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
       view.addSubview(backButton)
       backButton.snp.makeConstraints { make in
           make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
           make.left.equalToSuperview().offset(10)
       }
       
       let shareButton = UIButton()
       shareButton.setImage(UIImage(named: "share"), for: .normal)
       shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
       view.addSubview(shareButton)
       shareButton.snp.makeConstraints { make in
           make.top.equalTo(view.safeAreaLayoutGuide)
           make.right.equalToSuperview().offset(-10)
       }
       
       
       resulImageView.layer.masksToBounds = true
       resulImageView.layer.cornerRadius = 25
       resulImageView.sd_setImage(with: URL(string: self.imageUrl), placeholderImage: UIImage(named: "placeholder"))
       view.addSubview(resulImageView)
       resulImageView.snp.makeConstraints { make in
           make.left.equalToSuperview().offset(25)
           make.right.equalToSuperview().offset(-25)
           make.height.equalTo(width - 50)
           make.top.equalTo(height * 0.15)
       }
       
       let promptLabel = UITextView()
       promptLabel.backgroundColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)
       promptLabel.isUserInteractionEnabled = false
       promptLabel.textColor = .white
       promptLabel.layer.masksToBounds = true
       promptLabel.layer.cornerRadius = 18
       promptLabel.text = self.prompt
       view.addSubview(promptLabel)
       promptLabel.snp.makeConstraints { make in
           make.left.equalToSuperview().offset(25)
           make.right.equalToSuperview().offset(-25)
           make.height.equalTo(height * 0.15)
           make.top.equalTo(resulImageView.snp.bottom).offset(40)
       }
       
       var configuration = UIButton.Configuration.plain()
       configuration.imagePadding = 8
       let saveButton = UIButton()
       saveButton.setImage(UIImage(named: "download"), for: .normal)
       saveButton.setTitle("Save", for: .normal)
       saveButton.setTitleColor(.black, for: .normal)
       saveButton.layer.cornerRadius = 8
       saveButton.backgroundColor = UIColor(red: 51/255, green: 219/255, blue: 35/255, alpha: 1.0)
       saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
       saveButton.configuration = configuration
       view.addSubview(saveButton)
       saveButton.snp.makeConstraints { make in
           make.height.equalTo(50)
           make.width.equalTo(width * 0.4)
           make.left.equalTo((width * 0.2) / 3)
           make.bottom.equalToSuperview().offset(-85)
       }
       
       var config = UIButton.Configuration.plain()
       config.imagePadding = 8 // Simge ve metin arasındaki boşluk
       let refreshButton = UIButton()
       refreshButton.setImage(UIImage(named: "refresh"), for: .normal)
       refreshButton.setTitle("Refresh", for: .normal)
       refreshButton.setTitleColor(.white, for: .normal)
       refreshButton.layer.cornerRadius = 8
       refreshButton.backgroundColor = .black
       refreshButton.layer.borderWidth = 1
       refreshButton.layer.borderColor =  UIColor(red: 51/255, green: 219/255, blue: 35/255, alpha: 1.0).cgColor
       refreshButton.configuration = config
       view.addSubview(refreshButton)
       refreshButton.snp.makeConstraints { make in
           make.left.equalTo(saveButton.snp.right).offset(((width * 0.2) / 3))
           make.height.equalTo(50)
           make.width.equalTo(width * 0.4)
           make.bottom.equalToSuperview().offset(-85)
       }
    }

    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}
