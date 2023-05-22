//
//  MainView.swift
//  MoneyMan
//
//  Created by Alikadev on 13.04.23.
//

import SwiftUI

struct MainView: View {
	@Environment(\.colorScheme) var colorScheme
	@ObservedObject var global = globalState
	
	@State var popNewBankAccount = false
	@State var popBankAccountBadName = false
	@State var popBankAccountAlreadyExist = false
	
	@State var buffer = String()
	
    var body: some View {
		NavigationView
		{
			ScrollView
			{
				VStack
				{
					ForEach(global.bankAccounts)
					{	account in
						NavigationLink
						{
							BankAccountView(bankAccount: account)
						} label: {
							Text(account.name)
							Spacer()
							Text(String(
								format: "%0.2f "+get_currency(),
								get_sum_of_transaction(account.transactions)
							))
						}
						.font(.system(size: fontSize, weight: .bold))
						.frame(maxWidth: .infinity)
						.padding()
						.foregroundColor(get_font_color())
						.background(Rectangle()
							.foregroundColor(cBackground2)
							.cornerRadius(10)
							.shadow(radius: shadowSize))
					}
				}
				.padding()
			}
			
			.toolbar
			{
				ToolbarItem(placement: .principal)
				{
					VStack {
						HStack {
							
							Text(String(global.bankAccounts.count))
							Text("Bank Account" + (global.bankAccounts.count > 1 ? "s" : ""))
						}
						.font(.system(size: headSize, weight: .bold))
						Text("Sum: "+String(format: "%0.2f "+get_currency(), get_sum_of_all()))
							.font(.system(size: fontSize))
					}
					.monospacedDigit()
					.padding()
				}
				
				ToolbarItem(placement: .confirmationAction)
				{
					Button // Button to add bank account
					{
						popNewBankAccount = true
					} label: {
						Image(systemName: "plus")
					}
				}
			}
		}
		.onAppear(perform: {
			if !global.load() {
				global.bankAccounts = []
			}
		})
		.onDisappear(perform: {
			if !global.save() {
				print("Fail to save")
			}
		})
		.alert(
			"Create bank account",
			isPresented: $popNewBankAccount,
			actions: {
				TextField("Account name", text: $buffer)
				Button("Create") {
					if !buffer.isAlphanumeric {
						popBankAccountBadName = true
						return
					}
					
					if !global.bankAccounts.filter({$0.name == buffer}).isEmpty {
						popBankAccountAlreadyExist = true
						return
					}
					
					global.bankAccounts.append(BankAccount(name: buffer))
					if !global.save() {
						print("Fail to save")
					}
				}
				Button("Cancel",
					   role: .cancel,
					   action: {popNewBankAccount = false})
			})
		.alert(
			"Bank account already exists",
			isPresented: $popBankAccountAlreadyExist,
			actions: {
				Button("Ok") {popBankAccountAlreadyExist = false}
			},
			message: {Text("Bank account with this name already exists!")}
		)
		.alert(
			"Bad name for bank account",
			isPresented: $popBankAccountBadName,
			actions: {
				Button("Ok") {popBankAccountBadName = false}
			},
			message: {Text("Bank account's name only support alphanumeric*")}
		)
    }
	func get_font_color() -> Color {
		return (colorScheme == .light ? Color.black : Color.white)
	}
	func get_sum_of_transaction(_ transactions: [Transaction]) -> Float {
		var q = Float()
		for tr in transactions {
			q += tr.value
		}
		return q
	}
	func get_sum_of_all() -> Float {
		var q = Float()
		for ac in global.bankAccounts {
			q += get_sum_of_transaction(ac.transactions)
		}
		return q
	}
	func get_currency() -> String {
		let locale = Locale.current
		return locale.currencySymbol!
	}
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
		MainView()
    }
}
