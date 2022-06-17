//
//  CustomCollectionView.swift
//  CollectionView
//
//  Created by Finley on 2022/06/06.
//

import Foundation
import UIKit
import SnapKit


class CustomCollectionView: UICollectionView{
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.register(Cell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
