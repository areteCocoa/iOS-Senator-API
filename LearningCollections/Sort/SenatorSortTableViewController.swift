//
//  SenatorSortTableViewController.swift
//  LearningCollections
//
//  Created by Thomas Ring on 10/19/18.
//  Copyright © 2018 TJRing Studios. All rights reserved.
//

import UIKit

private let reuse = "reuse"

struct SortConfiguration {
	var sortType: SenatorCollectionViewSortType
}

typealias SenatorSortSuccessClosure = ((SortConfiguration) -> Void)
typealias SenatorSortCancelClosure = (() -> ())

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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

	@objc private func finishPressed(sender: Any) {
		if let onSuccess = self.onSuccess {
			onSuccess(SortConfiguration(sortType: .state))
		}
	}

	@objc private func cancelPressed(sender: Any) {
		if let onCancel = self.onCancel {
			onCancel()
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
			if let config = sortConfigration {
				return .none
			} else {
				return .none
			}
		}()

        return cell
    }
}
