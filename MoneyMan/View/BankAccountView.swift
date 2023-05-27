//
//  BankAccountView.swift
//  MoneyMan
//
//  Created by Alikadev on 13.04.23.
//

import SwiftUI

struct BankAccountView: View {
	@Environment(\.colorScheme) var colorScheme
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var global = globalState
	@ObservedObject var bankAccount : BankAccount
	
	@State var popBankAccountRename = false
	@State var popNewTransaction = false
	@State var popBankAccountBadName = false
	@State var popBankAccountAlreadyExist = false
	
	@State var navGraphView = false
	
	@State var buffer = String()
	
	var body: some View {
		NavigationView
		{
			ZStack {
				ScrollView
				{
					VStack
					{
						ForEach(bankAccount.transactions.sorted(by: {
							$0.date > $1.date }))
						{	transaction in
							NavigationLink
							{
								TransactionView(bankAccount: bankAccount, transaction: transaction)
							} label: {
								HStack
								{
									Text(transaction.name)
									Spacer()
									VStack(alignment: .trailing)
									{
										Text(String(format: "%0.2f "+get_currency(), transaction.value))
										Text(transaction.date, style: .date)
											.font(.system(size: dateSize, weight: .regular))
									}
								}
								.font(.system(size: fontSize, weight: .bold))
								.frame(maxWidth: .infinity)
								.padding()
								.foregroundColor(get_font_color())
								.background(Rectangle()
									.fill(LinearGradient(
										gradient: Gradient(stops: [
											Gradient.Stop(color: cBackground2, location: 0.5),
											Gradient.Stop(color: transaction.value>0 ? .green : .red, location: 1)
										]),
										startPoint: .center,
										endPoint: .trailing))
									.cornerRadius(10)
									.shadow(radius: shadowSize))
							}
						}
					}
					.padding()
				}
				VStack {
					Spacer()
					HStack{
						Spacer()
						NavigationLink
						{
							NewTransactionView(bankAccount: bankAccount)
						} label: {
							Image(systemName: "plus")
						}
						.font(.system(size: headSize))
						.padding(8)
						.background(Rectangle()
							.foregroundColor(cBackground2)
							.cornerRadius(10)
							.shadow(radius: shadowSize))
					}
				}
				.padding()
				.sheet(isPresented: $navGraphView) {
					GraphView(bankAccount: bankAccount)
				}
			}
			.toolbar
			{
				ToolbarItem(placement: .navigation)
				{
					Button {
						global.objectWillChange.send()
						presentationMode.wrappedValue.dismiss()
					} label: {
						Image(systemName: "chevron.backward")
					}
				}
				ToolbarItem(placement: .principal)
				{
					VStack
					{
						Text(bankAccount.name)
							.font(.system(size: headSize, weight: .bold))
						HStack
						{
							Text(String(format: "Sum: %0.2f "+get_currency(),get_sum_of_transaction(bankAccount.transactions)))
						}
					}
					.monospacedDigit()
				}
				ToolbarItem(placement: .confirmationAction)
				{
					Menu {
						Button {
							global.bankAccounts = global.bankAccounts.filter({$0.name != bankAccount.name})
							if !global.save() {
								print("Fail to save")
							}
							presentationMode.wrappedValue.dismiss()
						} label: {
							Text("Delete bank account")
							Spacer()
							Image(systemName: "trash")
						}
						Button()
						{
							popBankAccountRename.toggle()
						} label: {
							Text("Rename")
							Spacer()
							Image(systemName: "pencil")
						}
						Button()
						{
							navGraphView.toggle()
						} label: {
							Text("Graph")
							Spacer()
							Image(systemName: "chart.line.uptrend.xyaxis")
						}
					} label: {
						Image(systemName: "ellipsis")
					}
				}
			}
		}
		.navigationBarBackButtonHidden(true)
		.alert(
			"Rename bank account",
			isPresented: $popBankAccountRename,
			actions: {
				TextField("New account name", text: $buffer)
				Button("Apply") {
					if !buffer.isAlphanumeric {
						popBankAccountBadName = true
						return
					}
					
					if !global.bankAccounts.filter({$0.name == buffer}).isEmpty {
						popBankAccountAlreadyExist = true
						return
					}
					
					bankAccount.name = buffer
					if !global.save() {
						print("Fail to save")
					}
					global.objectWillChange.send()
					presentationMode.wrappedValue.dismiss()
				}
				Button("Cancel",
					   role: .cancel,
					   action: {popBankAccountRename = false})
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
	func get_currency() -> String {
		let locale = Locale.current
		return locale.currencySymbol!
	}
	func get_sum_of_transaction(_ transactions: [Transaction]) -> Float {
		var q = Float()
		for tr in transactions {
			q += tr.value
		}
		return q
	}
}

struct BankAccountView_Previews: PreviewProvider {
	@ObservedObject var global = globalState
	
	static var previews: some View {
		BankAccountView(bankAccount:
							BankAccount(name: "Text2", transactions: [
								Transaction(id: 0, name: "Test", value: 20),
								Transaction(id: 1, name: "Test", value: -4.5),
								Transaction(id: 2, name: "Test", value: 2.10),
							]))
	}
}
