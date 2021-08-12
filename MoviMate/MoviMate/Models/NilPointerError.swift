//
//  NilPointerError.swift
//  MoviMate
//
//  Created by Roman Alikevich on 11.08.21.
//

import Foundation

enum NilPointerError: Error {
    case invalidRequest(message: String)
}
