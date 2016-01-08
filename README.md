# DHURLSessionStub

[![CI Status](http://img.shields.io/travis/Dominik Hauser/DHURLSessionStub.svg?style=flat)](https://travis-ci.org/Dominik Hauser/DHURLSessionStub)
[![Version](https://img.shields.io/cocoapods/v/DHURLSessionStub.svg?style=flat)](http://cocoapods.org/pods/DHURLSessionStub)
[![License](https://img.shields.io/cocoapods/l/DHURLSessionStub.svg?style=flat)](http://cocoapods.org/pods/DHURLSessionStub)
[![Platform](https://img.shields.io/cocoapods/p/DHURLSessionStub.svg?style=flat)](http://cocoapods.org/pods/DHURLSessionStub)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Stubbing NSURLSessions Data Task

1. Import the DHURLSessionStub (`import DHURLSessionStub`) in the file where you want to use `NSURLSession`. (In the example project, this is `ApiClient.swift`.
2. Use a lazy variable for the session to allow dependency injection in the test: `lazy var session: DHURLSession = NSURLSession.sharedSession()`.
3. Use `dataTaskWithURL` and `dataTaskWithRequest` as you always did.

Then you can stub your data tasks in your tests by assigning a URLSessionMock to the lazy session property you defined in step 2:

```swift
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
```

Have a look at the example project for a complete picture how this works.

## How it works

It's quite easy. The URLSessionMock captures the completion handler of the data task. When the production code calls resume on the data task, the mock then calls the completion handler with the parameters given in the initializer. Have a look! The complete file only has 42 lines of code.

## Requirements

iOS 8.3

## Installation

DHURLSessionStub is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DHURLSessionStub"
```

Alternatively, download [DHURLSessionMock](https://github.com/dasdom/DHURLSessionStub/blob/master/Pod/Classes/DHURLSessionMock.swift) and put it into your app target (not the test target!).

## Author

Dominik Hauser, dominik.hauser@dasdom.de

## License

DHURLSessionStub is available under the MIT license. See the LICENSE file for more info.
