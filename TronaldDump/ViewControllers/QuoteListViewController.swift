//
//  QuoteListViewController.swift
//  TronaldDump
//
//  Created by Emil Marashliev on 3.01.18.
//  Copyright © 2018 Emil Marashliev. All rights reserved.
//

import UIKit

final class QuoteListViewController: UITableViewController {

    var quotes: [Quote]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes?.count ?? 0
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier = String(describing: QuoteTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                 for: indexPath) as! QuoteTableViewCell
        cell.quote.text = quotes![indexPath.row].pritableText
        return cell
    }
}
