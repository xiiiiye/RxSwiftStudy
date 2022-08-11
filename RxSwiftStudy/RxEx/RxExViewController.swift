//
//  RxExViewController.swift
//  RxSwiftStudy
//
//  Created by xpb on 2022/8/8.
//

import UIKit
import RxSwift

class RxExViewController: UIViewController {
    
    @IBOutlet weak var exLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ob = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        ob
            .map { CGFloat($0) }
            .bind(to: exLabel.rx.fontSize)
            .disposed(by: disposeBag)
    }
    
}

extension Reactive where Base: UILabel {   // 扩展rxswift
    
    public var textWhite: Binder<CGFloat> {
        return Binder(self.base) { label, textWhite in
            if textWhite < 1000 {
                label.textColor = UIColor.init(white: textWhite / 1000, alpha: 1)
            }
        }
    }
    
    public var fontSize: Binder<CGFloat> {
        return Binder(self.base) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}

//extension UILabel {   // 常规写法, 扩展UILabel
//
//    public var fontSize: Binder<CGFloat> {
//        return Binder(self) { label, fontSize in
//            label.font = UIFont.systemFont(ofSize: fontSize)
//        }
//    }
//
//    public var textWhite: Binder<CGFloat> {
//        return Binder(self) { label, white in
//
//            label.textColor = UIColor.init(white: white/10, alpha: 1)
//        }
//    }
//}
