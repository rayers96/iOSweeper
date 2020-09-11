//
//  iOSweepTests.swift
//  iOSweepTests
//
//  Created by Ryan Ayers on 9/5/20.
//  Copyright © 2020 Ryan Ayers. All rights reserved.
//

import XCTest
@testable import iOSweep

class iOSweepTests: XCTestCase {
  
  var game : Game! = nil
  
    override func setUpWithError() throws {
      game = Game()
    }
    override func tearDownWithError() throws {
      game = nil
    }
  
    func testFlip() throws {
      let x = Int.random(in: 0...9)
      let y = Int.random(in: 0...9)
      let response1 = game.get()
      XCTAssert(response1.textureMap[x][y] == 9)
      let response2 = game.flip(x: x, y: y)
      XCTAssert((0...8).contains(response2.textureMap[x][y]))
    }
    func testFlag() throws {
      let x = Int.random(in: 0...9)
      let y = Int.random(in: 0...9)
      let response1 = game.get()
      XCTAssert(response1.textureMap[x][y] != 10)
      let response2 = game.toggleFlag(x: x, y: y)
      XCTAssert(response2.textureMap[x][y] == 10)
      let response3 = game.toggleFlag(x: x, y: y)
      XCTAssert(response3.textureMap[x][y] != 10)
    }
}
