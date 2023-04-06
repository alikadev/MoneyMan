//
//  BankAccountController.swift
//  MoneyMan
//
//  Created by Alikadev on 06.04.23.
//

import SwiftUI

struct BankAccountController
{
	func addBankAccount(name: String) -> Void
	{
		print("Request add bank account with name",name)
		bankAccounts.append(BankAccount(name:name))
	}
	
	func loadBankAccount(name: String) -> Void
	{
		print("Request load account with name",name)
		for account in bankAccounts
		{
			if(account.name == name)
			{
				viewState = ViewState.TransactionSelector
				print("View is loaded ", viewState)
				return
			}
		}
		print("E: Fail to found account")
	}
}

