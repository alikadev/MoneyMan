//
//  MoneyManApp.swift
//  MoneyMan
//
//  Created by Alikadev on 06.04.23.
//

import SwiftUI

enum ViewState {
	case BankAccountSelector, TransactionSelector
}
var viewState = ViewState.BankAccountSelector

@main
struct MoneyManApp: App {
	
	var body: some Scene {
		WindowGroup {
			BankAccountView()
		}
	}
}
