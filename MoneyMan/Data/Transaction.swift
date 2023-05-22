//
//  Transaction.swift
//  MoneyMan
//
//  Created by Alikadev on 13.04.23.
//

import Foundation

class Transaction: ObservableObject, Codable, Identifiable
{
	public var name: String
	public var value: Float
	public var date: Date
	public var comment: String
	public var id: Int
	
	init(id: Int,
		 name: String,
		 value: Float,
		 date: Date = Date.now,
		 comment: String = "")
	{
		self.id = id
		self.name = name
		self.value = value
		self.date = date
		self.comment = comment
	}
}
