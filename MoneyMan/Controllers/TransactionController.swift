//
//  TransactionController.swift
//  MoneyMan
//
//  Created by Alikadev on 07.04.23.
//

import Foundation

struct TransactionController
{
	var bankAccount : BankAccount
	
	init(name : String) {
		for bankAccount in bankAccounts
		{
			if(bankAccount.name == name)
			{
				self.bankAccount = bankAccount
				return
			}
		}
		self.bankAccount = BankAccount(name: name)
		bankAccounts.append(self.bankAccount)
	}
}
