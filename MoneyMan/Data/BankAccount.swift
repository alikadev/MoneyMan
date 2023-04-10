//
//  BankAccount.swift
//  MoneyMan
//
//  Created by Alikadev on 06.04.23.
//

import SwiftUI

struct TransactionDescriptor: Codable {
	var name: String
	var value = Float()
}

struct BankAccount: Codable {
	var name: String
	var transactions: [TransactionDescriptor] = []
}
