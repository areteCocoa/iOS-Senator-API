//
//  PopoverViewController.swift
//  LearningCollections
//
//  Created by Thomas Ring on 10/19/18.
//  Copyright © 2018 TJRing Studios. All rights reserved.
//

import UIKit

private let reuse = "reuse"

class PopoverViewController: UIViewController {

	private var tableView: UITableView = {
		let view = UITableView(frame: CGRect.zero, style: .grouped)
		view.register(UINib(nibName: "PopoverTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: reuse)
		return view
	}()

	private var effectView: UIVisualEffectView = {
		let view = UIVisualEffectView(frame: CGRect.zero)
		return view
	}()

	public static func createFromNib() -> PopoverViewController {
		let nib = UINib(nibName: "PopoverViewController", bundle: Bundle.main)
		let controller = nib.instantiate(withOwner: self, options: nil)[0] as! PopoverViewController
		return controller
	}

	override func willMove(toParent parent: UIViewController?) {
		super.willMove(toParent: parent)

		if parent != nil {
			tableView.isHidden = true
		}
	}

	override func didMove(toParent parent: UIViewController?) {
		super.didMove(toParent: parent)

		guard let parent = parent else { return }
		view.frame = CGRect(x: parent.view.bounds.minX + parent.view.safeAreaInsets.left,
							y: parent.view.bounds.minY + parent.view.safeAreaInsets.top,
							width: parent.view.bounds.width,
							height: parent.view.bounds.height - parent.view.safeAreaInsets.top)

		let width = view.frame.size.width * 0.4
		let height = view.frame.size.height
		let x = view.frame.maxX
		let y = view.frame.minY
		let frame = CGRect(x: x, y: y, width: width, height: height)

		tableView.frame = frame
		tableView.isHidden = false
		tableView.backgroundColor = .green

		animateIn()
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        effectView.frame = view.bounds
		view.addSubview(effectView)

		tableView.dataSource = self
		tableView.delegate = self
		view.addSubview(tableView)
    }

	private func animateIn() {
		let destX = tableView.frame.minX - tableView.frame.width
		let destFrame = CGRect(x: destX, y: tableView.frame.minY,
							   width: tableView.frame.width, height: tableView.frame.height)

		let effect = UIBlurEffect(style: .prominent)

		let animator = UIViewPropertyAnimator(duration: 5.0, curve: .easeInOut) {
			self.tableView.frame = destFrame
			self.effectView.effect = effect
		}
		animator.startAnimation()
	}
}

extension PopoverViewController: UITableViewDelegate {

}

extension PopoverViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: reuse, for: indexPath) as! PopoverTableViewCell

		cell.textLabel?.text = "Testing"
		cell.accessoryType = .checkmark

		return cell
	}


}
