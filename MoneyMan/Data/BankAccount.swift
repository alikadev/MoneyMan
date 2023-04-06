//
//  BankAccount.swift
//  MoneyMan
//
//  Created by Alikadev on 06.04.23.
//

import SwiftUI

struct TransactionDescriptor {
	var name: String
	var value = Float()
}

struct BankAccount {
	var name: String
	@State var transactions: [Date:TransactionDescriptor] = [:]
}

var bankAccounts: [BankAccount] = [BankAccount(name: "test1"),BankAccount(name: "test2")]
