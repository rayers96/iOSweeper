//
//  Response.swift
//  iOSweep
//
//  Created by Ryan Ayers on 9/7/20.
//  Copyright © 2020 Ryan Ayers. All rights reserved.
//

struct Response {
  var textureMap : [[Int]] = Array(repeating: Array(repeating: 9, count: 10), count: 10)
  var status : Int = 0 // 0 = continue, 1 = win, -1 lose
  
  init(board : Board, status: Int) {
    self.status = status
    for i in 0...board.size-1 {
      for j in 0...board.size-1 {
        let t = board.b[i][j]
        if (t.flipped || status != 0) {
          if (t.mine) {
            textureMap[i][j] = 11
          } else {
            textureMap[i][j] = t.adj
          }
        } else if (t.flagged){
          textureMap[i][j] = 10
        }
      }
    }
  }
}
