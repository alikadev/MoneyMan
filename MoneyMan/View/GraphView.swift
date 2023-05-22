//
//  GraphView.swift
//  MoneyMan
//
//  Created by Alikadev on 22.05.23.
//

import SwiftUI
import Charts

class GraphController {
	var sum: Float = 0
	init(){}
	func calculate_new_sum(_ val: Float) -> Float
	{
		print("Old:"+String(sum)+" New:"+String(sum+val))
		sum += val
		return sum
	}
}

struct GraphView: View {
	let bankAccount: BankAccount
	let ctrl = GraphController()
    var body: some View {
		Chart {
			ForEach(bankAccount.transactions.sorted(by: {
				$0.date > $1.date }))
			{ transaction in
				LineMark(x: .value("Month", transaction.date),
						 y: .value("Money", get_sum_of_transaction_until(bankAccount.transactions, transaction)))
				.interpolationMethod(.monotone)
				PointMark(x: .value("Month", transaction.date),
						  y: .value("Money", get_sum_of_transaction_until(bankAccount.transactions, transaction)))
			}
		}
		.padding()
    }
	
	func get_sum_of_transaction_until(_ transactions: [Transaction], _ transaction: Transaction) -> Float {
		var q = Float()
		for tr in transactions {
			q += tr.value
			if transaction.id == tr.id { break }
		}
		return q
	}
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(bankAccount:
					BankAccount(name: "Text2", transactions: [
							  Transaction(id: 0, name: "Test", value: 20),
							  Transaction(id: 1, name: "Test", value: -4.5),
							  Transaction(id: 2, name: "Test", value: 2.10),
						  ]))
    }
}
