//
//  BankAccountController.swift
//  MoneyMan
//
//  Created by Alikadev on 06.04.23.
//

import SwiftUI

struct BankAccountController
{
	var bankAccounts: [BankAccount] = []
	
	mutating func add_bank_account(name: String) -> Void
	{
		print("BankAccountView request to add a BankAccount")
		if !Model.add_bank_account(bankAccounts: &bankAccounts, name: name)
		{
			print("Fail to add bank account")
		}
	}
	
	func get_bank_account_balance(name: String) -> Float
	{
		print("BankAccountView request to get BankAccount balance")
		return Model.calculate_bank_account_balance(bankAccount: Model.get_bank_account(bankAccounts: bankAccounts, name: name) ?? BankAccount(name: "No Bank Account"))
	}
}


