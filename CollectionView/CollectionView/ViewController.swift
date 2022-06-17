//
//  CollectionView.swift
//  CollectionView
//
//  Created by Finley on 2022/06/06.
//

import Foundation
import UIKit
import SnapKit


class ViewController: UIViewController{
    
    let logo = UILabel()
    let collectionView = CustomCollectionView()
    let button = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [logo, collectionView, button].forEach{
            view.addSubview($0)
        }
        
        logo.snp.makeConstraints{
            $0.top.equalToSuperview().inset(30)
            $0.leading.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints{
            $0.top.equalTo(logo.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
            
        }
        
        button.snp.makeConstraints{
            $0.top.equalTo(collectionView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(30)
        }
        setupButton()
        setupCollectionView()
    
    }
    
    
    private func setupCollectionView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func setupButton(){
        self.button.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        self.button.setTitle("다음페이지로", for: .normal)
        self.button.tintColor = .blue
    }
    
    @objc func buttonTouchUp(){
        let viewController = AutoLayoutPractice()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}




    
extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? Cell else { return UICollectionViewCell() }
        cell.title.text = "안녕하세요"
        cell.image.image = UIImage(systemName: "star")
        
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

}
