//
//  APIClient.swift
//  URLSessionStubDemo
//
//  Created by dasdom on 04.01.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation
import DHURLSessionStub

class APIClient {
  lazy var session: DHURLSession = NSURLSession.sharedSession()
  
  func fetchProfileWithName(name: String, completion: (user: User?, error: ErrorType?) -> Void) {
    guard let url = NSURL(string: "https://api.github.com/users/\(name)") else { fatalError() }
    session.dataTaskWithURL(url) { (data, response, error) -> Void in
      if let data = data {
        do {
          let rawDict = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:AnyObject]
          
          if let name = rawDict["login"] as? String,
            id = rawDict["id"] as? Int {
            let user = User(name: name, id: id)
            completion(user: user, error: nil)
          }
        } catch {
          completion(user: nil, error: error)
        }
      }
      }.resume()
  }
}