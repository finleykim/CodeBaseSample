//
//  ViewController.swift
//  TableView
//
//  Created by Finley on 2022/06/17.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints{
            $0.top.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().inset(0)
            $0.trailing.equalToSuperview().inset(0)
        }
        
        configuration()
    }
    
    
    private func configuration(){
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "search"
        searchBar.layer.cornerRadius = 20
        searchBar.backgroundColor = .clear
    }

    

    

}


