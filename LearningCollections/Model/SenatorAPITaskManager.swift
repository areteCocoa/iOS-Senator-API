//
//  SenatorAPITaskManager.swift
//  LearningCollections
//
//  Created by Thomas Ring on 10/11/18.
//  Copyright © 2018 TJRing Studios. All rights reserved.
//

import UIKit

let endpoint = "https://www.govtrack.us/api/v2/role?current=true&role_type=senator"

typealias TaskCompletion = ((Data?, Error?) -> (Void))

/**
Sends the API requests to the URL and returns the data through the completion handler.
*/
class SenatorAPITaskManager: NSObject {

	var session = URLSession(configuration: URLSessionConfiguration.default)
	private var tasks = [URL: TaskCompletion]()

	public func fetchData(withCompletion completion: @escaping TaskCompletion) {
		guard let url = URL(string: endpoint) else { fatalError() }
		tasks[url] = completion
		let task = session.dataTask(with: url) { (data, response, error) in
			guard let url = response?.url else { return }
			if let completion = self.tasks[url] {
				completion(data, error)
			}
		}
		task.resume()
	}
}
