//
//  SearchBar.swift
//  SearchBar(RxSwift)
//
//  Created by Finley on 2022/06/20.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SearchBar: UISearchBar{
    

    let disposbag = DisposeBag()
    let searchButton = UIButton() //검색버튼
    
    let searchButtonTapped = PublishRelay<Void>() //검색버튼 눌렀을 때 발생하는 이벤트 구독 (UI에서 발생하는 이벤트는 error방출 없는 PublishRelay가 적절하다)
    var shouldLoadResult = Observable<String>.of("") //검색버튼이 눌려진 후 SearchBar의 text를 상위 뷰로 전달하는 ShouldloadResult이벤트 Sequnce. 초기값은 빈값 ""
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // -> Reative - Bind (searchBar 이벤트 )
    private func bind() {
        // Observable은 관찰하고있다가 .merge로 합쳐둔 두 가지 액션 중 하나가 발생하면 searchButtonTapped에게 이벤트 보냄
        Observable
            .merge( //두가지 경우 합침
                searchButton.rx.tap.asObservable(), //searchButton눌렀을 때
                self.rx.searchButtonClicked.asObservable() //키보드의 검색버튼 눌렀을 때
                //asObservable로 타입변환 (타입변환 전에는 ControlEvent<Void>타입임)
            )
            .bind(to: searchButtonTapped) //searchButtonTapped가 위 두 이벤트가 발생할 때 마다 알 수 있도록 bind
            .disposed(by: disposbag)
        
        //asSignal로 Observable이 된 searchButtonTapped은 관찰하고있다가
        searchButtonTapped //searchButtonTapped가 발생하면 키보드가 내려가야함
            .asSignal() //asSignal로 PublishRealy -> observable()로 변환
        //구독 이후의 이벤트만 제공하고, 메인스트림에서 실행하며 error를 방출하지 않기 때문에 UI이벤트를 다룰 때 asSignal()이 적절
            .emit(to: self.rx.endEditing) //키보드가 내려가는 이벤트 방출
        //Signal에서는 emit()을, Driver에서는 drive()를 사용한다.
        //이 때, RxCocoa에서 endEditing을 지우너하지 않기 때문에 extension으로 endEditing을 작성해야함.
            .disposed(by: disposbag)
        
        self.shouldLoadResult = searchButtonTapped //searchButtonTapped가 실행되면 ShouldloadResult가 실행되어야한다. (ShouldLoadResult는 상위뷰에 SearchBar의 Text를 전달한다)즉, searhcButtonTapped는 shouldLoadResult의 trigger임
            .withLatestFrom(self.rx.text) { $1 ?? "" } //SearchBar의 가장 최신 text를 전달
            .filter { !$0.isEmpty } //text가 비어있지 않은 경우에만 전달하도록 필터링
            .distinctUntilChanged() //text가 중복인 경우 전달하지 않는다
    }
    
    // -> UI - View attribution (searchBar의 UI설정)
    private func attribute() {
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    // -> UI - SubviewLayout (레이아웃설정)
    private func layout() {
        self.addSubview(searchButton)
        
        searchTextField.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(12)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-12)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}


extension Reactive where Base: SearchBar{
    var endEditing: Binder<Void>{
        return Binder(base){ base, _ in
            base.endEditing(true)
        }
    }
}
