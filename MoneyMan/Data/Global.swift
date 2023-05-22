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
let traTypeSize : CGFloat = 10

class GlobalState: ObservableObject {
	@Published var bankAccounts : [BankAccount] = []
	
	struct keys
	{
		static let BALIST = "BankAccounts"
	}
	
	public func save() -> Bool
	{
		let defaults = UserDefaults.standard
		
		do {
			let accountData = try JSONEncoder().encode(bankAccounts)
			
			defaults.set(accountData, forKey: keys.BALIST)
			
			return true
		} catch {
			return false
		}
	}
	
	public func load() -> Bool
	{
		let defaults = UserDefaults.standard
				
		do {
			if let savedData = defaults.object(forKey: keys.BALIST)
			{
				bankAccounts = try JSONDecoder().decode(
						[BankAccount].self,
						from: savedData as! Data)
			}
			return true
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
