//
//  BankAccountView.swift
//  MoneyMan
//
//  Created by Alikadev on 06.04.23.
//

import SwiftUI

struct BankAccountView: View {
	@State var controller = BankAccountController()
	
	@Environment(\.colorScheme) var colorScheme
	@State var popupGetName = false
	@State var accountName = String()
	
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
			VStack // Main Content
			{
				HStack {Spacer()}
					.background(Rectangle()
						.shadow(radius: shadowSize)
						.foregroundColor(backColor2)
						.ignoresSafeArea())
				
				VStack // Accounts
				{
					// Each account
					ForEach(
						controller.bankAccounts,
						id: \.name)
					{
						result in NavigationLink{
							TransactionView(controller: TransactionController(bankAccounts: &controller.bankAccounts, name: "\(result.name)"))
						} label: {
							Text("\(result.name)")
							Spacer()
							Text(String(format: "%0.2f $", controller.get_bank_account_balance(name: "\(result.name)")))
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
				}
				.padding(outsideMagin)
				
				Spacer()
			}
			.toolbar // Toolbar
			{
				ToolbarItem(placement: .principal)
				{
					Text("Bank Account" + (controller.bankAccounts.count > 1 ? "s" : ""))
						.font(.system(size: fontSize, weight: .semibold))
					
				}
				
				ToolbarItem(placement: .confirmationAction)
				{
					Button // Button to add bank account
					{
						popupGetName = true
					} label: {
						Image(systemName: "plus")
					}
				}
			}
		}
		.alert("Bank account name", isPresented: $popupGetName, actions: {
			TextField("Account name", text: $accountName)
				.disableAutocorrection(true)
			Button("Create") {
				controller.add_bank_account(name: accountName);accountName=""
			}
			Button("Cancel", role: .cancel, action: {popupGetName = false})
		})
		.background(Rectangle()
			.ignoresSafeArea()
			.foregroundColor(backColor1))
		.onAppear(perform: {
			if !Model.load_bank_accounts(bankAccounts: &controller.bankAccounts)
			{
				print("Fail to load bank account")
			}
		})
		.onDisappear(perform: {
			if !Model.save_bank_accounts(bankAccounts: controller.bankAccounts)
			{
				print("Fail to save bank account")
			}
		})
		.navigationBarBackButtonHidden(true)
	}
	func getFontColor() -> Color {
		return (colorScheme == .light ? Color.black : Color.white)
	}
}



struct BankAccountView_Previews: PreviewProvider {
	static var previews: some View {
		BankAccountView()
	}
}
