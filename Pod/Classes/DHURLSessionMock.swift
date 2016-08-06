//
//  DHURLSessionProtocol.swift
//  URLSessionStubDemo
//
//  Created by dasdom on 05.01.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

public protocol DHURLSession {
  func dataTaskWithURL(url: NSURL,
    completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask
  func dataTaskWithRequest(request: NSURLRequest,
    completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask
}

extension NSURLSession: DHURLSession { }

public final class URLSessionMock : DHURLSession {
  
  var url: NSURL?
  var request: NSURLRequest?
  private let dataTaskMock: URLSessionDataTaskMock
  
  public convenience init?(jsonDict: [String: AnyObject], response: NSURLResponse? = nil, error: NSError? = nil) {
    guard let data = try? NSJSONSerialization.dataWithJSONObject(jsonDict, options: []) else { return nil }
    self.init(data: data, response: response, error: error)
  }
  
  public init(data: NSData? = nil, response: NSURLResponse? = nil, error: NSError? = nil) {
    dataTaskMock = URLSessionDataTaskMock()
    dataTaskMock.taskResponse = (data, response, error)
  }
  
  public func dataTaskWithURL(url: NSURL,
    completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
      self.url = url
      self.dataTaskMock.completionHandler = completionHandler
      return self.dataTaskMock
  }
  
  public func dataTaskWithRequest(request: NSURLRequest,
    completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
      self.request = request
      self.dataTaskMock.completionHandler = completionHandler
      return self.dataTaskMock
  }
  
  final private class URLSessionDataTaskMock : NSURLSessionDataTask {
    
    typealias CompletionHandler = (NSData!, NSURLResponse!, NSError!) -> Void
    var completionHandler: CompletionHandler?
    var taskResponse: (NSData?, NSURLResponse?, NSError?)?
    
    override func resume() {
      dispatch_async(dispatch_get_main_queue()) {
        self.completionHandler?(self.taskResponse?.0, self.taskResponse?.1, self.taskResponse?.2)
      }
    }
  }
}