//
//  Board.swift
//  iOSweep
//
//  Created by Ryan Ayers on 9/6/20.
//  Copyright © 2020 Ryan Ayers. All rights reserved.
//

import Foundation

class Board {
  var b : [[Tile]] = Array(repeating: Array(repeating: Tile(), count: 10), count: 10)
  let size : Int = 10
  let mines : Int = 20
  
  init() {
    gen()
  }
  
  // Helper

  private func gen() {
    // Generate mines and inc adjacent tiles
    var a = [Int](repeating: 0, count: size*size)
    for i in 0...(size*size) - 1 {
      a[i] = i
    }
    a.shuffle()
    for i in 0...mines-1 {
      let x = a[i] % size
      let y = a[i] / size
      b[x][y].mine = true
      incAdj(x: x, y: y)
    }
  }
  private func incAdj(x: Int, y: Int) {
    for i in (x-1)...(x+1) {
      for j in (y-1)...(y+1) {
        let validI = i >= 0 && i < size
        let validJ = j >= 0 && j < size
        if (validI && validJ && (i != x || y != j)) {
          b[i][j].adj += 1
        }
      }
    }
  }
}
