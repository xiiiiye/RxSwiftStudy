//
//  SubjectsViewController.swift
//  RxSwiftStudy
//
//  Created by xpb on 2022/8/8.
//

import UIKit
import RxSwift
import RxRelay

class SubjectsViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Subjects 即时订阅者也是序列
        
        // 1. PublishSubjects 不需要初始值就可以创建
        let publish = PublishSubject<String>()
        
        publish.onNext("0000")
        
        publish.subscribe { string in
            print("第一次订阅, 还没有序列发出", string)
        } onError: { error in
            print("第一次订阅, error", error)
        } onCompleted: {
            print("第一次订阅, onCompleted")
        } onDisposed: {
            print("第一次订阅, onDisposed")
        }.disposed(by: disposeBag)
        
        publish.onNext("1111")
        
        publish.subscribe { string in
            print("第二次订阅", string)
        } onError: { error in
            print("第二次订阅, error", error)
        } onCompleted: {
            print("第二次订阅, onCompleted")
        }.disposed(by: disposeBag)
        
        publish.onNext("2222")
        
        publish.onCompleted()
        
        publish.onNext("3333")
        
        publish.subscribe { string in
            print("第三次订阅", string)
        } onError: { error in
            print("第三次订阅, error", error)
        } onCompleted: {
            print("第三次订阅, onCompleted")
        } onDisposed: {
            print("第三次订阅, onDisposed")
        }.disposed(by: disposeBag)
        
        // BehaviorSubject  热信号, 需要一个默认值来创建
        let behavior = BehaviorSubject(value: "0000")
        behavior.subscribe { event in
            print("behavior -- 第一次订阅", event)
        }.disposed(by: disposeBag)
        
        behavior.onNext("2222")
        
        behavior.onError(NSError(domain: "errorTest", code: 0, userInfo: nil))
        
        behavior.subscribe { event in   // 发出错误之后再订阅就收不到之前的事件了
            print("behavior -- 第二次订阅", event)
        }.disposed(by: disposeBag)
        
        
        // replaySubject  有buffersize  有新订阅会将缓冲区的事件发出
        let replay = ReplaySubject<String>.create(bufferSize: 2)
        
        //第0次订阅, 会发出所有的事件, 就是普通的订阅
        replay.subscribe { event in
            print("replay -- 第0次订阅", event)
        }.disposed(by: disposeBag)
        
        // 发出三个事件
        replay.onNext("111")
        replay.onNext("222")
        replay.onNext("333")
        
        // 第一次订阅, 会把最后两个缓存的事件发出 222, 333
        replay.subscribe { event in
            print("replay -- 第一次订阅", event)
        }.disposed(by: disposeBag)
        
        // 第四次发出事件
        replay.onNext("4444")
        
        //第二次订阅, 会把最新的两个事件发出 333, 444
        replay.subscribe { event in
            print("replay -- 第二次订阅", event)
        }.disposed(by: disposeBag)
        
        replay.onCompleted()  // 结束序列
        
        // 结束序列后再订阅, 还是会把缓冲区的事件发出
        replay.subscribe { event in
            print("replay -- 第三次订阅 序列已结束", event)
        }.disposed(by: disposeBag)
    }
}
