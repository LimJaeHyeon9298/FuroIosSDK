//
//  OnboardingMessage.swift
//  FuroOnboardingApp
//
//  Created by 임재현 on 2023/07/17.
//

import Foundation

struct OnboardingMessage {
    let imageName: String
    let title: String
    let description: String
}

extension OnboardingMessage {
    static let messages: [OnboardingMessage] = [
        OnboardingMessage(imageName: "KakaoTalk_Photo_2023-07-11-09-45-37", title: "", description: "퓨로는 모던 어플리케이션을 위한 아이덴티티 솔루션입니다.\n 지금 당장 furo 서비스를 사용해보세요 1분만에 로그인 페이지를 만들어 드립니다"),
        OnboardingMessage(imageName: "userFlow", title: "유저가 좋아할 만한 flow", description: "매달 자동으로 A/B 테스트를 실행하고, 유저에 대한 모든 데이터를 정확하고 편리하게 보여드립니다. 퓨로가 전환율을 얼마나 개선하고 있는지 직접 확인해보세요."),
        OnboardingMessage(imageName: "standardData", title: "표준화 된 데이터로 관리", description: "유저 데이터, 더 이상 복잡하지 않습니다. 로그인 채널이 다양해도, 데이터가 조각나거나 중복되어도 문제 없어요. 똑똑하게 관리하실 수 있도록 퓨로가 도와드립니다."),   OnboardingMessage(imageName: "wholeBrowser", title: "모든 브라우저 환경에서", description: "로그인 박스 그 이상의 사용자 경험을 선사하세요. 현재 상용화된 모든 디바이스와 브라우저를 지원합니다."),OnboardingMessage(imageName: "customSkin", title: "나만의 로그인 화면 디자인", description: "당신의 제품에 통일성 있는 사용자경험이 중요하다는것을 퓨로는 잘 알고있습니다. 매끄러운 로그인을 위한 완벽한 커스터마이징을 지원합니다.")
    ]
    
}

