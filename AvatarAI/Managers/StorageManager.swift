//
//  StorageManager.swift
//  AvatarAI
//
//  Created by Oğuzhan Abuhanoğlu on 28.11.2024.
//


import Foundation
import FirebaseStorage

class StorageManager {
    
    static let shared = StorageManager()
    let storage = Storage.storage().reference()
    
    public func uploadAvatar(from url: URL, id: String, completion: @escaping (URL?) -> Void) {
        // Kullanıcı ID'sini UserDefaults'tan al
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            completion(nil)
            return
        }
        
        // Belirtilen URL'deki veriyi indir
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Data indirme hatası: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Veri bulunamadı!")
                completion(nil)
                return
            }
            
            // Firebase'deki referansı belirle
            let ref = self.storage.child("\(userId)/avatar/\(id).png")
            
            // İndirilen veriyi Firebase'e yükle
            ref.putData(data) { _, error in
                if let error = error {
                    print("Firebase yükleme hatası: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                // Yüklenen verinin URL'sini al
                ref.downloadURL { url, _ in
                    completion(url)
                }
            }
        }.resume() // Veri görevini başlat
    }
}


