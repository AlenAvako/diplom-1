//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Ален Авако on 15.10.2021.
//

import UIKit

class HabitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = UIColor(named: "appLightGray")
        
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func setupNavigationBar() {
        title = "Сегодня"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNew))
        
    }
    
    @objc func addNew() {
        let infoVC = InfoViewController()
        self.present(infoVC, animated: true, completion: nil)
    }
}
