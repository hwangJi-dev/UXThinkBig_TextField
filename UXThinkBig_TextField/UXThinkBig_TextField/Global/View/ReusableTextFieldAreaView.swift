//
//  ReusableTextFieldAreaView.swift
//  UXThinkBig_TextField
//
//  Created by 황지은 on 2021/10/11.
//

import UIKit
import SnapKit

enum EditCompleteStatus {
    case check, timer
}

class ReusableTextFieldAreaView: UIView {
    
    let xibName = "ReusableTextFieldAreaView"
    var descText: String?
    var division: EditCompleteStatus?
    
    init(frame: CGRect, div: EditCompleteStatus, text: String) {
        super.init(frame: frame)
        self.descText = text
        self.division = div
        commonInit()
        addConstraints()
        textFieldEditingCheck()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    //MARK: - UI Components
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .lightGray
        if let text = descText {
            label.text = descText
        }
        label.isHidden = true
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.delegate = self
        if let text = descText {
            textField.placeholder = descText
        }
        return textField
    }()
    
    private lazy var checkOrTimerView: UIView = {
        let view = UIView()
        if let status = division {
            switch status {
            case .check:
                print("checkbox")
            case .timer:
                print("timer")
            }
        }
        view.isHidden = true
        return view
    }()
    
    let highlightView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private func commonInit() {
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
}

//MARK: - UI Layout
extension ReusableTextFieldAreaView {
    func addConstraints() {
        addSubviews([descLabel, textField, highlightView, checkOrTimerView])
        
        descLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading)
            $0.width.equalTo(30)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(descLabel.snp.bottom).offset(10)
            $0.leading.equalTo(descLabel.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
        }
        
        highlightView.snp.makeConstraints {
            $0.leading.equalTo(descLabel.snp.leading)
            $0.height.equalTo(1)
            $0.width.equalTo(textField.snp.width)
            $0.bottom.equalTo(textField.snp.bottom).offset(10)
        }
        
        checkOrTimerView.snp.makeConstraints {
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.height.equalTo(10)
            $0.centerY.equalTo(textField)
        }
    }
}

//MARK: - UI Animation
extension ReusableTextFieldAreaView {
    
    func makeAnimation() {
        self.descLabel.frame = CGRect(x: 0, y: 20, width: self.descLabel.frame.width, height: self.descLabel.frame.height)
        descLabel.alpha = 0.5
        
        UIView.animate(withDuration: 0.3, animations: { [self] in
            descLabel.frame = CGRect(x: 0, y: 0, width: descLabel.frame.width, height: descLabel.frame.height)
            descLabel.alpha = 1
        })
    }
}

//MARK: - UITextFieldDelegate
extension ReusableTextFieldAreaView: UITextFieldDelegate {
    
    /// textFieldShouldReturn - 키보드 return 눌렀을 때 Action
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 키보드에서 return 눌렀을 때 다음 textField로 이동합니다.
        textField.resignFirstResponder()
        return true
    }
    
    /// textFieldEditingCheck - TextField 입력 체크하는 함수
    private func textFieldEditingCheck() {
        
        // 텍스트 입력중일 때 함수가 동작하게끔 textField에 타겟을 추가해줍니다.
        textField.addTarget(self, action: #selector(textFieldIsEditing(_:)), for: .editingChanged)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !textField.hasText {
            makeAnimation()
        }
        textField.placeholder = ""
        descLabel.isHidden = false
        descLabel.textColor = .purple
        highlightView.backgroundColor = .black
    }
    
    /// textFieldIsEditing - nameTextField 입력중일 때
    @objc func textFieldIsEditing(_ TextLabel: UITextField) {
        checkOrTimerView.isHidden = false
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.hasText {
            descLabel.textColor = .lightGray
        }
        else {
            descLabel.isHidden = true
        }
        textField.placeholder = descText
        highlightView.backgroundColor = .lightGray
    }
}
