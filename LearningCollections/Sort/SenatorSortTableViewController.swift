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

class SenatorSortTableViewController: UITableViewController {

	var onSuccess: SenatorSortSuccessClosure?
	var onCancel: SenatorSortCancelClosure?

	var sortConfiguration: SortConfiguration? {
		didSet {
			guard let sortConfigration = sortConfiguration else { return }
			model = SenatorSortTableViewModel(configuration: sortConfigration)
		}
	}

	var model: SenatorSortTableViewModel? {
		didSet {
			tableView.reloadData()
		}
	}

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
			onSuccess(self.sortConfiguration!)
		}
	}

	@objc private func cancelPressed(sender: Any) {
		if let onCancel = self.onCancel {
			onCancel()
		}
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
		guard let model = model else { return 0 }
        return model.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let model = model else { return 0 }
		return model.numberOfRows(forSection: section)
    }

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		guard let model = model else { return nil }
		return model.title(forSection: section)
	}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuse, for: indexPath) as! SenatorSortTableViewCell

        // Configure the cell...
		let cellModel = model!.model(forIndexPath: indexPath)
		cell.model = cellModel

        return cell
    }

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.section == 0 {
			// Change the type
			switch indexPath.row {
			case 0:
				sortConfiguration?.type = .state
			case 1:
				sortConfiguration?.type = .name
			default:
				break
			}
		} else if indexPath.section == 1 {
			// Change the order
			switch indexPath.row {
			case 0:
				sortConfiguration?.order = .ascending
			case 1:
				sortConfiguration?.order = .descending
			default:
				break
			}
		}

		model!.selected(rowAtIndexPath: indexPath)

		tableView.deselectRow(at: indexPath, animated: true)
	}
}
