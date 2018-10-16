//
//  SenatorModel.swift
//  LearningCollections
//
//  Created by Thomas Ring on 10/11/18.
//  Copyright © 2018 TJRing Studios. All rights reserved.
//

import UIKit

protocol SenatorModelProtocol: AnyObject {
	func senatorModel(model: SenatorModel, didReceiveData data: [Senator])
	func senatorModel(model: SenatorModel, didEncounterError error: Error)
}

/**
Responsible for validating objects using Senator objects and returning them via the SenatorModelDelegate protocol.
*/
class SenatorModel: NSObject {
	private var apiModel = SenatorAPIModel()

	public var delegate: SenatorModelProtocol?

	func fetchData() {
		apiModel.getData { [weak self] result in
			guard let self = self else { return }

			switch result {
			case .Success(let data):
				let senatorData = data.map { Senator(json: $0) }
				self.delegate?.senatorModel(model: self, didReceiveData: senatorData)
			case .Fail(let error):
				self.delegate?.senatorModel(model: self, didEncounterError: error)
			}


		}
//		apiModel.getData { [weak self] (json) -> (Void) in
//			guard let json = json else {
//				return
//			}
//			let results = json.map { Senator(json: $0) }
//			guard let me = self else { return }
//			me.delegate?.senatorModel(model: me, didReceiveData: results)
//		}
	}
}
