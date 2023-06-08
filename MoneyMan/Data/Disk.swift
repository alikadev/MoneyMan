//
//  Disk.swift
//  MoneyMan
//
//  Created by Alikadev on 06.06.23.
//

import Foundation

class Disk
{
	/*
	 Sauvegarde un objet Encodable.
	 */
	static func save(_ object: any Encodable, key: String) throws
	{
		let defaults = UserDefaults.standard
		
		do {
			let data = try JSONEncoder().encode(object)
			defaults.set(data, forKey: key)
		} catch {
			throw Errors.DiskError("Fail to save data in disk")
		}
	}
	
	/*
	 Charge un objet depuis le disque
	 */
	static func load(type: any Decodable.Type ,key: String) throws -> Decodable
	{
		let defaults = UserDefaults.standard
		
		do {
			if let data = defaults.object(forKey: key)
			{
				return try JSONDecoder().decode(type, from: data as! Foundation.Data)
			}
		} catch {
			throw Errors.DiskError("Fail to decode data")
		}
		throw Errors.DiskError("Data doesn't exist")
	}
}
