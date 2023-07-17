//
//  OnboadingCell.swift
//  FuroOnboardingApp
//
//  Created by 임재현 on 2023/07/17.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    //MARK: - Properties
    private let mainImageView:UIImageView = {
        let iv = UIImageView()
        //iv.image = UIImage(named: "img_nike_nrc")
        return iv
    }()
   
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let descriptionLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mainImageView)
        mainImageView.centerX(inView: self,topAnchor: topAnchor,paddingTop: 100)
        mainImageView.setDimensions(width: 230, height: 230)
        //mainImageView.centerY(inView: self)
        
        addSubview(titleLabel)
        titleLabel.centerX(inView: self,topAnchor: mainImageView.bottomAnchor,paddingTop: 30)
        
        addSubview(descriptionLabel)
        descriptionLabel.centerX(inView: self,topAnchor: titleLabel.bottomAnchor,paddingTop: 49)
        descriptionLabel.anchor(left: leftAnchor,paddingLeft: 50)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Methods
    
    func configure(_ message:OnboardingMessage) {
        
        mainImageView.image = UIImage(named: message.imageName)
        titleLabel.text = message.title
        descriptionLabel.text = message.description
        
        
        
    }
    
    
    
    
    
    
    
}
