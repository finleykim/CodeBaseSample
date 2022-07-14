//
//  ViewController.swift
//  LayoutAnchors
//
//  Created by Finley on 2022/07/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view1 = UIView()
        view1.backgroundColor = .systemRed
        view1.layer.cornerRadius = 50
        
        view.addSubview(view1)
        
        view1.translatesAutoresizingMaskIntoConstraints = false
        view1.widthAnchor.constraint(equalToConstant: 100).isActive = true
        view1.heightAnchor.constraint(equalToConstant: 100).isActive = true
        view1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true //superView기준 가운데정렬
        view1.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let view2 = UIView()
        view2.backgroundColor = .systemPurple
        view2.layer.cornerRadius = 25
        
        view.addSubview(view2)
        
        view2.translatesAutoresizingMaskIntoConstraints = false
        view2.widthAnchor.constraint(equalToConstant: 50).isActive = true
        view2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view2.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -90).isActive = true
        
        let view3 = UIView()
        view3.backgroundColor = .systemBlue
        view3.layer.cornerRadius = 25
        
        view.addSubview(view3)
        
        view3.translatesAutoresizingMaskIntoConstraints = false
        view3.widthAnchor.constraint(equalToConstant: 50).isActive = true
        view3.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view3.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 90).isActive = true
        
        let view4 = UIView()
        view4.backgroundColor = .systemGreen
        view4.layer.cornerRadius = 25
        
        view.addSubview(view4)
        
        view4.translatesAutoresizingMaskIntoConstraints = false
        view4.widthAnchor.constraint(equalToConstant: 50).isActive = true
        view4.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view4.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -90).isActive = true
        view4.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let view5 = UIView()
        view5.backgroundColor = .systemYellow
        view5.layer.cornerRadius = 25
        
        view.addSubview(view5)
        
        view5.translatesAutoresizingMaskIntoConstraints = false
        view5.widthAnchor.constraint(equalToConstant: 50).isActive = true
        view5.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view5.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 90).isActive = true
        view5.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    //MARK: 함수로 구현할 경우
    
    //함수구현
    private func createView(color: UIColor, cornerRadius: CGFloat) -> UIView {
        let cview = UIView()
        view.addSubview(cview)
        cview.backgroundColor = color
        cview.layer.cornerRadius = cornerRadius
        
        return cview
    }
    
    private func setWidthHeightTraslate(subView: UIView, width: CGFloat, height: CGFloat){
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    //적용
    private func attribute(){
        let view1 = createView(color: .systemRed, cornerRadius: 50)
        setWidthHeightTraslate(subView: view1, width: 100, height: 100)
        view1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view1.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
}

