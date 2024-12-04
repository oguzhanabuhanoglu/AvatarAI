//
//  FirebaseManager.swift
//  AvatarAI
//
//  Created by Oğuzhan Abuhanoğlu on 27.11.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class DatabaseManager {
    
    static let shared = DatabaseManager()
    let database = Firestore.firestore()
    
    
    func createUser(newUser: User, completion: @escaping (Bool) -> Void) {
        let reference = database.document("users/\(newUser.id)")
        guard let data = newUser.asDictionary() else {
            completion(false)
            return
        }
        reference.setData(data) { error in
            completion(error == nil)
        }
        
    }
    
    
    func createAvatar(newPost: Avatar, completion: @escaping (Bool) -> Void){
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            completion(false)
            return
        }
        let reference = database.document("users/\(userId)/avatars/\(newPost.id)")
        guard let data = newPost.asDictionary() else{
            completion(false)
            return
        }
        reference.setData(data) { error in
            completion(error == nil)
        }
    }
    
    
    func getAvatars(completion: @escaping (Result<[Avatar], Error>) -> ()) {
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            return
        }
        
        let ref = database.collection("users").document(userId).collection("avatars")
        
        ref.getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.failure(NSError(domain: "Firestore", code: 2, userInfo: [NSLocalizedDescriptionKey: "No documents found"])))
                return
            }
            
            let avatars: [Avatar] = documents.compactMap { document in
                do {
                    let avatar = try document.data(as: Avatar.self)
                    return avatar
                } catch {
                    print("Failed to decode Avatar: \(error)")
                    return nil
                }
            }
            completion(.success(avatars))
        }
    }
    
    
}
