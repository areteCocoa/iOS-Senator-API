//
//  SenatorSortTableViewController.swift
//  LearningCollections
//
//  Created by Thomas Ring on 10/19/18.
//  Copyright © 2018 TJRing Studios. All rights reserved.
//

import UIKit

private let reuse = "reuse"

typealias SenatorSortSuccessClosure = ((SortConfiguration) -> Void)
typealias SenatorSortCancelClosure = (() -> ())

//private struct SenatorSortTableViewModel {
//	struct Section {
//		var name: String
//		var rows: [String]
//	}
//
//	init(configuration: SortConfiguration) {
//		self.configuration = configuration
//		sections = [
//			Section(name: "Sort", rows: [
//
//				])
//		]
//	}
//
//	private var sections: [Section]
//	private var configuration: SortConfiguration
//
//	func title(forIndexPath indexPath: IndexPath) -> String {
//		let section = sections[indexPath.section]
//		return section.rows[indexPath.row]
//	}
//
//	func accessorize(atIndexPath: IndexPath) -> Bool {
//
//	}
//}

class SenatorSortTableViewController: UITableViewController {

	var onSuccess: SenatorSortSuccessClosure?
	var onCancel: SenatorSortCancelClosure?

	var sortConfigration: SortConfiguration?

    override func viewDidLoad() {
        super.viewDidLoad()

		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self,
															action: #selector(finishPressed(sender:)))
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self,
														   action: #selector(cancelPressed(sender:)))

		tableView.register(UINib(nibName: "SenatorSortTableViewCell", bundle: Bundle.main),
						   forCellReuseIdentifier: reuse)
    }

	@objc private func finishPressed(sender: Any) {
		if let onSuccess = self.onSuccess {
			onSuccess(SortConfiguration(type: .state, order: .ascending))
		}
	}

	@objc private func cancelPressed(sender: Any) {
		if let onCancel = self.onCancel {
			onCancel()
		}
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0:
			return 2
		default:
			return 0
		}
    }

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 0:
			return "Sort"
		default:
			return ""
		}
	}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuse, for: indexPath)

        // Configure the cell...
		cell.textLabel?.text = {
			switch indexPath.row {
			case 0:
				return "State"
			case 1:
				return "Name"
			default:
				return ""
			}
		}()

		cell.accessoryType = {
			guard let config = sortConfigration else { return .none }
			let accessorize = (config.type == .state && indexPath.row == 0) ||
				(config.type == .name && indexPath.row == 1)
			return accessorize ? .checkmark : .none
		}()

        return cell
    }

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		super.tableView(tableView, didSelectRowAt: indexPath)

		if indexPath.section == 0 {
			if indexPath.row == 0 {
				sortConfigration?.type = .state
			} else if indexPath.row == 1 {
				sortConfigration?.type = .name
			}
		}

		tableView.deselectRow(at: indexPath, animated: true)

		tableView.reloadData()
	}
}
