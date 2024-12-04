//
//  PromptViewController.swift
//  AvatarAI
//
//  Created by Oğuzhan Abuhanoğlu on 22.11.2024.
//

import UIKit
import Lottie
import NeonSDK

class PromptViewController: UIViewController, UITextViewDelegate {
    
    let promptTextView = UITextView()
    let menu = DropdownMenuView()
    let ChooseAspectRatio = ChooseAspectRatioView()
    
    var timer = Timer()
    var userPrompt = ""
    var selectedSize = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu.onToggleIsHidden = { [weak self] isHidden in
            self?.ChooseAspectRatio.updateIsHidden(isHidden)
        }
        
        setupUI()
    }
    
    
    // MARK: CALL API
    @objc func didTapCreateButton() {
        guard
            let selectedOption = ChooseAspectRatio.selectedOption,
            let size = selectedOption.label.text,
            let prompt = promptTextView.text,
            !prompt.isEmpty
        else {
            createAlert(title: "Upps !!", message: "Be sure prompt is not empty, and aspect ratio is selected.")
            return
        }
        
        LottieManager.showFullScreenLottie(animation: .custom(name: "loading"))
//        LottieManager.showFullScreenLottie(animation: .custom(name: "loading"), width: 300, color: .red, backgroundOpacity: 0.5, playOnce: false, speed: 1)
        
        APIManager.eachlabsStartTask(prompt: prompt, size: size) { triggerId in
            if let triggerId = triggerId {
                DispatchQueue.main.async {
                    print("Trigger ID: \(triggerId)")
                    self.userPrompt = prompt
                    self.selectedSize = size
                    self.startTimer(triggerId: triggerId)
                }
            } else {
                print("Trigger ID alınamadı.")
            }
        }
    }
    
    func startTimer(triggerId: String) {
        DispatchQueue.main.async { [self] in
            timer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(getImageUrl(_:)), userInfo: triggerId, repeats: true)
        }
    }
    
    @objc func getImageUrl(_ timer: Timer) {
        print("getImage Url func called")
        
        if let triggerId = timer.userInfo as? String {
            // API'den task durumunu kontrol et
            APIManager.eachlabsGettingStatus(triggerId: triggerId) { response in
                if let response = response {
                    DispatchQueue.main.async {
                        let cleanedURL = response.replacingOccurrences(of: "\"", with: "")
                        print("Cleaned URL: \(cleanedURL)")
                        
                        if let validURL = URL(string: cleanedURL) {
                            timer.invalidate()
                            self.handleGeneratedImageURL(validURL: validURL)
                        } else {
                            print("Invalid URL: \(cleanedURL)")
                        }
                    }
                } else {
                    print("No Response: \(String(describing: response))")
                }
            }
        }
    }
    
    
    func handleGeneratedImageURL(validURL: URL) {
        
        let avatarId = UUID().uuidString
        
        StorageManager.shared.uploadAvatar(from: validURL, id: avatarId) { downloadURL in
            guard let downloadURL = downloadURL else {
                print("error when upload image to storage")
                return
            }
            DispatchQueue.main.async { [self] in
                createAvatar(prompt: userPrompt, url: downloadURL, id: avatarId)
            }
        }
        
        
    }
    
    
    func createAvatar(prompt: String, url: URL, id: String) {
        
        let currentDate = String.dateString(from: Date()) ?? ""
        
        let newAvatar = Avatar(id: id,
                               prompt: prompt,
                               imageUrl: url.absoluteString,
                               date: currentDate
        )
        
        DatabaseManager.shared.createAvatar(newPost: newAvatar) { success in
            
            guard success else { return }
            
            LottieManager.removeFullScreenLottie()
            self.promptTextView.text = ""
            
            let destinationVC = ResultViewController()
            destinationVC.prompt = self.userPrompt
            destinationVC.imageUrl = url.absoluteString
            self.present(destinationVC: destinationVC, slideDirection: .right)
        }
    }
    
   
    deinit{
        timer.invalidate()
        print("Timer Temizlendi")
    }
    
    
    // MARK: Button Functions
    @objc func didTapBackButton() {
        dismiss(animated: true)
    }
    
    
    @objc func didTapHistoryButton() {
        let destinationVC = AvatarHistoryViewController()
        present(destinationVC: destinationVC, slideDirection: .left)
    }
    
    
    
    // MARK: UI
    func  setupUI() {
        view.backgroundColor = .black
        let width = view.frame.width
        let height = view.frame.height
        
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(10)
        }
        
        let historyButton = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
        let bookmark = UIImage(systemName: "bookmark", withConfiguration: config)
        historyButton.setImage(bookmark, for: .normal)
        historyButton.tintColor = UIColor(red: 51/255, green: 219/255, blue: 35/255, alpha: 1.0)
        historyButton.addTarget(self, action: #selector(didTapHistoryButton), for: .touchUpInside)
        view.addSubview(historyButton)
        historyButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.right.equalToSuperview().offset(-10)
        }
        
        let navigationTitle = CustomLabel(text: "Create", fontName: "Poppins-Bold", fontSize: 20, textAlignment: .center)
        view.addSubview(navigationTitle)
        navigationTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        let subtitleLabel = CustomLabel(text: "Create:", fontName: "Poppins", fontSize: 16, textAlignment: .left)
        view.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(10)
            make.height.equalTo(30)
            make.top.equalTo(backButton.snp.bottom).offset(10)
        }
        
        
        promptTextView.textColor = .white
        promptTextView.font = UIFont(name: "Poppins", size: 14)
        promptTextView.backgroundColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)
        promptTextView.layer.cornerRadius = 25
        promptTextView.delegate = self
        view.addSubview(promptTextView)
        
        let placeholderLabel = UILabel()
        placeholderLabel.text = "  Type your prompt..."
        placeholderLabel.font = UIFont(name: "Poppins", size: 14)
        placeholderLabel.textColor = .lightGray
        placeholderLabel.isHidden = !promptTextView.text.isEmpty
        promptTextView.addSubview(placeholderLabel)
        
        placeholderLabel.snp.makeConstraints { make in
            make.left.equalTo(promptTextView).offset(5)
            make.top.equalTo(promptTextView).offset(8)
        }
        
        promptTextView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(view.frame.height * 0.15)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(10)
        }
        
        view.addSubview(menu)
        menu.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(50)
            make.top.equalTo(promptTextView.snp.bottom).offset(10)
        }
        
        
        view.addSubview(ChooseAspectRatio)
        ChooseAspectRatio.snp.makeConstraints { make in
            make.top.equalTo(menu.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(height * 0.2)
        }
        
        
        let createButton = primaryButton(title: "Create")
        createButton.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
        view.addSubview(createButton)
        createButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-85)
            make.width.equalTo(width * 0.7)
            make.centerX.equalTo(view)
            make.height.equalTo(64)
        }
        
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = textView.subviews.compactMap({ $0 as? UILabel }).first {
            placeholderLabel.isHidden = !textView.text.isEmpty
        }
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }

    
}
