//
//  SenatorSortTableViewModel.swift
//  LearningCollections
//
//  Created by Thomas Ring on 10/22/18.
//  Copyright © 2018 TJRing Studios. All rights reserved.
//

import UIKit

class SenatorSortTableViewCellModel {
	var name: String
	var accessorized: Bool {
		didSet {
			accessorizedChanged?(accessorized)
		}
	}
	var accessorizedChanged: ((Bool) -> Void)?

	init(name: String, accessorized: Bool) {
		self.name = name
		self.accessorized = accessorized
	}
}

class SenatorSortTableViewModel: NSObject {
	struct Section {
		var name: String
		var rows: [SenatorSortTableViewCellModel]

		func toggle(cellAtRow row: Int) {
			// Toggle off all cells
			for row in rows {
				row.accessorized = false
			}

			rows[row].accessorized = true
		}
	}

	init(configuration: SortConfiguration) {
		self.configuration = configuration
		sections = [
			Section(name: "Sort", rows: [
				SenatorSortTableViewCellModel(name: "State", accessorized: configuration.type == .state),
				SenatorSortTableViewCellModel(name: "Name", accessorized: configuration.type == .name)
				]),
			Section(name: "Order", rows: [
				SenatorSortTableViewCellModel(name: "Ascending", accessorized: configuration.order == .ascending),
				SenatorSortTableViewCellModel(name: "Descending", accessorized: configuration.order == .descending)
				])
		]
	}

	private var sections: [Section]
	private var configuration: SortConfiguration

	var numberOfSections: Int {
		return sections.count
	}

	func numberOfRows(forSection section: Int) -> Int {
		return sections[section].rows.count
	}

	func title(forSection section: Int) -> String {
		return sections[section].name
	}

	func selected(rowAtIndexPath indexPath: IndexPath) {
		sections[indexPath.section].toggle(cellAtRow: indexPath.row)
	}

	func model(forIndexPath indexPath: IndexPath) -> SenatorSortTableViewCellModel {
		let section = sections[indexPath.section]
		return section.rows[indexPath.row]
	}
}
