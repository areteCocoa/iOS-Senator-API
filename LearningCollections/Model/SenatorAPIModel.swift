//
//  SenatorAPIModel.swift
//  LearningCollections
//
//  Created by Thomas Ring on 10/11/18.
//  Copyright © 2018 TJRing Studios. All rights reserved.
//

import UIKit

typealias JSONDictionary = [String: Any]
typealias APICompletion = ((APIResult) -> (Void))

enum APIResult {
	case Success([JSONDictionary])
	case Fail(Error)
}

/**
Response for getting the data and serializing it into Foundation objects.
*/
class SenatorAPIModel: NSObject {
	private var taskManager = SenatorAPITaskManager()

	public func getData(withCompletion completion: @escaping APICompletion) {
		taskManager.fetchData { data, error in
			if let error = error {
				print("Error getting the data from API endpoint: \(error)")
				completion(APIResult.Fail(error))
				return
			}

			guard let data = data else {
				return
			}

			do {
				let parsed = try SenatorAPIModel.parse(data: data)
				completion(APIResult.Success(parsed))
			} catch {
				completion(APIResult.Fail(error))
			}
		}
	}

	private enum ParseError: Error {
		case Serialization(Error)
		case InvalidFormat
		case Unknown
	}
	private static func parse(data: Data) throws -> [JSONDictionary] {
		do {
			let jsonAny = try JSONSerialization.jsonObject(with: data)
			guard let root = jsonAny as? [String: Any] else { throw ParseError.InvalidFormat }
			guard let genericData = root["objects"] as? [Any] else { throw ParseError.InvalidFormat }
			var data = [[String: Any]]()
			genericData.forEach { (object) in
				data.append((object as! [String: Any]))
			}
			return data
		} catch {
			throw ParseError.Serialization(error)
		}
	}
}
