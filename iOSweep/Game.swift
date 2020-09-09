//
//  Game.swift
//  iOSweep
//
//  Created by Ryan Ayers on 9/6/20.
//  Copyright © 2020 Ryan Ayers. All rights reserved.
//

import Foundation

class Game {
  private var viewController : ViewController
  private var board : Board
  private var status : Int // -1 = loss, 0 = continue, 1 = win
  private var flips : Int
  private var flags : Int
  
  init(viewController: ViewController) {
    board = Board()
    status = 0
    flips = 0
    flags = 0
    self.viewController = viewController
    gen()
    respond()
  }
  
  func flip(x: Int, y: Int) {
    if (validateXY(x: x, y: y)) {
      if (board.b[x][y].mine) {
        board.b[x][y].flipped = true
        status = -1
      } else if (!board.b[x][y].flipped && !board.b[x][y].flagged) {
        board.b[x][y].flipped = true
        flips += 1
        if ((board.size*board.size) - flips == board.mines) {
          status = 1
        } else if (board.b[x][y].adj == 0) {
          flipAdj(x: x, y: y)
        }
      }
      respond()
    }
  }
  func toggleFlag(x: Int, y: Int) {
    if (validateXY(x: x, y: y)) {
      if (board.b[x][y].flagged) {
        board.b[x][y].flagged = false
        flags -= 1
      } else if (!(flags == board.mines) && !board.b[x][y].flipped) {
        board.b[x][y].flagged = true
        flags += 1
      }
      respond()
    }
  }
  // Return Response without taking action
  func get() {
    respond()
  }
  
  // Generate response and update viewController
  private func respond() {
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
    viewController.updateView(r: response)
  }
  
  // Helper

  private func validateXY(x: Int, y: Int) -> Bool {
    let validX = x >= 0 && x < board.size
    let validY = y >= 0 && y < board.size
    return (validX && validY)
  }
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
  
  // Generation
  
  private func gen() {
    // Generate mines and inc adjacent tiles
    var a = [Int](repeating: 0, count: board.size*board.size)
    for i in 0...(board.size*board.size) - 1 {
      a[i] = i
    }
    a.shuffle()
    for i in 0...board.mines-1 {
      let x = a[i] % board.size
      let y = a[i] / board.size
      board.b[x][y].mine = true
      incAdj(x: x, y: y)
    }
  }
  private func incAdj(x: Int, y: Int) {
    for i in (x-1)...(x+1) {
      for j in (y-1)...(y+1) {
        let validI = i >= 0 && i < board.size
        let validJ = j >= 0 && j < board.size
        if (validI && validJ && (i != x || y != j)) {
          board.b[i][j].adj += 1
        }
      }
    }
  }
}
