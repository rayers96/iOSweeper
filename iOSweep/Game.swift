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
  
  func flip(x: Int, y: Int) -> Response {
    if (board.b[x][y].mine) {
      board.b[x][y].flipped = true
      return genResponse(status: -1)
    } else if (!board.b[x][y].flipped && !board.b[x][y].flagged) {
      board.b[x][y].flipped = true
      flips += 1
      if ((board.size*board.size) - flips == board.mines) {
        return genResponse(status: 1)
      } else if (board.b[x][y].adj == 0) {
        flipAdj(x: x, y: y)
      }
    }
    return genResponse(status: 0)
  }
  func toggleFlag(x: Int, y: Int) -> Response {
    if (board.b[x][y].flagged) {
      board.b[x][y].flagged = false
      flags -= 1
    } else if (!(flags == board.mines) && !board.b[x][y].flipped) {
      board.b[x][y].flagged = true
      flags += 1
    }
    return genResponse(status: 0)
  }
  // Return Response without taking action
  func get() -> Response {
    return genResponse(status: 0)
  }
  
  // Helper
  
  private func flipAdj(x: Int, y: Int) {
    for i in (x-1)...(x+1) {
      for j in (y-1)...(y+1) {
        let validI = i >= 0 && i < board.size
        let validJ = j >= 0 && j < board.size
        if (validI && validJ && (i != x || y != j)) {
          if (board.b[i][j].flipped) {
            continue
          } else {
            board.b[i][j].flipped = true
            flips += 1
            if (board.b[i][j].adj == 0) {
              flipAdj(x: i, y: j)
            }
          }
        }
      }
    }
  }
  private func genResponse(status: Int) -> Response {
    var response = Response(status: status)
    for i in 0...board.size-1 {
      for j in 0...board.size-1 {
        let t = board.b[i][j]
        if (t.flipped || status != 0) {
          if (t.mine) {
            response.textureMap[i][j] = 11
          } else {
            response.textureMap[i][j] = t.adj
          }
        } else if (t.flagged){
          response.textureMap[i][j] = 10
        }
      }
    }
    return response
  }
}
