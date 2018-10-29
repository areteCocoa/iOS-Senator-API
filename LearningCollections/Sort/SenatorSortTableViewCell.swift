//
//  SenatorSortTableViewCell.swift
//  LearningCollections
//
//  Created by Thomas Ring on 10/19/18.
//  Copyright © 2018 TJRing Studios. All rights reserved.
//

import UIKit

class SenatorSortTableViewCell: UITableViewCell {

	var model: SenatorSortTableViewCellModel? {
		didSet {
			model?.accessorizedChanged = { [weak self] accessorized in
				self?.accessorizedChanged(accessorized: accessorized)
			}
			updateViews()
		}
	}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	private func updateViews() {
		textLabel?.text = model?.name ?? ""
		accessoryType = (model?.accessorized ?? false) ? .checkmark : .none
	}

	private func accessorizedChanged(accessorized: Bool) {
		updateViews()
	}
}
