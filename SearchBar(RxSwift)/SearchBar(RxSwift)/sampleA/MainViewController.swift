//
//  MainViewController.swift
//  SearchBar(RxSwift)
//
//  Created by Finley on 2022/06/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MainViewController: UIViewController{
    let disposeBag = DisposeBag()
    let searchBar = SearchBar()
    let listView = ResultList() //만들어둔 서치바와 테이블뷰 적용
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(){
        
    }
    
    private func attribute(){
        
    }
    
    private func layout(){
        [searchBar, listView].forEach{
            view.addSubview($0)
        }
        
        searchBar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        listView.snp.makeConstraints{
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview() 
        }
    }
}
