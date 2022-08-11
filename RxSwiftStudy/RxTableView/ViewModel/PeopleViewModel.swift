//
//  PeopleViewModel.swift
//  RxSwiftStudy
//
//  Created by xpb on 2022/8/3.
//

import Foundation
import RxSwift

struct PeopleListModel {
    let data = Observable.just([
        People(name: "张三", age: 18),
        People(name: "李四", age: 28),
        People(name: "王五", age: 38),
        People(name: "赵六", age: 48)
    ])
}


