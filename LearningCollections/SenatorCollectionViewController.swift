//
//  ViewController.swift
//  LearningCollections
//
//  Created by Thomas Ring on 10/10/18.
//  Copyright © 2018 TJRing Studios. All rights reserved.
//

import UIKit

fileprivate let reuse = "reuse"

struct SenatorCollectionViewModel {
	init(senators: [Senator]) {
		sections = [
			SenatorCollectionSectionViewModel(title: "Main", senators: senators)
		]
	}

	func model(forIndexPath indexPath: IndexPath) -> SenatorCollectionCellViewModel {
		return sections[indexPath.section].data[indexPath.row]
	}

	var sections: [SenatorCollectionSectionViewModel]
}

struct SenatorCollectionSectionViewModel {
	init(title: String, senators: [Senator]) {
		self.title = title
		data = senators.map { SenatorCollectionCellViewModel(senator: $0) }
	}

	var title: String
	var data: [SenatorCollectionCellViewModel]
}

class SenatorCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

	var model = SenatorModel()
	var viewModel: SenatorCollectionViewModel? {
		didSet {
			DispatchQueue.main.async {
				self.collectionView.reloadData()
			}
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)

		collectionView.register(UINib(nibName: "CollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: reuse)

		model.delegate = self
		model.fetchData()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		DispatchQueue.main.async {
			self.collectionView.collectionViewLayout.invalidateLayout()
		}
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = collectionView.frame.size.width * 0.8
		let height: CGFloat = {
			guard let model = self.viewModel else { return 0 }
			let cellModel = model.model(forIndexPath: indexPath)
			let hasSpecial = cellModel.special != nil

			return hasSpecial ? 100 : 65
		}()

		return CGSize(width: width, height: height)
	}

	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		guard let viewModel = self.viewModel else { return 0 }
		return viewModel.sections.count
	}

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let viewModel = self.viewModel else { return 0 }
		return viewModel.sections[section].data.count
	}

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuse, for: indexPath) as! CollectionViewCell

		guard let viewModel = self.viewModel else { return cell }
		let model = viewModel.model(forIndexPath: indexPath)

		cell.viewModel = model

		return cell
	}

}

extension SenatorCollectionViewController: SenatorModelProtocol {
	func senatorModel(model: SenatorModel, didReceiveData data: [Senator]) {
		viewModel = SenatorCollectionViewModel(senators: data)
	}

	func senatorModel(model: SenatorModel, didEncounterError error: Error) {
		print("Error encountered from model object: \(error)")
	}
}
