//
//  Model.swift
//  MoneyMan
//
//  Created by Alikadev on 06.04.23.
//

import SwiftUI

class Model
{
	struct keys
	{
		static let bankAccountList = "BankAccounts"
	}
	
	static func save_bank_accounts(bankAccounts: [BankAccount]) -> Bool
	{
		let defaults = UserDefaults.standard
		
		do {
			let data = try JSONEncoder().encode(bankAccounts)
			
			defaults.set(data, forKey: keys.bankAccountList)
			
			return true
		} catch {
			return false
		}
	}
	
	static func load_bank_accounts(bankAccounts: inout [BankAccount]) -> Bool
	{
		let defaults = UserDefaults.standard
		
		do {
			if let savedData = defaults.object(forKey: keys.bankAccountList) {
				bankAccounts = try JSONDecoder().decode([BankAccount].self, from: savedData as! Data)
				return true
			} else {
			}
		} catch {
		}
		return false
		
	}
	
	static func add_bank_account(bankAccounts: inout [BankAccount], name: String) -> Bool
	{
		bankAccounts.append(BankAccount(name:name))
		print(bankAccounts)
		
		return Model.save_bank_accounts(bankAccounts: bankAccounts)
	}
	
	static func delete_bank_acocunt(bankAccounts: inout [BankAccount], name: String) -> Bool
	{
		let before = bankAccounts.count
		
		bankAccounts = bankAccounts.filter{ $0.name != name }
		
		if(before == bankAccounts.count) {
			return false
		}
		
		return Model.save_bank_accounts(bankAccounts: bankAccounts)
	}
	
	static func get_bank_account(bankAccounts: [BankAccount], name: String) -> BankAccount?
	{
		for account in bankAccounts {
			if(account.name == name)
			{
				return account
			}
		}
		return nil
	}
	
	static func calculate_bank_account_balance(bankAccount: BankAccount) -> Float
	{
		var val : Float = 0
		for transaction in bankAccount.transactions
		{
			val += transaction.value
		}
		return val
	}
}
