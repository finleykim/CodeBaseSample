//
//  ResultListCell.swift
//  SearchBar(RxSwift)
//
//  Created by Finley on 2022/06/23.
//

import Foundation
import SnapKit
import Kingfisher



class ResultListCell: UITableViewCell{
    
    let thumbnailImageView = UIImageView()
    let nameLabel = UILabel()
    let titleLabel = UILabel()
    let datetimeLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        thumbnailImageView.contentMode = .scaleToFill
        
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.numberOfLines = 2
        
        datetimeLabel.font = .systemFont(ofSize: 12, weight: .light)
        
        [thumbnailImageView, nameLabel, titleLabel, datetimeLabel].forEach{
            contentView.addSubview($0)
        }
        
        thumbnailImageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.top.trailing.bottom.equalToSuperview().inset(8)
            $0.width.height.equalTo(80)
        }
        
        nameLabel.snp.makeConstraints{
            $0.top.leading.equalToSuperview().inset(8)
            $0.trailing.lessThanOrEqualTo(thumbnailImageView.snp.leading).offset(-8)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(nameLabel)
            $0.trailing.equalTo(thumbnailImageView.snp.leading).offset(-8)
            
        }
        
        datetimeLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(nameLabel)
            $0.trailing.equalTo(titleLabel)
            $0.bottom.equalTo(thumbnailImageView)
        }
    }
    
    //Entity에서 정보를 받으면 어떻게 표현할지 작성
    func setData(_ data: Entity){
        thumbnailImageView.kf.setImage(with: data.thumbnailURL, placeholder: UIImage(systemName: "photo")) 
        nameLabel.text = data.name
        titleLabel.text = data.title
        
        var datetime: String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            let contentDate = data.datetime ?? Date() //만약에 없다면 현재 날짜를 불ㄹ온다
            
            return dateFormatter.string(from: contentDate)
            
        }
        
        datetimeLabel.text = datetime
                                       
    }
}
