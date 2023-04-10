//
//  TransactionView.swift
//  MoneyMan
//
//  Created by Alikadev on 07.04.23.
//

import SwiftUI

struct TransactionView: View {
	@Environment(\.colorScheme) var colorScheme
	@State var controller : TransactionController
	@State var popupRenameBankAccount = false
	@State var bankAccountName = ""
	
	let shadowSize : CGFloat = 2
	let margin : CGFloat = 2
	let outsideMagin : CGFloat = 8
	let backColor1 : Color = Color(.systemBackground)
	let backColor2 : Color = Color(.systemGray6)
	let fontSize : CGFloat = 20
	let createFontSize : CGFloat = 25
	
	var body: some View {
		NavigationView // View
		{
			VStack // View Content
			{
				HStack {Spacer()}
					.background(Rectangle()
						.shadow(radius: shadowSize)
						.foregroundColor(backColor2)
						.ignoresSafeArea())
				
				VStack // Main View
				{
					ForEach(
						controller.bankAccount.transactions,
						id: \.name)
					{
						result in Button {
							controller.go_back()
						} label: {
							Text("\(result.name)")
							Spacer()
							Text(String(format: "%0.2f", result.value))
						}
						.font(.system(size: fontSize, weight: .bold))
						.frame(maxWidth: .infinity)
						.padding()
						.foregroundColor(getFontColor())
						.background(Rectangle()
							.foregroundColor(backColor2)
							.cornerRadius(10)
							.shadow(radius: shadowSize))
						.foregroundColor(getFontColor())
					}
					Spacer()
				}
				NavigationLink("", destination: BankAccountView(), isActive: $controller.shouldGoBack)
			}
			.toolbar {
				ToolbarItem(placement: .navigation)
				{
					Button {
						controller.go_back()
					} label: {
						Image(systemName: "chevron.backward")
					}
				}
				ToolbarItem(placement: .principal)
				{
					Text(controller.bankAccount.name)
						.font(.system(size: fontSize, weight: .semibold))
				}
				ToolbarItem(placement: .confirmationAction)
				{
					Menu {
						Button {
							controller.remove_bank_account()
						} label: {
							Text("Delete bank account")
							Spacer()
							Image(systemName: "trash")
						}
						Button()
						{
							popupRenameBankAccount = true
						} label: {
							Text("Rename")
							Spacer()
							Image(systemName: "pencil")
						}
						Button()
						{
						} label: {
							Text("Add Transaction")
							Spacer()
							Image(systemName: "plus")
						}
					} label: {
						Image(systemName: "ellipsis.circle")
					}
				}
			}
			.alert("Rename Bank Account name", isPresented: $popupRenameBankAccount, actions: {
				TextField("Bank Account name", text: $bankAccountName)
					.disableAutocorrection(true)
				Button("Rename") {
					controller.rename_bank_account(name: bankAccountName);
					bankAccountName=""
				}
				Button("Cancel", role: .cancel, action: {
					popupRenameBankAccount = false
				})
			})
		}
		.background(
			Rectangle()
				.ignoresSafeArea()
				.foregroundColor(backColor1)
		)
		.onDisappear(perform: {
			if !Model.save_bank_accounts(bankAccounts: controller.bankAccounts)
			{
				print("Fail to save bank accounts")
			}
		})
		.navigationBarBackButtonHidden(true)
	}
	func getFontColor() -> Color {
		return (colorScheme == .light ? Color.black : Color.white)
	}
}


struct TransactionView_Previews: PreviewProvider {
	static var bankAccounts : [BankAccount] = [BankAccount(name: "Example", transactions: [TransactionDescriptor(name: "example1",value: 200.0),TransactionDescriptor(name: "example2",value: 241.2)])]
	static var previews: some View {
		TransactionView.init(controller: TransactionController(bankAccounts: &bankAccounts,name: "Example"))
	}
}
