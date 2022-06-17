//
//  AutoLayoutPractice.swift
//  CollectionView
//
//  Created by Finley on 2022/06/07.
//

import Foundation
import UIKit


class AutoLayoutPractice: UIViewController{
    
    let button = UIButton() //버튼생성
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addSubview(view)
        setup()
    }
    

    private func setup(){
        self.button.setTitle("다음페이지로", for: .normal)
        
        var constraintsX: NSLayoutConstraint
        constraintsX = button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        var constraintsY: NSLayoutConstraint
        constraintsY = button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        constraintsX.isActive = true
        constraintsY.isActive = true
    }
    
    
    
}
