//
//  User.swift
//  URLSessionStubDemo
//
//  Created by dasdom on 05.01.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

struct User: Equatable {
  let name: String
  let id: Int
}

func ==(lhs: User, rhs: User) -> Bool {
  guard lhs.name == rhs.name else { return false }
  guard lhs.id == rhs.id else { return false }
  
  return true
}