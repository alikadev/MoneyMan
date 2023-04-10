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
	var bankAccounts : [BankAccount]
	var shouldGoBack = false
	
	init(bankAccounts : inout [BankAccount], name : String)
	{
		self.bankAccounts = bankAccounts
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
	
	mutating func go_back()
	{
		print("TransactionView request to go back")
		shouldGoBack = true
	}
	
	mutating func rename_bank_account(name: String)
	{
		print("TransactionView request to rename BankAccount to",name)
		Model.rename_bank_account(bankAccounts: &bankAccounts, oldName: bankAccount.name, newName: name)
		bankAccount.name = name
	}
	
	mutating func remove_bank_account()
	{
		print("TransactionView request to delete BankAccount")
		if !Model.delete_bank_acocunt(bankAccounts: &bankAccounts, name: bankAccount.name)
		{
			print("Fail to remove bank account")
			return
		}
		
		shouldGoBack = true
	}
}
