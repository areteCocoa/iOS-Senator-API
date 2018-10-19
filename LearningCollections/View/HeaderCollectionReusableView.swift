//
//  HeaderCollectionReusableView.swift
//  LearningCollections
//
//  Created by Thomas Ring on 10/16/18.
//  Copyright © 2018 TJRing Studios. All rights reserved.
//

import UIKit

struct HeaderCollectionViewModel {
	let name: String
}

class HeaderCollectionReusableView: UICollectionReusableView {

	var model: HeaderCollectionViewModel? {
		didSet {
			updateView()
		}
	}

	@IBOutlet private var nameLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	private func updateView() {
		nameLabel?.text = model?.name ?? ""
	}
}
