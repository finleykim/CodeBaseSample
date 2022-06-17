//
//  Cell.swift
//  CollectionView
//
//  Created by Finley on 2022/06/06.
//

import Foundation
import UIKit
import SnapKit

class Cell: UICollectionViewCell{
    
    let image = UIImageView()
    let title = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [image, title].forEach{
            contentView.addSubview($0)
        }
        
        image.snp.makeConstraints{
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        title.snp.makeConstraints{
            $0.top.equalTo(image.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        
    }
    
    

    
    
    
}
