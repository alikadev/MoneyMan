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
			ForEach(bankAccount.transactions)
			{ transaction in
				PointMark(x: .value("Month", transaction.date),
						  y: .value("Money", get_sum_of_transaction_until(bankAccount.transactions, transaction)))
				.symbolSize(12)
				.opacity(0.75)
				LineMark(x: .value("Month", transaction.date),
						 y: .value("Money", get_sum_of_transaction_until(bankAccount.transactions, transaction)))
				.interpolationMethod(.monotone)
				.symbolSize(10)
			}
		}
		.padding()
    }
	
	func get_sum_of_transaction_until(_ transactions: [Transaction], _ transaction: Transaction) -> Float {
		var q = Float()
		for tr in transactions.reversed() {
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
						Transaction(id: 2, name: "Test", value: 2.10, date: Date.now+10),
						Transaction(id: 0, name: "Test", value: 20, date: Date.now),
						Transaction(id: 1, name: "Test", value: -4.5, date: Date.now-5),
						  ]))
    }
}
