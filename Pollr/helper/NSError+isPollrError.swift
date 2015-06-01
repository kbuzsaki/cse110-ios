//
//  NSError+isPollrError.swift
//  Pollr
//
//  Created by Ran Tao on 5/31/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import Foundation

extension NSError {
    func isPollrError(code: Int) -> Bool {
        return domain == "Pollr" && self.code == code
    }
}