//
//  BankAccount.swift
//  MoneyMan
//
//  Created by Alikadev on 13.04.23.
//

import Foundation

class BankAccount: ObservableObject, Codable, Identifiable
{
	public var name: String
	public var transactions : [Transaction]
	
	init(name: String,
		 transactions: [Transaction] = [])
	{
		self.name = name
		self.transactions = transactions
	}
}
