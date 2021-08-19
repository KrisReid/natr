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
        request.setValue("key=AAAA5qzFXlM:APA91bH7Ff7iQdh-jmuGt5F6d0unILoPejZfpVSlxjmTNBQsmAH6LYlQy6SQK4AB5NOOl_DuMlhvDMFX8MCPALoMQsydovzwcnNchKY3rmvy6Au4u40ngum3r2ARGJnbFl-QEFPwgDnt", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject:jsonObject, options: [.prettyPrinted, .fragmentsAllowed])
        
//        do {
//            let requestBody = try JSONSerialization.data(withJSONObject: jsonObject, options: .fragmentsAllowed)
//            request.httpBody = requestBody
//        }
//        catch {
//            print("Error creating the data object from the json")
//        }

        

        //Create the data task
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error == nil && data != nil {
                do {
//                    let dictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String : Any]
                    let dictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : Any]
                    print(dictionary)
                }
                catch {
                    print("Error parsing the response data")
                    print(error)
                }
            }
        }

        //fire off the data task
        dataTask.resume()
        
        
        
        
        
        
        
//        let urlString = "https://fcm.googleapis.com/fcm/send"
//        let url = NSURL(string: urlString)!
//        let paramString: [String : Any] = ["to" : token, "notification" : ["title" : title, "body" : body], "data" : ["title" : title, "body" : body]]
//        let request = NSMutableURLRequest(url: url as URL)
//
//        request.httpMethod = "POST"
//        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.fragmentsAllowed, .prettyPrinted])
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("key=AAAA5qzFXlM:APA91bH7Ff7iQdh-jmuGt5F6d0unILoPejZfpVSlxjmTNBQsmAH6LYlQy6SQK4AB5NOOl_DuMlhvDMFX8MCPALoMQsydovzwcnNchKY3rmvy6Au4u40ngum3r2ARGJnbFl-QEFPwgDnt", forHTTPHeaderField: "Authorization")
//        let task =  URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
//            do {
//                if let jsonData = data {
////                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
//                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String: Any] {
//                        print("33333333333333")
//                        print(jsonDataDict)
//                    }
//                }
//            } catch let err as NSError {
//                print("555555555555")
//                print(err.localizedDescription)
//            }
//        }
//        task.resume()
        
        
        
    }
    
}
