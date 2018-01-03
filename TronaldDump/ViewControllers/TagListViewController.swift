//
//  ViewController.swift
//  TronaldDump
//
//  Created by Emil Marashliev on 3.01.18.
//  Copyright © 2018 Emil Marashliev. All rights reserved.
//

import UIKit

protocol TagListViewControllerDelegate: class {
    func didSelect(tag: String)
}

final class TagListViewController: UITableViewController {

    var tags: [Tag]?
    weak var delegate: TagListViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier = String(describing: TagTableViewCell.self)
        let cell =
            tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TagTableViewCell
        // we can safely do force unwrapping because we are 100% sure that tags are not nil
        //   because of numberOfRowsInSection check
        cell.tagName.text = tags![indexPath.row].name
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tag = tags![indexPath.row]
        delegate.didSelect(tag: tag.name)
    }
}
