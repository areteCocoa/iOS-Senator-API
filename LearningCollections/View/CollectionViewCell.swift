//
//  CollectionViewCell.swift
//  LearningCollections
//
//  Created by Thomas Ring on 10/10/18.
//  Copyright © 2018 TJRing Studios. All rights reserved.
//

import UIKit

struct SenatorCollectionCellViewModel {
	init(senator: Senator) {
		name = senator.person.firstName + " " + senator.person.lastName
		state = senator.state
		party = senator.party
		special = senator.leadershipTitle

		self.senator = senator
	}
	var name: String
	var state: String
	var party: String
	var special: String?

	private var senator: Senator
}

class CollectionViewCell: UICollectionViewCell {
	@IBOutlet var nameLabel: UILabel?
	@IBOutlet var stateLabel: UILabel?
	@IBOutlet var partyLabel: UILabel?
	@IBOutlet var specialLabel: UILabel?

	var viewModel: SenatorCollectionCellViewModel? {
		didSet {
			updateViews()
		}
	}

	private func updateViews() {
		nameLabel?.text = viewModel?.name
		stateLabel?.text = viewModel?.state
		partyLabel?.text = viewModel?.party
		specialLabel?.text = viewModel?.special

		specialLabel?.isHidden = (viewModel?.special == nil)
	}
}
