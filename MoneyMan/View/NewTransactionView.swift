//
//  TransactionView.swift
//  MoneyMan
//
//  Created by Alikadev on 13.04.23.
//

import SwiftUI

struct NewTransactionView: View {
	@Environment(\.colorScheme) var colorScheme
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var global = globalState
	@ObservedObject var bankAccount : BankAccount
	
	@State var name = String()
	@State var date = Date.now
	@State var comment = String()
	@State var valueBuffer = String()
	
	@State var badNumberFormat = false
	
	
	var body: some View {
		NavigationView
		{
			VStack {
				VStack
				{
					TextField("Transaction name", text: $name)
					TextField("Comment", text: $comment)
					TextField("Value", text: $valueBuffer)
						.keyboardType(.numbersAndPunctuation)
					DatePicker("Date", selection: $date)
					HStack
					{
						Spacer()
						Button("Save")
						{
							if !check_number() {
								badNumberFormat.toggle()
								return
							}
							bankAccount.transactions.append(
								Transaction(
									id: bankAccount.transactions.count,
									name: name,
									value: Float(valueBuffer) ?? 0,
									date: date,
									comment: comment))
							if !global.save() {
								print("Fail to save")
							}
							bankAccount.objectWillChange.send()
							presentationMode.wrappedValue.dismiss()
						}
						.font(.system(size: fontSize, weight: .bold))
						.padding()
						.background(Rectangle()
							.foregroundColor(cBackground2)
							.cornerRadius(10)
							.shadow(radius: shadowSize))
					}
				}
				Spacer()
			}
			.foregroundColor(get_font_color())
			.font(.system(size: fontSize))
			.textFieldStyle(RoundedBorderTextFieldStyle())
			.padding()
			.toolbar
			{
				ToolbarItem(placement: .navigation)
				{
					Button {
						presentationMode.wrappedValue.dismiss()
					} label: {
						Image(systemName: "chevron.backward")
					}
				}
				ToolbarItem(placement: .principal)
				{
					VStack
					{
						Text(name.isEmpty ? "Transaction" : name)
							.font(.system(size: headSize, weight: .bold))
					}
				}
			}
		}
		.navigationBarBackButtonHidden(true)
		.background(Rectangle()
			   .font(.system(size: fontSize, weight: .bold))
			   .frame(maxWidth: .infinity)
			   .padding()
			   .foregroundColor(get_font_color())
			   .background(Rectangle()
				   .foregroundColor(cBackground2)
				   .cornerRadius(10)
				   .shadow(radius: shadowSize)))
		.alert(
			"Bad number format",
			isPresented: $badNumberFormat,
			actions: {
				Button("Ok") {badNumberFormat = false}
			},
			message: {Text("Specials and alpha characters are not accepted! (0, 123.45)")}
		)
	}
	func get_font_color() -> Color {
		return (colorScheme == .light ? Color.black : Color.white)
	}
	func check_number() -> Bool {
		if Float(valueBuffer) == nil {
			return false
		}
		return true
	}
}

struct NewTransactionView_Previews: PreviewProvider {
	static var previews: some View {
		NewTransactionView(bankAccount: BankAccount(name: "idk"))
	}
}
