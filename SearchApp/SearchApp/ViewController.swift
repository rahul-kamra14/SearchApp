//
//  ViewController.swift
//  SearchApp
//
//  Created by Rahul Kamra on 25/04/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func moveToSearch() {
        let searchVc = SearchListViewController()
        self.navigationController?.pushViewController(searchVc, animated: true)
    }


}
