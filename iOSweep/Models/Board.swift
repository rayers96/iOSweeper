//
//  Board.swift
//  iOSweep
//
//  Created by Ryan Ayers on 9/6/20.
//  Copyright © 2020 Ryan Ayers. All rights reserved.
//

import Foundation

class Board {
  var b : [[Tile]]
  var size : Int
  var mines : Int
  
  init() {
    size = 10
    mines = 20
    b = Array(repeating: Array(repeating: Tile(), count: size), count: size)
    gen()
  }
  
  private func gen() {
    // Generate mines and inc adjacent tiles
  }
}
