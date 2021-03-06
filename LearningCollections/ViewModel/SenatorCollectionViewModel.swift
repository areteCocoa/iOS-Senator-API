//
//  SenatorCollectionViewModel.swift
//  LearningCollections
//
//  Created by Thomas Ring on 10/16/18.
//  Copyright © 2018 TJRing Studios. All rights reserved.
//

import UIKit

public struct SortConfiguration {
	var type: SenatorCollectionViewSortType
	var order: SenatorCollectionViewSortOrder
}

enum SenatorCollectionViewSortType {
	case state
	case name
}

enum SenatorCollectionViewSortOrder {
	case ascending
	case descending
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

	var sort: SortConfiguration {
		didSet {
			sections = SenatorCollectionViewModel.sort(data: data, usingSortConfiguration: sort)
		}
	}

	private var data: [Senator]

	convenience init(senators: [Senator]) {
		self.init(senators: senators, sort: SortConfiguration(type: .state, order: .descending))
	}

	required init(senators: [Senator], sort: SortConfiguration) {
		self.sort = sort
		sections = SenatorCollectionViewModel.sort(data: senators, usingSortConfiguration: sort)
		data = senators
	}

	func model(forIndexPath indexPath: IndexPath) -> SenatorCollectionCellViewModel {
		return sections[indexPath.section].data[indexPath.row]
	}

	private static func sort(data: [Senator], usingSortConfiguration configuration: SortConfiguration) -> [SenatorCollectionSectionViewModel] {
		var sections = [String: [Senator]]()

		for senator in data {
			let id = { () -> String in
				switch configuration.type {
				case .state:
					return senator.state
				case .name:
					return "\(senator.person.lastName.first!)"
				}
			}()
			var old = sections[id] ?? [Senator]()
			old.append(senator)
			sections[id] = old
		}

		var sectionModels = [SenatorCollectionSectionViewModel]()

		for id in sections.keys {
			guard let datas = sections[id] else { continue }
			sectionModels.append(SenatorCollectionSectionViewModel(title: id, senators: datas))
		}

		sectionModels.sort { (configuration.order == .ascending) ? ($1.title < $0.title) : ($0.title < $1.title) }

		return sectionModels
	}
}
