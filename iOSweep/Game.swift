//
//  Game.swift
//  iOSweep
//
//  Created by Ryan Ayers on 9/6/20.
//  Copyright © 2020 Ryan Ayers. All rights reserved.
//

import Foundation

class Game {
  private var b : Board
  
  init() {
    b = Board()
  }
  
  // Return Response without taking action
  func get() -> Response {
    return Response()
  }
  func flip(x: Int, y: Int) -> Response {
    // flip tile logic
    return Response()
  }
  func flag(x: Int, y: Int) -> Response {
    // flag tile logic
    return Response()
  }
  func unflag(x: Int, y: Int) -> Response {
    // unflag tile logic (combine w/ flag)??
    return Response()
  }
  
  struct Response {
    var textureMap : [[Int]]?
    var status : Int?
    
    init() {
      textureMap = Array(repeating: Array(repeating: 0, count: 10), count: 10)
      status = 0
      
      // Generate response
    }
  }
}
