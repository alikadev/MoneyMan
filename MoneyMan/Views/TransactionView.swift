//
//  TransactionView.swift
//  MoneyMan
//
//  Created by Alikadev on 07.04.23.
//

import SwiftUI

struct TransactionView: View {
	var controller : TransactionController
	
	@Environment(\.colorScheme) var colorScheme
	var body: some View {
		ZStack // View
		{
			VStack // Main View
			{
				Text("Hello, " + controller.bankAccount.name + " !");
			}
		}
		.background(Rectangle()
			.ignoresSafeArea()
			.foregroundColor(Color(.systemGray6)))
	}
}


struct TransactionView_Previews: PreviewProvider {
	static var previews: some View {
		TransactionView.init(controller: TransactionController(name: "Example"))
	}
}
