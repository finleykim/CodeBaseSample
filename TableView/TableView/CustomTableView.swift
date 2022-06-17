//
//  CustomTableView.swift
//  TableView
//
//  Created by Finley on 2022/06/16.
//

import Foundation
import UIKit

class CustomTableView: UITableView{
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: .plain)
        self.register(Cell.self, forCellReuseIdentifier: "Cell")
        self.rowHeight = 100
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
