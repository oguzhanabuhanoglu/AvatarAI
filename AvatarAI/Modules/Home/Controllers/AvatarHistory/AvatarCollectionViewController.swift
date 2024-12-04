//
//  AvatarCollectionViewViewController.swift
//  AvatarAI
//
//  Created by Oğuzhan Abuhanoğlu on 29.11.2024.
//

import UIKit
import NeonSDK

class AvatarCollectionViewController: NeonCollectionView<Avatar, AvatarCollectionViewCell> {
    
    var avatarArray: [Avatar] = [] {
        didSet {
            self.objects = avatarArray
        }
    }
    
    convenience init() {
        self.init(objects: [],
                  itemsPerRow: 1,
                  leftPadding: 5,
                  rightPadding: 5,
                  horizontalItemSpacing: 2,
                  verticalItemSpacing: 0,
                  heightForItem: 300
        )
        backgroundColor = .black
        loadAvatars() 
    }
    
    private func loadAvatars() {
        DatabaseManager.shared.getAvatars { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let avatars):
                self.avatarArray = avatars
            case .failure(let error):
                print("Failed to fetch avatars: \(error)")
            }
        }
    }
}
