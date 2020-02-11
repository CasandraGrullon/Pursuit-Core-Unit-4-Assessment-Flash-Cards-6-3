//
//  TabBar.swift
//  Unit4Assessment
//
//  Created by casandra grullon on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class TabBar: UITabBarController {
    
    private let dataPersistence = DataPersistence<Cards>(filename: "createdCards.plist")
    
    private lazy var myCardsVC: MyCardsViewController = {
        let vc = MyCardsViewController()
        vc.tabBarItem = UITabBarItem(title: "My Cards", image: UIImage(systemName: "square.stack.3d.up.fill"), tag: 0)
        vc.view.backgroundColor = #colorLiteral(red: 0.7739111781, green: 1, blue: 0.8726517558, alpha: 1)
        vc.dataPersistence = dataPersistence
        vc.dataPersistence.delegate = vc
        return vc
    }()
    private lazy var createCardsVC: CreateCardsViewController = {
        let vc = CreateCardsViewController()
        vc.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "plus.square.fill.on.square.fill"), tag: 1)
        vc.view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        vc.dataPersistence = dataPersistence
        return vc
    }()
    private lazy var searchCardsVC: SearchCardsViewController = {
        let vc = SearchCardsViewController()
        vc.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "doc.text.magnifyingglass"), tag: 2)
        vc.view.backgroundColor = #colorLiteral(red: 1, green: 0.818012774, blue: 0.9189140201, alpha: 1)
        vc.dataPersistence = dataPersistence
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [myCardsVC, createCardsVC, searchCardsVC]
    }
    
    
}
