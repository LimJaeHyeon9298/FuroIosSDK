//
//  OnboardingViewController.swift
//  FuroOnboardingApp
//
//  Created by 임재현 on 2023/07/17.
//
import UIKit



private let reuseIdentifier = "OnboardingCell"

class OnboardingViewController: UIViewController {
    
    
    let messages:[OnboardingMessage] = OnboardingMessage.messages
    
    private let backgroundImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "img_onboarding_bg")
        return iv
    }()
    
    private lazy var collectionView:UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        flowlayout.minimumLineSpacing = 20.0
        
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .white
        // cv.backgroundColor = .blue
        return cv
    }()
    
    private let pageControl:UIPageControl = {
        let pageControl = UIPageControl()
        return pageControl
        
    }()
    
    
    
    
    private let loginButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("홈페이지 이동", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    private let moveToHPButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("문의하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(moveToHPButtonTapped), for: .touchUpInside)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
    }
    
    
    
    func configureUI() {
        
        view.addSubview(backgroundImageView)
        backgroundImageView.anchor(top: view.topAnchor,left: view.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor)
        
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor,paddingBottom: 250)
        collectionView.backgroundColor = .clear
        
        
        
        pageControl.backgroundColor = .clear
        pageControl.numberOfPages = messages.count
        

        let stackButton = UIStackView(arrangedSubviews: [moveToHPButton,loginButton])
        stackButton.axis = .horizontal
        stackButton.distribution = .fillEqually
        stackButton.alignment = .fill
        stackButton.spacing = 1

        view.addSubview(stackButton)
        stackButton.anchor(left: view.safeAreaLayoutGuide.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.safeAreaLayoutGuide.rightAnchor,height: 60)
        
        view.addSubview(pageControl)
        pageControl.centerX(inView: view)
        pageControl.anchor(top: collectionView.bottomAnchor,paddingTop: 60)
    }
    
    @objc func loginButtonTapped() {

        guard let url = URL(string: "https://www.furo.one/") else {
            return
        }

        //  Check if the url can be opened
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)


          
        }

      

    }

    @objc func moveToHPButtonTapped() {
        print("webSite 이동")


        guard let url = URL(string: "https://docs.furo.one/extras/faq") else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }





    }
}

extension OnboardingViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? OnboardingCell else {
            return UICollectionViewCell()
        }
        
        let message = messages[indexPath.item]
        cell.configure(message)
        return cell
        
    }
}



extension OnboardingViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}


extension OnboardingViewController:UIScrollViewDelegate {
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / self.collectionView.bounds.width)
        
        pageControl.currentPage = index
    }
    
}



