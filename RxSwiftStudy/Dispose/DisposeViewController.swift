//
//  DisposeViewController.swift
//  RxSwiftStudy
//
//  Created by xpb on 2022/8/5.
//

import UIKit
import RxSwift

class DisposeViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ob = Observable.of(1,2,3)
        
        let sub = ob.subscribe { event in
            print("subscribe -- \(event)")
        }
        
        sub.dispose()
        sub.disposed(by: disposeBag)
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
