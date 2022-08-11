//
//  DoOnViewController.swift
//  RxSwiftStudy
//
//  Created by xpb on 2022/8/5.
//

import UIKit
import RxSwift

class DoOnViewController: UIViewController {
    
    // doOn 用来监听事件的生命周期, 它会在每一次事件发送前被调用
    // doOn 和 Subscribe 是一样的
    // do(onNext:) 会在 subscribe(onNext:) 之前调用
    // do(onCompleted:) 会在 subscribe(onCompleted:) 之前调用
    
    let disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ob = Observable.of(1, 2, 3)
        
        ob.do { element in
            print("do -- \(element)")
        } afterNext: { next in
            print("do afterNext -- \(next)")
        } onError: { onError in
            print("do onError -- \(onError)")
        } afterError: { afterError in
            print("do afterError -- \(afterError)")
        } onCompleted: {
            print("do -- onCompleted")
        } afterCompleted: {
            print("do -- afterCompleted")
        } onSubscribe: {
            print("do -- onSubscribe")
        } onSubscribed: {
            print("do -- onSubscribed")
        } onDispose: {
            print("do -- onDispose")
        }
        .subscribe { element in
            print("subscribe -- \(element)")
        } onError: { error in
            print("subscribe -- \(error)")
        } onCompleted: {
            print("subscribe -- onCompleted")
        } onDisposed: {
            print("subscribe -- onDisposed")
        }.disposed(by: disposedBag)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
