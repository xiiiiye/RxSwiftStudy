//
//  ViewController.swift
//  RxSwiftStudy
//
//  Created by xpb on 2022/8/3.
//

import UIKit

class ViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        
        switch indexPath.row {
        case 0:
            let vc = PeopleViewController.init()
            navigationController?.pushViewController(vc, animated: true)
            
        case 1:
            let vc = ObservableViewController.init()
            navigationController?.pushViewController(vc, animated: true)
            
        case 2:
            let vc = SubscribeViewController.init()
            navigationController?.pushViewController(vc, animated: true)
            
        case 3:
            let vc = DoOnViewController.init()
            navigationController?.pushViewController(vc, animated: true)
            
        case 4:
            let vc = DisposeViewController.init()
            navigationController?.pushViewController(vc, animated: true)
            
        case 5:
            let vc = BindToViewController.init()
            navigationController?.pushViewController(vc, animated: true)
            
        case 6:
            let vc = RxExViewController.init()
            navigationController?.pushViewController(vc, animated: true)
            
        case 7:
            let vc = SubjectsViewController.init()
            navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
        }
    }
}

