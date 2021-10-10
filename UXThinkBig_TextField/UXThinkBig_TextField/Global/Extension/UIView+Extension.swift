//
//  UIView+Extension.swift
//  UXThinkBig_TextField
//
//  Created by 황지은 on 2021/10/11.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
