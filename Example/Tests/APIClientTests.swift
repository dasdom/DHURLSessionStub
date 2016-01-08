//
//  APIClientTests.swift
//  URLSessionStubDemo
//
//  Created by dasdom on 04.01.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import UIKit
import XCTest
import DHURLSessionStub
@testable import DHURLSessionStub_Example

class APIClientTests: XCTestCase {
  
  var apiClient: APIClient!
  
  override func setUp() {
    super.setUp()
    apiClient = APIClient()
  }
  
  func testFetchingProfile_ReturnsPopulatedUser() {
    // Arrage
    let responseString = "{\"login\": \"dasdom\", \"id\": 1234567}"
    let responseData = responseString.dataUsingEncoding(NSUTF8StringEncoding)!
    let sessionMock = URLSessionMock(data: responseData, response: nil, error: nil)
    apiClient.session = sessionMock
    
    // Act
    apiClient.fetchProfileWithName("dasdom")
    
    // Assert
    let user = apiClient.user
    let expectedUser = User(name: "dasdom", id: 1234567)
    XCTAssertEqual(user, expectedUser)
  }
  
}

