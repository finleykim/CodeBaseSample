//
//  Cell.swift
//  TableView
//
//  Created by Finley on 2022/06/16.
//

import Foundation
import UIKit
import SnapKit

class Cell:UITableViewCell{
    
    let title = UILabel()
    let subTitle = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [title, subTitle].forEach{
            contentView.addSubview($0)
        }
        
        title.snp.makeConstraints{
            $0.leading.trailing.top.equalToSuperview().inset(10)
        }
        
        subTitle.snp.makeConstraints{
            $0.top.equalTo(title.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        configuration()
    }
    

    private func configuration(){
        title.text = "타이틀"
        title.font = .systemFont(ofSize: 30.0, weight: .bold)
        title.textColor = .blue
        
        subTitle.text = "서브타이틀"
        subTitle.font = .systemFont(ofSize: 25.0, weight: .light)
        subTitle.textColor = .lightGray
    }
    
    
    
    
}

