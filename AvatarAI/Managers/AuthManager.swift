//
//  AuthManager.swift
//  AvatarAI
//
//  Created by Oğuzhan Abuhanoğlu on 28.11.2024.
//

import Foundation
import FirebaseAuth

class AuthManager {
    
    static let shared = AuthManager()
    
    enum AuthError : Error {
        case newUserCreation
        case signInFailed
        case emailVerificationFailed
        case databaseInsertionFailed
    }
    
    func signInAnonymously(completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signInAnonymously { authResult, error in
            guard let user = authResult?.user else { return }
            let isAnonymous = user.isAnonymous  // true
            let uid = user.uid
            
            let newUser = User(id: uid, isPremium: false)
            DatabaseManager.shared.createUser(newUser: newUser) { success in
                if success {
                    UserDefaults.standard.setValue(uid, forKey: "userId")
                    completion(.success(newUser))
                } else {
                    completion(.failure(AuthError.newUserCreation))
                }
            }
            
            
        }
    }
    
    
    
}
