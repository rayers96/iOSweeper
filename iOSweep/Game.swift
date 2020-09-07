//
//  Game.swift
//  iOSweep
//
//  Created by Ryan Ayers on 9/6/20.
//  Copyright © 2020 Ryan Ayers. All rights reserved.
//

import Foundation

class Game {
  private var board : Board
  private var flags : Int
  
  init() {
    board = Board()
    flags = 0
  }
  
  // Return Response without taking action
  func get() -> Response {
    var response = Response()
    for i in 0...board.size-1 {
      for j in 0...board.size-1 {
        if (board.tileAt(x: i, y: j).mine) {
          response.textureMap[i][j] = 1
        }
      }
    }
    return response
  }
  func flip(x: Int, y: Int) -> Response {
    // flip tile logic
    return Response()
  }
  func toggleFlag(x: Int, y: Int) -> Response {
    // flag tile logic
    flags += 1
    flags -= 1
    return Response()
  }
  
  struct Response {
    var textureMap : [[Int]] = Array(repeating: Array(repeating: 0, count: 10), count: 10)
    var status : Int = 1
  }
}
