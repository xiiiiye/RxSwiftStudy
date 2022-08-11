//
//  PeopleViewController.swift
//  RxSwiftStudy
//
//  Created by xpb on 2022/8/3.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class PeopleViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let peopleList = PeopleListModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        peopleList.data.bind(to: tableView.rx.items(cellIdentifier: "Cell")) { _, model, cell in
            cell.textLabel?.text = model.name
            cell.detailTextLabel?.text = "\(model.age ?? 0)"
            cell.isSelected = false
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(People.self).subscribe { people in
            print(people)
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe { indexPath in
            print(indexPath)
        }.disposed(by: disposeBag)


    }
}
