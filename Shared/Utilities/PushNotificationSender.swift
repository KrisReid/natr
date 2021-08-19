//
//  PushNotificationSender.swift
//  natr
//
//  Created by Kris Reid on 05/08/2021.
//

import Foundation

class PushNotificationSender {
    
    func sendPushNotification(to token: String, title: String, body: String) {
        
        //Set the URL
        let url = URL(string: "https://fcm.googleapis.com/fcm/send")
        guard url != nil else { return }
        
        //Specifiy the body
        let jsonObject: [String : Any] = ["to" : token, "notification" : ["title" : title, "body" : body, "content_available" : true, "priority" : "high"], "data" : ["title" : title, "body" : body, "content_available" : true, "priority" : "high"]]
        
        // Set the request information
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("123456", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject:jsonObject, options: [.prettyPrinted, .fragmentsAllowed])
        
        //Create the data task
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error == nil && data != nil {
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : Any]
                    NSLog("Received data:\n\(dictionary))")
                }
                catch {
                    print("Error parsing the response data")
                    print(error)
                }
            }
        }
        
        //fire off the data task
        dataTask.resume()
    }
}
