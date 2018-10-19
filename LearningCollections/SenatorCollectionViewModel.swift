//
//  SenatorCollectionViewModel.swift
//  LearningCollections
//
//  Created by Thomas Ring on 10/16/18.
//  Copyright © 2018 TJRing Studios. All rights reserved.
//

import UIKit

enum SenatorCollectionViewSort {
	case state
}

struct SenatorCollectionSectionViewModel {
	init(title: String, senators: [Senator]) {
		self.title = title
		data = senators.map { SenatorCollectionCellViewModel(senator: $0) }
	}

	var title: String
	var data: [SenatorCollectionCellViewModel]
}

class SenatorCollectionViewModel: NSObject {
	var sections: [SenatorCollectionSectionViewModel]

	var sort: SenatorCollectionViewSort {
		didSet {
			sections = SenatorCollectionViewModel.sort(data: data, usingSortType: sort)
		}
	}

	private var data: [Senator]

	convenience init(senators: [Senator]) {
		self.init(senators: senators, sort: .state)
	}

	required init(senators: [Senator], sort: SenatorCollectionViewSort) {
		self.sort = sort
		sections = SenatorCollectionViewModel.sort(data: senators, usingSortType: sort)
		data = senators
	}

	func model(forIndexPath indexPath: IndexPath) -> SenatorCollectionCellViewModel {
		return sections[indexPath.section].data[indexPath.row]
	}

	private static func sort(data: [Senator],
							 usingSortType sort: SenatorCollectionViewSort)-> [SenatorCollectionSectionViewModel] {
		var sections = [String: [Senator]]()

		for senator in data {
			let id = senator.state
			var old = sections[id] ?? [Senator]()
			old.append(senator)
			sections[id] = old
		}

		var sectionModels = [SenatorCollectionSectionViewModel]()

		for id in sections.keys {
			guard let datas = sections[id] else { continue }
			sectionModels.append(SenatorCollectionSectionViewModel(title: id, senators: datas))
		}

		sectionModels.sort { $0.title < $1.title }

		return sectionModels
	}
}
