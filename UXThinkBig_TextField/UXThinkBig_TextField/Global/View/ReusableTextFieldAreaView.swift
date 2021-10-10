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
    var timer: Timer?
    var timeLeft = 60
    
    
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
            label.sizeToFit()
        }
        label.isHidden = true
        return label
    }()
    
    lazy var customTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.delegate = self
        if let text = descText {
            textField.placeholder = descText
        }
        return textField
    }()
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .orange
        label.sizeToFit()
        
        return label
    }()
    
    lazy var checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = .black
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var checkOrTimerView: UIView = {
        let view = UIView()
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
        addSubviews([descLabel, customTextField, highlightView, checkOrTimerView])
        
        descLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading)
        }
        
        customTextField.snp.makeConstraints {
            $0.top.equalTo(descLabel.snp.bottom).offset(10)
            $0.leading.equalTo(descLabel.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
        }
        
        highlightView.snp.makeConstraints {
            $0.leading.equalTo(descLabel.snp.leading)
            $0.height.equalTo(0.5)
            $0.width.equalTo(customTextField.snp.width)
            $0.bottom.equalTo(customTextField.snp.bottom).offset(10)
        }
        
        checkOrTimerView.snp.makeConstraints {
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.height.equalTo(10)
            $0.centerY.equalTo(customTextField)
        }
        
        if division == .check {
            addSubview(checkmarkImageView)
            checkmarkImageView.snp.makeConstraints {
                $0.top.equalTo(checkOrTimerView.snp.top)
                $0.trailing.equalTo(checkOrTimerView.snp.trailing)
                $0.width.equalTo(10)
                $0.height.equalTo(10)
            }
        }
        else {
            addSubview(timerLabel)
            timerLabel.snp.makeConstraints {
                $0.top.equalTo(checkOrTimerView.snp.top)
                $0.trailing.equalTo(checkOrTimerView.snp.trailing)
            }
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

//MARK: - Timer
extension ReusableTextFieldAreaView {
    func makeTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    @objc func onTimerFires()
    {
        timeLeft -= 1
        timerLabel.text = "\(timeLeft)"
        
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
        }
        print("timer")
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

//MARK: - UITextFieldDelegate
extension ReusableTextFieldAreaView: UITextFieldDelegate {
    
    /// textFieldShouldReturn - 키보드 return 눌렀을 때 Action
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 키보드에서 return 눌렀을 때 다음 textField로 이동합니다.
        textField.resignFirstResponder()
        if textField == customTextField {
            if customTextField.hasText {
                NotificationCenter.default.post(name: .keyboardEnterClicked, object: descText)
            }
        }
        if descText == "인증번호" {
            stopTimer()
        }
        return true
    }
    
    /// textFieldEditingCheck - TextField 입력 체크하는 함수
    private func textFieldEditingCheck() {
        // 텍스트 입력중일 때 함수가 동작하게끔 textField에 타겟을 추가해줍니다.
        customTextField.addTarget(self, action: #selector(textFieldIsEditing(_:)), for: .editingChanged)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !textField.hasText {
            makeAnimation()
        }
        if descText == "인증번호" {
            makeTimer()
        }
        textField.placeholder = ""
        timerLabel.isHidden = false
        descLabel.isHidden = false
        descLabel.textColor = .purple
        highlightView.backgroundColor = .black
    }
    
    /// textFieldIsEditing - textField 입력중일 때
    @objc func textFieldIsEditing(_ TextLabel: UITextField) {
        checkmarkImageView.isHidden = false
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.hasText {
            descLabel.textColor = .lightGray
        }
        else {
            descLabel.isHidden = true
            checkmarkImageView.isHidden = true
            timerLabel.isHidden = true
        }
        textField.placeholder = descText
        highlightView.backgroundColor = .lightGray
    }
}
