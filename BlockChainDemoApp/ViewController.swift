//
//  ViewController.swift
//  BlockChainDemoApp
//
//  Created by Prasoon Gaurav on 30/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    let firstAccount = 1010
    let secondAccount = 1011
    let bitcoinChain = Blockchain()
    let reward = 100
    var accounts: [String: Int] = ["0000" : 1000000]
    let invalidAlert = UIAlertController(title: "Invalid Transaction", message: "Please check the details of your transaction", preferredStyle: .alert)
    
    @IBOutlet weak var yellowAmount: UITextField!
    @IBOutlet weak var blueAmount: UITextField!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var yellowLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transaction(from: "0000", to: "\(firstAccount)", amount: 50, type: "genesis")
        transaction(from: "\(firstAccount)", to: "\(secondAccount)", amount: 10, type: "normal")
        chainState()
        self.invalidAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
    
    func transaction(from: String, to: String, amount: Int, type: String) {
        if accounts[from] == nil {
            self.present(invalidAlert, animated: true, completion: nil)
            return
        }
        else if accounts[from]!-amount < 0 {
            self.present(invalidAlert, animated: true, completion: nil)
            return
        }
        else {
            accounts.updateValue(accounts[from]!-amount, forKey: from)
        }
        
        // to check 2 account
        if accounts[to] == nil {
            accounts.updateValue(amount, forKey: to)
        } else {
            accounts.updateValue(accounts[from]!-amount, forKey: to)
        }
        
        //
        if type == "genesis" {
            bitcoinChain.createInitialBlock(data: "From: \(from); To: \(to); Amount: \(amount) BTC")
            
        } else if type == "normal" {
            bitcoinChain.createBlock(data: "From: \(from); To: \(to); Amount: \(amount) BTC")
        }
    }
    
    
    func chainState() {
        for i in 0...bitcoinChain.chain.count-1 {
            print("\tBlock: \(bitcoinChain.chain[i].index!)\n\tHash: \(bitcoinChain.chain[i].hashValue!)\n\tPreviousHash: \(bitcoinChain.chain[i].previousHashValue!)\n\tData: \(bitcoinChain.chain[i].data!)")
        }
        blueLabel.text = "Balance: \(accounts[String(describing: firstAccount)]!) BTC"
        yellowLabel.text = "Balance: \(accounts[String(describing: secondAccount)]!) BTC"
        print(accounts)
        print(chainValidity())
    }
    
    func chainValidity() -> String {
        var isChainValid = true
        for i in 1...bitcoinChain.chain.count-1 {
            if bitcoinChain.chain[i].previousHashValue != bitcoinChain.chain[i-1].hashValue {
                isChainValid = false
            }
        }
        return "Chain is valid: \(isChainValid)\n"
    }
    
    
    @IBAction func blueMine(_ sender: UIButton) {
        transaction(from: "0000", to: "\(firstAccount)", amount: 100, type: "normal")
        print("New block mined by: \(firstAccount)")
        chainState()
    }
    
    @IBAction func yellowMine(_ sender: UIButton) {
        transaction(from: "0000", to: "\(secondAccount)", amount: 100, type: "normal")
        print("New block mined by: \(secondAccount)")
        chainState()
    }
    
    @IBAction func blueSend(_ sender: UIButton) {
        if blueAmount.text == "" {
            present(invalidAlert, animated: true, completion: nil)
        } else {
            transaction(from: "\(firstAccount)", to: "\(secondAccount)", amount: Int(blueAmount.text!)!, type: "normal")
            print("\(blueAmount.text!) BTC sent from \(firstAccount) to \(secondAccount)")
            chainState()
            blueAmount.text = ""
        }
    }
    
    @IBAction func yellowSend(_ sender: UIButton) {
        if yellowAmount.text == "" {
            present(invalidAlert, animated: true, completion: nil)
        } else {
            transaction(from: "\(secondAccount)", to: "\(firstAccount)", amount: Int(yellowAmount.text!)!, type: "normal")
            print("\(yellowAmount.text!) BTC sent from \(secondAccount) to \(firstAccount)")
            chainState()
            yellowAmount.text = ""
        }
    }
    
    
}

extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
