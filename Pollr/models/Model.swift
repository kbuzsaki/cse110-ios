//
//  Model.swift
//  Pollr
//
//  Created by Ran Tao on 5/15/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import Foundation

protocol Model {
    var id: Int? { get set }
    var inflated: Bool { get }
    func inflate() -> NSError?
    func refresh() -> NSError?
}