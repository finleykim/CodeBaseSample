//
//  ResultList.swift
//  SearchBar(RxSwift)
//
//  Created by Finley on 2022/06/23.
//

//MainViewController를 지켜보면서 이벤트가 발생하면 데이터를 받아와 셀에 표시한다.

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ResultList: UITableView{
    let disposeBag = DisposeBag()
    
    let headerView = FitlerView(
        frame: CGRect(
            origin: .zero, //zero를 기준으로
            size: CGSize(width: UIScreen.main.bounds.width, height: 50) //이 사이즈로 적용한다
        )
    )
    
    //MainViewController의 이벤트를 관찰할 서브젝트
    let cellData = PublishSubject<[Entity]>()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        bind()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //통신코드를 작성할 MainViewController에서 데이터를 받아왔을 때 어떻게 표현할지 작성한다
    private func bind(){
        cellData
            .asDriver(onErrorJustReturn: []) //cellData를 asDriver를 사용해 옵저버블로 만들고, 에러가 발생할 경우 빈 어레이를 반환하도록 한다.
        //drive에서는 데이터를 받았을 때 어떻게 처리할지를 작성하면되는데, 이 때 rx에서 제공하는 item을 사용한다. tableViewDataSource의 cellForRowAt에서 셀을 정의하고 무엇을 표시할지 정하는 것 처럼 작성하면된다.
            .drive(self.rx.items){ tv, row, data in //테이블뷰, 로우, 데이터
                let index = IndexPath(row: row, section: 0) //indexpath의 섹션은 하나뿐이라고 가정해서, 첫번째 섹션에 내가 전달받는 row값에 따라서 index가 만들어진다고 작성
                let cell = tv.dequeueReusableCell(withIdentifier: "ResultListCell", for: index) as! ResultListCell //셀 정의
                cell.setData(data) //셀에 만들어둔 setData메서드를 불러온다. setData에는 데이터를 받으면 각각의 컴포넌트에 어떻게 보여줄지를 정리해두었고, 파라미터로 Entity를 받는다. 아 파라미터에 위에 정의한 에스케이핑 data를 넣으면, PublishSubject인 cellData가 배일형태로 데이터를 전달하면 로우에 따라 하나씩 꺼내준다.
                
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute(){
        //만들어둔 셀과 헤더뷰 적용
        self.register(ResultListCell.self, forCellReuseIdentifier: "ResultListCell")
        self.tableHeaderView = headerView
    }
    
}
