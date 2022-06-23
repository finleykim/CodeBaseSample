//
//  FilterView(sampleA).swift
//  SearchBar(RxSwift)
//
//  Created by Finley on 2022/06/23.
//

//메인뷰에서 검색결과 정렬항목(이름순,날짜순)알럿을 띄울 수 있도록 버튼을 제공하는 뷰. 테이블헤더뷰로서 UITableViewController에서 적용한다. 다만 이 샘플에서 데이터정렬 기능을 구현하지 않을 것이므로 표시만 해두고 실제로 기능을 넣어 사용하지는 않을 것!


import Foundation
import UIKit
import RxSwift
import RxRelay
import SnapKit

class FitlerView: UITableViewHeaderFooterView{
    let disposeBag = DisposeBag()
    
    let sortButton = UIButton() //메인뷰에서 알럿띄우는 액션을 가질 버튼
    let bottomBorder = UIView() //하단 경계선
    
    let sortButtonTapped = PublishRelay<Void>() //버튼 눌리는 이벤트 구독. 외부(메인뷰)에 이벤트 전달
    
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(){
        sortButton.rx.tap  //sortButton이 탭 되었을 때
            .bind(to: sortButtonTapped) //sortButtonTapped에 알린다
            .disposed(by: disposeBag)
    }
    
    private func attribute(){
        sortButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        bottomBorder.backgroundColor = .lightGray
    }
    
    private func layout(){
        [sortButton, bottomBorder]
            .forEach{
                addSubview($0)
            }
        
        sortButton.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
            $0.width.height.equalTo(28)
        }
        
        bottomBorder.snp.makeConstraints{
            $0.top.equalTo(sortButton.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    


    
}
