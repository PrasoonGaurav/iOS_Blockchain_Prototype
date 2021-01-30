//
//  Blockchain.swift
//  BlockChainDemoApp
//
//  Created by Prasoon Gaurav on 30/01/21.
//

import UIKit

class Blockchain {
    //logic for the Blockchain here
    
    var chain = [Block]()
    
    func createInitialBlock(data:String) {
        let genesisBlock = Block()
        genesisBlock.hashValue = genesisBlock.generateHashValue()
        genesisBlock.data = data
        genesisBlock.previousHashValue = "0000"
        genesisBlock.index = 0
        chain.append(genesisBlock)
    }
    
    func createBlock(data:String) {
        let newBlock = Block()
        newBlock.hashValue = newBlock.generateHashValue()
        newBlock.data = data
        newBlock.previousHashValue = chain[chain.count-1].hashValue
        newBlock.index = chain.count
        chain.append(newBlock)
    }
    
    
}
