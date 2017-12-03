//
//  PushNotificationServerClient.swift
//  Trigger Hunter
//
//  Created by Cal Stephens on 12/3/17.
//  Copyright © 2017 Mobile & Ubiquitous Computing 2017. All rights reserved.
//

import UIKit

class PushNotificationServerClient {
    
    static let serverEndpoint = URL(string: "http://server.calstephens.tech:8081/spawnTrigger")!
    
    static func spawnTrigger(_ trigger: Trigger, in room: Room) {
        
        let bodyJson = """
            {
                "triggerName": "\(trigger.name)",
                "alertText": "Watch out, \(trigger.spawnedText) just spawned \(room.locationText)!"
            }
            """
        
        var request = URLRequest(url: serverEndpoint)
        request.httpMethod = "POST"
        request.httpBody = bodyJson.data(using: .utf8)
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        URLSession.shared.dataTask(with: request).resume()
    }
    
}


