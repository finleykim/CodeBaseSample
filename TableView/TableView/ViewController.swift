//
//  ViewController.swift
//  TableView
//
//  Created by Finley on 2022/06/16.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let tableView = CustomTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview().inset(30)
        }
        
        setupTableView()
    }
    
    private func setupTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.layer.cornerRadius = 10
    }

    

}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? Cell else { return UITableViewCell() }
        
        return cell
    }

}
