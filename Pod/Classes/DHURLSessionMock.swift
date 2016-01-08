//
//  DHURLSessionProtocol.swift
//  URLSessionStubDemo
//
//  Created by dasdom on 05.01.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

public protocol DHURLSession {
  func dataTaskWithURL(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask
  func dataTaskWithRequest(request: NSURLRequest, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask
}

extension NSURLSession: DHURLSession { }

public final class URLSessionMock : DHURLSession {
  
  var url: NSURL?
  var request: NSURLRequest?
  private let dataTaskMock: URLSessionDataTaskMock
  
  public init(data: NSData?, response: NSURLResponse?, error: NSError?) {
    dataTaskMock = URLSessionDataTaskMock()
    dataTaskMock.taskResponse = (data, response, error)
  }
  
  public func dataTaskWithURL(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
    self.url = url
    self.dataTaskMock.completionHandler = completionHandler
    return self.dataTaskMock
  }
  
  public func dataTaskWithRequest(request: NSURLRequest, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
    self.request = request
    self.dataTaskMock.completionHandler = completionHandler
    return self.dataTaskMock
  }
  
  final private class URLSessionDataTaskMock : NSURLSessionDataTask {
    
    typealias CompletionHandler = (NSData!, NSURLResponse!, NSError!) -> Void
    var completionHandler: CompletionHandler?
    var taskResponse: (NSData?, NSURLResponse?, NSError?)?
    
    override func resume() {
      completionHandler?(taskResponse?.0, taskResponse?.1, taskResponse?.2)
    }
  }
}