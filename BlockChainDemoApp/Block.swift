//
//  Block.swift
//  BlockChainDemoApp
//
//  Created by Prasoon Gaurav on 30/01/21.
//

import UIKit
class Block{
    // logic for Block here
    var hashValue: String!
    var data: String!
    var previousHashValue: String!
    var index: Int!
    
    func generateHashValue() -> String {
        return UUID().uuidString.replacingOccurrences(of: "-", with: "")
    }
}
