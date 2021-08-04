//
//  Character.swift
//  Accumulation
//
//  Created by cp3hnu on 2021/6/3.
//  Copyright © 2021 CP3. All rights reserved.
//

import Foundation

extension CharacterSet {
    /// url 允许的字符集，不需要转义
    static let urlAllowedCharacters = CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ").inverted
}
