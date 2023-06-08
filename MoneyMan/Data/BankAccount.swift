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
	
	func insert(transaction: Transaction)
	{
		transactions.append(transaction)
		// Re-sort transaction by date
		transactions = transactions.sorted {
			$0.date > $1.date
		}
	}
	
	func remove(transaction: Transaction)
	{
		transactions = transactions.filter({
			$0.id != transaction.id
		})
	}
	
	func contrains(transaction: Transaction) -> Bool {
		return !transactions.filter({
			$0.id == transaction.id
		}).isEmpty
	}
}
