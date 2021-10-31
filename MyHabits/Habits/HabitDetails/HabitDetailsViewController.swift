//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Ален Авако on 24.10.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private lazy var dateTableView: UITableView = {
        let postTableView = UITableView(frame: .zero, style: .grouped)
        postTableView.toAutoLayout()
//        postTableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
        postTableView.separatorInset = .zero
        return postTableView
    }()
}
