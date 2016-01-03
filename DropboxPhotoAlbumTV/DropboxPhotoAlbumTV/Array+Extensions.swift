//
//  Array+Extensions.swift
//  DropboxMediaKit
//
//  Created by Garrett Richards on 1/1/16.
//  Copyright © 2016 bluwave. All rights reserved.
//

import Foundation

extension Array {
    public func randomItem() -> Element? {
        if(self.count > 0) {
            let randomIndex = Int(arc4random_uniform(UInt32(self.count)))
            return self[randomIndex]
        }
        return nil
    }
}