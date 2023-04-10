//
//  BankAccount.swift
//  MoneyMan
//
//  Created by Alikadev on 06.04.23.
//

import SwiftUI

struct TransactionDescriptor: Codable {
	var date: Date
	var name: String
	var value: Float
	var comment: String
	
	init(name: String, value: Float, date : Date = Date.now, comment: String = "")
	{
		self.name = name
		self.value = value
		self.date = date
		self.comment = comment
	}
}

struct BankAccount: Codable {
	var name: String
	var transactions: [TransactionDescriptor] = [TransactionDescriptor(name: "Example", value: 2)]
}
