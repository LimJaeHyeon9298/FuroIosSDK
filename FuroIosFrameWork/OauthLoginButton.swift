//
//  OauthLoginButton.swift
//  FuroIosFrameWork
//
//  Created by 임재현 on 2023/07/12.
//

import Foundation
import UIKit



public enum OAtuhType {
    case google
    case kakao
    case naver
}




public func loginForGoogle() {
    
    getOauth2(clientId:CLIEINT_ID , apiKey: PUBLIC_API_KEY, oauthType: .google) { str, error in
        if let error = error {
            print("Error occurred: \(error.localizedDescription)")
            return
        }
    
        guard let str2 = str else {
            print("Error: Received nil data or invalid URL")
            return
        }
    
        let str2WithoutQuotes = str2.replacingOccurrences(of: "\"", with: "")
        guard let url = URL(string: str2WithoutQuotes) else {
            print("Error: Invalid URL String")
            return
        }
    
        print("URL is \(url.absoluteString)")
    
    
        DispatchQueue.main.async {
            if let url2 = URL(string: "\(url)") {
                UIApplication.shared.open(url2)
            }
        }
    }
    
}


public func loginForKaKao() {
    
    getOauth2(clientId:CLIEINT_ID , apiKey: PUBLIC_API_KEY, oauthType: .kakao) { str, error in
        if let error = error {
            print("Error occurred: \(error.localizedDescription)")
            return
        }
    
        guard let str2 = str else {
            print("Error: Received nil data or invalid URL")
            return
        }
    
        let str2WithoutQuotes = str2.replacingOccurrences(of: "\"", with: "")
        guard let url = URL(string: str2WithoutQuotes) else {
            print("Error: Invalid URL String")
            return
        }
    
        print("URL is \(url.absoluteString)")
    
    
        DispatchQueue.main.async {
            if let url2 = URL(string: "\(url)") {
                UIApplication.shared.open(url2)
            }
        }
    }
}






public func loginForNaver() {
    
    getOauth2(clientId:CLIEINT_ID , apiKey: PUBLIC_API_KEY, oauthType: .naver) { str, error in
        if let error = error {
            print("Error occurred: \(error.localizedDescription)")
            return
        }
    
        guard let str2 = str else {
            print("Error: Received nil data or invalid URL")
            return
        }
    
        let str2WithoutQuotes = str2.replacingOccurrences(of: "\"", with: "")
        guard let url = URL(string: str2WithoutQuotes) else {
            print("Error: Invalid URL String")
            return
        }
    
        print("URL is \(url.absoluteString)")
    
    
        DispatchQueue.main.async {
            if let url2 = URL(string: "\(url)") {
                UIApplication.shared.open(url2)
            }
        }
    }
    
}






public func getOauth2(clientId: String, apiKey: String, oauthType: OAtuhType, completion: @escaping (String?, Error?) -> Void) {

    let authString = "\(clientId):\(apiKey)"
    let authData = authString.data(using: .utf8)!
    let authValue = "Basic \(authData.base64EncodedString())"

    var request = URLRequest(url: URL(string: "https://api.furo.one/oauth/\(oauthType)")!)
    request.setValue(authValue, forHTTPHeaderField: "Authorization")
    // Authorization
    URLSession.shared.dataTask(with: request) { data, response, error in
        // If an error occurred, call completion with the error and return
        if let error = error {
            completion(nil, error)
            return
        }

        // If no data was received, call completion with an error and return
        guard let data = data else {
            completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
            return
        }

        // Convert data to a string and call completion with the string
        let str = String(decoding: data, as: UTF8.self)

        completion(str, nil)
    }.resume()
    // Your getOauth2 method and other methods go here
}







public func createMagicLink(email: String, completion: @escaping (Bool) -> Void) {
    let url = URL(string: "https://api.furo.one/magic_links/email/login_or_create")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    let clientId = CLIEINT_ID
    let apiKey = PUBLIC_API_KEY
    let authString = "\(clientId):\(apiKey)"
    let authData = authString.data(using: .utf8)!
    let authValue = "Basic \(authData.base64EncodedString())"
    request.setValue(authValue, forHTTPHeaderField: "Authorization")

    let parameters: [String: Any] = ["email": email]
    request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print("Error: \(error)")
            completion(false)  // Call the completion handler with `false` if there was an error
        } else if let data = data {
            print("Response: \(String(data: data, encoding: .utf8) ?? "")")
            completion(true)  // Call the completion handler with `true` if the request was successful
        } else {
            completion(false)  // Call the completion handler with `false` if no data was received
        }
    }
    task.resume()
}


public func furoWebViewLogin() {
    
    guard let url = URL(string: "https://auth.furo.one/login/\(CLIEINT_ID)") else {
        return
    }
    
    //  Check if the url can be opened
    if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
       
        
        
    }
    
}
