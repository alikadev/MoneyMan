//
//  User.swift
//  MoneyMan
//
//  Created by Alikadev on 06.06.23.
//

import Foundation

class Account: Codable, Identifiable
{
	var bankAccounts: [BankAccount]
	
	init(bankAccounts: [BankAccount] = []) {
		self.bankAccounts = bankAccounts
	}
}
