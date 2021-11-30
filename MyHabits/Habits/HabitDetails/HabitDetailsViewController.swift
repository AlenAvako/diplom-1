//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Ален Авако on 24.10.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    var habitIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "appLightGray")
        
        self.navigationItem.largeTitleDisplayMode = .never
        
        setupNavigationBar()
        
        setupTableView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dateTableView.reloadData()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .done, target: self, action: #selector(change))
    }
    
    private lazy var dateTableView: UITableView = {
        let postTableView = UITableView(frame: .zero, style: .grouped)
        postTableView.toAutoLayout()
        postTableView.register(HabitDatesTableViewCell.self, forCellReuseIdentifier: HabitDatesTableViewCell.id)
        postTableView.separatorInset = .zero
        return postTableView
    }()
    
    func setupTableView() {
        view.addSubview(dateTableView)
        dateTableView.contentInsetAdjustmentBehavior = .scrollableAxes
        dateTableView.translatesAutoresizingMaskIntoConstraints = false
        
        dateTableView.dataSource = self
        dateTableView.delegate = self
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            dateTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dateTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dateTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            dateTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if HabitsStore.shared.dates.count > 5 {
            return 5
        } else {
            return HabitsStore.shared.dates.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.doesRelativeDateFormatting = true
        
        let cell = dateTableView.dequeueReusableCell(withIdentifier: HabitDatesTableViewCell.id, for: indexPath) as! HabitDatesTableViewCell
        
        let dateArray: [Date] = Array(HabitsStore.shared.dates.reversed())
        let sortHabitArray = HabitsStore.shared.habits
        cell.textLabel?.text = formatter.string(from: dateArray[indexPath.row])

        if indexPath.row == 0 {
            cell.isHidden = true
        }

        
        if HabitsStore.shared.habit(sortHabitArray[habitIndex], isTrackedIn: dateArray[indexPath.item]) {
                cell.accessoryType = .checkmark
                cell.tintColor = UIColor(named: "appPurple")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let header = "АКТИВНОСТЬ"
        
        let headerInset: CGFloat = 16
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: headerInset, bottom: 0, right: 0)

        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 0
        } else {
            return 44
        }
    }
}

extension HabitDetailsViewController {
    @objc func change() {
        let habitVC = HabitViewController()
        let habitNC = UINavigationController(rootViewController: habitVC)
        habitNC.modalPresentationStyle = .fullScreen
        self.present(habitNC, animated: true, completion: nil)
        
        navigationController?.popViewController(animated: true)

        let store = HabitsStore.shared.habits[habitIndex]
        
        habitVC.title = "Править"

        habitVC.colorPickerButton.backgroundColor = store.color
        habitVC.colorPickerButton.layer.borderColor = store.color.cgColor
        
        habitVC.titleText = store.name
        habitVC.titleTextField.text = store.name
        habitVC.titleTextField.textColor = UIColor(named: "appBlue")
        
        habitVC.newColor = store.color
        
        habitVC.habitIndex = self.habitIndex
        habitVC.date = store.date
        
        habitVC.habitDates = store.trackDates
        
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.short
        formatter.dateFormat = "hh:mm a"
        formatter.locale = Locale(identifier: "ru_RU")
        let strDate = formatter.string(from: store.date)
        
        habitVC.timeField.text = "\(strDate)"
        
        habitVC.deleteButton.alpha = 1
        
        habitVC.isAdded = true
    }
}
