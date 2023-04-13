//
//  Global.swift
//  MoneyMan
//
//  Created by Alikadev on 13.04.23.
//

import SwiftUI

let cBackground1 = Color(.systemBackground)
let cBackground2 = Color(.systemGray6)
let shadowSize : CGFloat = 2
let fontSize : CGFloat = 18
let headSize : CGFloat = 22
let dateSize : CGFloat = 12

class GlobalState: ObservableObject {
	@Published var bankAccounts : [BankAccount] = [
		BankAccount(name: "Text1"),
		BankAccount(name: "Text2", transactions: [
			Transaction(name: "Test", value: 20),
			Transaction(name: "Test", value: -4.5),
			Transaction(name: "Test", value: 2.10),
		]),
		BankAccount(name: "Text3", transactions: [
			Transaction(name: "Test", value: 2350),
		])
	]
	struct keys
	{
		static let bankAccountList = "BankAccounts"
	}
	
	public func save() -> Bool
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
	
	public func load() -> Bool
	{
		let defaults = UserDefaults.standard
				
		do {
			if let savedData = defaults.object(forKey: keys.bankAccountList)
			{
				bankAccounts = try JSONDecoder().decode([BankAccount].self, from: savedData as! Data)
				return true
			}
		} catch {
		}
		return false
	}
}
var globalState = GlobalState()

extension String {
	var isAlphanumeric: Bool {
		return !isEmpty && range(of: "[^a-zA-Z0-9 -_]", options: .regularExpression) == nil
	}
}
