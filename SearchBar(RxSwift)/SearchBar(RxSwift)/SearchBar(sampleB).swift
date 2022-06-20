//
//  SearchBar(sampleB).swift
//  SearchBar(RxSwift)
//
//  Created by Finley on 2022/06/20.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import SnapKit

class SearchBarSampleViewController: UIViewController{
    var shownData = [String]() //보여줄 정보가 저장될 배열
    let allData = ["보라돌이","뚜비","나나","뽀"] //모든 정보가 저장될 배열
    
    var tableView = UITableView() //테이블뷰
    var searchBar = UISearchBar() //서치바
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        configureLayout()
        configureSearchBar()
    }
    
    private func configureSearchBar(){
        searchBar
            .rx.text
            .orEmpty
            .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [unowned self] newData in
                self.shownData = self.allData.filter { $0.hasPrefix(newData) }
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func configureLayout(){
        [tableView, searchBar].forEach{
            view.addSubview($0)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
}


extension SearchBarSampleViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.selectionStyle = .none
        cell.textLabel?.textColor = .black
        cell.textLabel?.backgroundColor = .white
        cell.textLabel?.text = shownData[indexPath.row]
        
        return cell
    }
}
