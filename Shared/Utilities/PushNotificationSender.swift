//
//  PushNotificationSender.swift
//  natr
//
//  Created by Kris Reid on 05/08/2021.
//

import Foundation

class PushNotificationSender {
    
    func sendPushNotification(to token: String, title: String, body: String) {
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = ["to" : token,
                                           "notification" : ["title" : title, "body" : body],
                                           "data" : ["user" : "test_id"]
        ]
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=AAA5qzFXlM:APA91bH7Ff7iQdh-jmuGt5F6d0unILoPejZfpVSlxjmTNBQsmAH6LYlQy6SQK4AB5NOOl_DuMlhvDMFX8MCPALoMQsydovzwcnNchKY3rmvy6Au4u40ngum3r2ARGJnbFl-QEFPwgDnt", forHTTPHeaderField: "Authorization")
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print("4444444444444444")
                print(err.localizedDescription)
            }
        }
        task.resume()
    }
    
}
