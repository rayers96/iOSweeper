//
//  Board.swift
//  iOSweep
//
//  Created by Ryan Ayers on 9/6/20.
//  Copyright © 2020 Ryan Ayers. All rights reserved.
//

import Foundation

struct Board {
  var b : [[Tile]] = Array(repeating: Array(repeating: Tile(), count: 10), count: 10)
  let size : Int = 10
  let mines : Int = 20
}
