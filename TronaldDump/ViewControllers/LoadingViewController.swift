//
//  LoadingViewController.swift
//  TronaldDump
//
//  Created by Emil Marashliev on 3.01.18.
//  Copyright © 2018 Emil Marashliev. All rights reserved.
//

import UIKit

final class LoadingViewController: UIViewController {

    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    init<T>(load: ( @escaping  (Result<T>) -> ()) -> (), build: @escaping (T) -> UIViewController) {
        super.init(nibName: nil, bundle: nil)
        spinner.startAnimating()
        load() { [weak self] result in
            self?.spinner.stopAnimating()
            guard let value = result.value else { return }
            let viewController = build(value)
            self?.add(content: viewController)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        spinner.center(inView: view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func add(content: UIViewController) {
        addChildViewController(content)
        view.addSubview(content.view)
        content.view.translatesAutoresizingMaskIntoConstraints = false
        content.view.constrainEdges(toMarginOf: view)
        content.didMove(toParentViewController: self)
    }
}
