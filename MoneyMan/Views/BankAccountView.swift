//
//  BankAccountView.swift
//  MoneyMan
//
//  Created by Alikadev on 06.04.23.
//

import SwiftUI

struct BankAccountView: View {
	@State var popupGetName = false
	@State var accountName = String()
	var controller = BankAccountController()
	@Environment(\.colorScheme) var colorScheme
	var body: some View {
		NavigationView // View
		{
			VStack // Main View
			{
				HStack // Header
				{
					Spacer()
					
					HStack // Number of entries
					{
						Text(String(bankAccounts.count))
							.fontWeight(.semibold)
						Text(" bank account" + (bankAccounts.count > 1 ? "s" : ""))
					}
					.font(.system(size: 20))
					.foregroundColor(colorScheme == .light ? Color.black : Color.white)
					
					Spacer()
					
					Button("+") // Button to add bank account
					{
						popupGetName = true
					}
					.foregroundColor(colorScheme == .light ? Color.black : Color.white)
					.font(.system(size: 25))
					.alert("Bank account name", isPresented: $popupGetName, actions: {
						TextField("Account name", text: $accountName)
							.disableAutocorrection(true)
						Button("Login", action: {controller.addBankAccount(name: accountName);accountName=""})
						Button("Cancel", role: .cancel, action: {popupGetName = false})
					})
				}
				.padding()
				.background(Rectangle()
					.foregroundColor(Color(.systemGray6))
					.ignoresSafeArea())
				.shadow(radius: 2)
				
				
				VStack // Accounts
				{
					// Each account
					ForEach(
						bankAccounts,
						id: \.name)
					{
						result in NavigationLink(destination: TransactionView(controller: TransactionController(name: "\(result.name)"))) {
							Text("Account \(result.name)")
						}
						.font(.system(size: 20, weight: .bold))
						.foregroundColor(colorScheme == .light ? Color.black : Color.white)
						.frame(maxWidth: .infinity)
						.padding()
						.background(Rectangle()
							.foregroundColor(Color(.systemGray6))
							.cornerRadius(10))
						.shadow(radius: 1)
						.foregroundColor(Color(.black))
					}
				}
				.padding(5)
				
				Spacer()
			}
		}
		.background(Rectangle()
			.ignoresSafeArea()
			.foregroundColor(Color(.systemBackground)))
	}
}



struct BankAccountView_Previews: PreviewProvider {
	static var previews: some View {
		BankAccountView()
	}
}
