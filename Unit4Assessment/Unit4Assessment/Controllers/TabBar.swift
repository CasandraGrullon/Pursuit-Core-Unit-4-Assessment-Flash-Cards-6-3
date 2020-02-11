//
//  TabBar.swift
//  Unit4Assessment
//
//  Created by casandra grullon on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class TabBar: UITabBarController {
    
    private lazy var myCardsVC: MyCardsViewController = {
        let vc = MyCardsViewController()
        vc.tabBarItem = UITabBarItem(title: "My Cards", image: UIImage(systemName: "square.stack.3d.up.fill"), tag: 0)
        return vc
    }()
    private lazy var createCardsVC: CreateCardsViewController = {
        let vc = CreateCardsViewController()
        vc.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "plus.square.fill.on.square.fill"), tag: 1)
        return vc
    }()
    private lazy var searchCardsVC: SearchCardsViewController = {
        let vc = SearchCardsViewController()
        vc.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "doc.text.magnifyingglass"), tag: 2)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [myCardsVC, createCardsVC, searchCardsVC]
    }
    
    
}
