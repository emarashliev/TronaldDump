//
//  AppCoordinator.swift
//  TronaldDump
//
//  Created by Emil Marashliev on 3.01.18.
//  Copyright © 2018 Emil Marashliev. All rights reserved.
//

import UIKit

//I'm using app coordinators pattern to manage the ViewControllers
// and also to inject to them some dependencies
// more information here 👉 http://khanlou.com/2015/10/coordinators-redux/

final class AppCoordinator: NSObject {
    
    lazy var sharedWebservice = Webservice()
    lazy var rootViewController: UIViewController = {
        return self.navigationController
    }()
    
    private let storyboard = UIStoryboard(name: "App", bundle: nil)
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()

    private lazy var tagListViewController: TagListViewController = {
        let identifier = String(describing: TagListViewController.self)
        let viewController =
            storyboard.instantiateViewController(withIdentifier: identifier) as! TagListViewController
        return viewController
    }()
    
    private lazy var quoteListViewController: QuoteListViewController = {
        let identifier = String(describing: QuoteListViewController.self)
        let viewController =
            storyboard.instantiateViewController(withIdentifier: identifier) as! QuoteListViewController
        return viewController
    }()
    
    func start() {
        // I'm using unowned self here because it doesn't make sense that the block to exist without
        //   instance of AppCoordinator (which have to be alive till the app is alive)
        let loadingViewController = LoadingViewController(load: { [unowned self] callback in
            self.sharedWebservice.load(resource: Tag.allTagsResource, completion: callback)
        }, build: { [unowned self] tags in
            self.tagListViewController.tags = tags
            self.tagListViewController.delegate = self
            return self.tagListViewController
        })
        self.navigationController.viewControllers = [loadingViewController]
    }
}

extension AppCoordinator: TagListViewControllerDelegate {
    func didSelect(tag: String) {
        let loadingViewController = LoadingViewController(load: { [unowned self] callback in
            self.sharedWebservice.load(resource: Quote.allQuotes(with: tag), completion: callback)
            }, build: { [unowned self] quotes in
                self.quoteListViewController.quotes = quotes
                return self.quoteListViewController
        })
        self.navigationController.pushViewController(loadingViewController, animated: true)
    }
}
