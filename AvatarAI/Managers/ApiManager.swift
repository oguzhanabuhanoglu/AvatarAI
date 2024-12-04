//
//  ApiManager.swift
//  AvatarAI
//
//  Created by Oğuzhan Abuhanoğlu on 28.11.2024.
//

import Foundation
import UIKit
import NeonSDK

class APIManager {
    
    static func eachlabsStartTask(prompt: String, size: String, completion: @escaping (String?) -> Void) {
        
        NeonEachLabsManager.startTask(
            apiKey: "API KEY",
            flowId: "FLOW ID",
            parameters: [
                "prompt": prompt,
                "aspect_ratio": size
            ]
        ) { triggerId in
            if let triggerId = triggerId {
                completion(triggerId)
            } else {
                completion(nil)
                print("ERROR TRIGGER ID")
            }
        }
    }
    
    static func eachlabsGettingStatus(triggerId: String, completion: @escaping (String?) -> Void) {
        NeonEachLabsManager.getStatus(apiKey: "MP10195QPQ48MTJWUAL8HSDHG19TZ8GUSNG5",
                                      flowId: "8977a340-8862-49a3-8ec4-da4cdc360339",
                                      triggerId: triggerId) { json in
            if let json = json,
               let stepResults = json["step_results"] as? [[String: Any]],
               let firstResult = stepResults.first,
               let output = firstResult["output"] as? String {
                completion(output) // Görsel URL'sini döndür
            } else {
                print("Output not found or empty in JSON")
                completion(nil)
            }
        }
    }
}
