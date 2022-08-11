//
//  BindToViewController.swift
//  RxSwiftStudy
//
//  Created by xpb on 2022/8/8.
//

import UIKit
import RxSwift

class BindToViewController: UIViewController {
    
    @IBOutlet weak var obLabel: UILabel!
    
    @IBOutlet weak var obBinder: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 观察者 订阅者
        // AnyObserver 全场景通用
        let observer: AnyObserver<String> = AnyObserver { [weak self] event in
            switch event {
            case .next(let text):
                self?.obLabel.text = text
                
            default:
                break
            }
        }
        
        let observable = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        observable
            .map { "当前索引: \($0)"}
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        
        // Binder  用于特定场景
        // 不会处理错误事件
        // 确保绑定都是在给定的 Scheduler 上执行 默认主现成 MainScheduler.instance
        
        // 这个可以省略, 直接用UILabel.rx.text
        //        let binderServer: Binder<String> = Binder(obBinder) { lable, text in
        //            lable.text = text
        //        }
        
        let obBinderServer = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        obBinderServer
            .map { "obBinder当前索引: \($0)"}
            .bind(to: obBinder.rx.text)
            .disposed(by: disposeBag)
        
    }
    
}
