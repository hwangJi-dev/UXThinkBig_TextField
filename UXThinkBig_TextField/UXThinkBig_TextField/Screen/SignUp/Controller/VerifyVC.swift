//
//  VerifyVC.swift
//  UXThinkBig_TextField
//
//  Created by 황지은 on 2021/10/10.
//

import UIKit
import SnapKit

class VerifyVC: UIViewController {
    
    var phoneNumTextField: ReusableTextFieldAreaView?
    var verifyCodeTextField: ReusableTextFieldAreaView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldAttributes()
        addNotiObserver()
        addConstraints()
    }
    
    //MARK: - UI Components
    let headingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "휴대폰 본인 확인"
        label.sizeToFit()
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        label.text = "좋아하는 악세사리를 구매하신 이후, 악세사리의 배송 정보를 해당 번호로 알려드립니다."
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let nextBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.textColor = .white
        btn.setTitle("다음", for: .normal)
        btn.backgroundColor = .black
        return btn
    }()
    
    func setTextFieldAttributes () {
        phoneNumTextField = ReusableTextFieldAreaView(frame: self.view.frame, div: .check, text: "휴대폰 번호")
        verifyCodeTextField = ReusableTextFieldAreaView(frame: self.view.frame, div: .timer, text: "인증번호")
        
        phoneNumTextField?.translatesAutoresizingMaskIntoConstraints = false
        verifyCodeTextField?.translatesAutoresizingMaskIntoConstraints = false
    }
}

//MARK: - Notification
extension VerifyVC {
    
    func addNotiObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(makeAnimation), name: .keyboardEnterClicked, object: nil)
    }
    
    @objc func makeAnimation() {
        // 엔터키 눌리면 인증뷰 나타나는 animation
        print("makeAnimation")
        self.view.addSubview(verifyCodeTextField ?? UIView())
        verifyCodeTextField?.snp.makeConstraints {
            // phoneNumTextField와 constraint가 잡히지 않음에 따라 descLabel과의 간격 설정
            // offset(95) => descLabel 간격 30 + height 50 + top으로 주려고 했던 offset 15
            $0.top.equalTo(descLabel.snp.bottom).offset(95)
            $0.leading.equalTo(headingLabel.snp.leading)
            $0.trailing.equalTo(descLabel.snp.trailing)
            $0.height.equalTo(50)
        }
        verifyCodeTextField?.customTextField.becomeFirstResponder()
        
        // Noti 최초 1회 실행 후 메모리 해제
        NotificationCenter.default.removeObserver(self, name: .keyboardEnterClicked, object: nil)
    }
}

//MARK: - UI Layout
extension VerifyVC {
    func addConstraints() {
        self.view.addSubviews([ headingLabel, descLabel,
                                phoneNumTextField ?? UIView(),
                                nextBtn ])
        
        headingLabel.snp.makeConstraints {
            $0.top.equalTo(self.view).offset(100)
            $0.leading.equalTo(self.view).offset(30)
        }
        
        descLabel.snp.makeConstraints {
            $0.top.equalTo(headingLabel.snp.bottom).offset(10)
            $0.leading.equalTo(headingLabel.snp.leading)
            $0.trailing.equalTo(self.view).offset(-30)
        }
        
        phoneNumTextField?.snp.makeConstraints {
            $0.top.equalTo(descLabel.snp.bottom).offset(30)
            $0.leading.equalTo(headingLabel.snp.leading)
            $0.trailing.equalTo(descLabel.snp.trailing)
            $0.height.equalTo(50)
        }
    }
}
