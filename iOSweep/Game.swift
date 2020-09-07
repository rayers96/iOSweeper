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
  private var flips : Int
  private var flags : Int
  
  init() {
    board = Board()
    flips = 0
    flags = 0
  }
  
  struct Response {
    var textureMap : [[Int]] = Array(repeating: Array(repeating: 0, count: 10), count: 10)
    var status : Int = 1
  }
  
  // Return Response without taking action
  func get() -> Response {
    var response = Response()
    for i in 0...board.size-1 {
      for j in 0...board.size-1 {
        if (board.b[i][j].mine) {
          response.textureMap[i][j] = 1
        } else if (board.b[i][j].flipped) {
          response.textureMap[i][j] = 2
        }
      }
    }
    return response
  }
  func flip(x: Int, y: Int) -> Response {
    var response = get()
    if (board.b[x][y].flipped || board.b[x][y].flagged) {
      response.status = 0
    } else if (board.b[x][y].mine) {
      response.status = -1
    } else {
      board.b[x][y].flipped = true
      flips += 1
      response.textureMap[x][y] = 2
      if ((board.size*board.size) - flips == board.mines) {
        response.status = 2
      } else if (board.b[x][y].adj == 0) {
        flipAdj(x: x, y: y)
      }
    }
    return response
  }
  func toggleFlag(x: Int, y: Int) -> Response {
    // flag tile logic
    flags += 1
    flags -= 1
    return Response()
  }
  
  private func flipAdj(x: Int, y: Int) {
    for i in (x-1)...(x+1) {
      for j in (y-1)...(y+1) {
        let validI = i >= 0 && i < board.size
        let validJ = j >= 0 && j < board.size
        if (validI && validJ && (i != x || y != j)) {
          if (board.b[x][y].flipped) {
            continue
          } else {
            board.b[x][y].flipped = true
            flips += 1
            if (board.b[x][y].adj == 0) {
              flipAdj(x: i, y: j)
            }
          }
        }
      }
    }
  }
}
