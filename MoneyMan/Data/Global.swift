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

func printError(_ message: String) -> Void {
	print("ERROR:", message)
}

class Global: ObservableObject
{
	private var ACCOUNT_KEY = "ACCOUNTS"
	@Published var account = Account()
	public static let shared = Global()
	
	private init() {
	}
	
	func saveAccount()
	{
		do {
			try Disk.save(account, key: ACCOUNT_KEY)
		} catch Errors.DiskError(let error) {
			printError(error)
		} catch {
			printError("Unreachable")
		}
	}
	
	func loadAccount()
	{
		let defaults = UserDefaults.standard
		
		do {
			if let savedData = defaults.object(forKey: "BankAccounts")
			{
				account.bankAccounts = try JSONDecoder().decode(
					[BankAccount].self,
					from: savedData as! Data)
				saveAccount()
				defaults.removeObject(forKey: "BankAccounts")
				print("DEBUG: Loaded from old data")
			} else {
				account = try Disk.load(type: Account.self, key: ACCOUNT_KEY) as! Account
			}
		} catch Errors.DiskError(let error) {
			printError(error)
		} catch {
			print("Unreachable")
		}
	}
}

extension String {
	var isAlphanumeric: Bool {
		return !isEmpty && range(of: "[^a-zA-Z0-9 -_]", options: .regularExpression) == nil
	}
}
