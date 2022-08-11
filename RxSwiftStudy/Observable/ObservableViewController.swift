//
//  ObservableViewController.swift
//  RxSwiftStudy
//
//  Created by xpb on 2022/8/4.
//

import UIKit
import RxSwift
import RxCocoa

enum obError: Error {
    case errorA
    case errorB
}

class ObservableViewController: UIViewController {
    
    let disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // just() 需要一个初始值
        let objust = Observable.just("77")
        
        // of() 接受可变数量的元素 同类型
        let obof = Observable.of("7", "11")
        
        // from() 需要一个数组
        let obfrom = Observable.from(["a", "b", "c"])
        
        // empty() 空序列
        let obempty = Observable<Int>.empty()
        
        // never() 永远不会发出event 也不会终止
        let obnever = Observable<Int>.never()
        
        // error() 发出错误
        let oberror = Observable<Int>.error(obError.errorA)
        
        // range() 一个范围
        let obrange = Observable.range(start: 1, count: 5)
        // Observable.of(1, 2, 3, 4, 5) 跟这个效果一样
        
        // repeatElement() 无限重复发出给定的元素, 永不终止
        let obrepeat = Observable.repeatElement(1)
        
        // generate()  根据判断条件确定是否执行序列  (像 for 循环?)
        let obgenerate = Observable.generate(initialState: 0, condition: { $0 <= 10 }, iterate: { $0 + 2 })
        // (0, 2, 4, 6, 8)
        
        // creat() 接收一个block 类型的参数
        let obcreat = Observable<Int>.create { ob in
            ob.onNext(1)
            ob.onCompleted()
            
            // 订阅会有一个dispoables 的返回值
            return Disposables.create {}
        }
        
        // deferred() 创建一个工厂
        var isOdd = true
        let factory: Observable<Int> = Observable.deferred {
            isOdd = !isOdd
            if isOdd  {
                return Observable.of(1, 3, 5, 7)
            } else {
                return Observable.of(2, 4, 6, 8)
            }
        }
        
        factory.subscribe { event in
            print("第一次订阅 -- \(isOdd) -- \(event)")
        }.disposed(by: disposedBag)
        
        factory.subscribe { event in
            print("第二次订阅 -- \(isOdd) -- \(event)")
        }.disposed(by: disposedBag)
        
        // interval() 定时订阅, 没有延时, 立即执行
        let obinterval = Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        obinterval.subscribe { event in
            print("interval() -- \(event)")
        }.disposed(by: disposedBag)
        
        // timer() 定时器, 有period会重复执行, 没有period 就只执行一次
        let obtimer = Observable<Int>.timer(RxTimeInterval.seconds(5), period: RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)
        obtimer.subscribe { event in
            print("timer() 有重复周期 -- \(event)")
        }.disposed(by: disposedBag)
        
        let obtimer2 = Observable<Int>.timer(RxTimeInterval.seconds(5), scheduler: MainScheduler.instance)
        obtimer2.subscribe { event in
            print("timer2() 无重复周期 -- \(event)")
        }.disposed(by: disposedBag)
        
    }
    
}
