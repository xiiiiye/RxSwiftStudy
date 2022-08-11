//
//  SubscribeViewController.swift
//  RxSwiftStudy
//
//  Created by xpb on 2022/8/5.
//

import UIKit
import RxSwift

class SubscribeViewController: UIViewController {
    
    let disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ob = Observable.of(1, 3, 5)
        
        ob.subscribe { event in
            print("event -- \(event)")
            print("element -- \(String(describing: event.element))")
        }.disposed(by: disposedBag)
        
        ob.subscribe { element in
            print("element == \(element)")
        } onError: { error in
            print("error == \(error)")
        } onCompleted: {
            print("onCompleted")
        } onDisposed: {
            print("onDisposed")
        }.disposed(by: disposedBag)
        
        
    }
}
