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
        
        self.navigationItem.largeTitleDisplayMode = .always
        
        habitsCollectionView.delegate = self
        habitsCollectionView.dataSource = self
        
        view.addSubview(habitsCollectionView)
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        habitsCollectionView.reloadData()
    }
    
    lazy var habitsCollectionView: UICollectionView = {
        let habitCollectionLayout = UICollectionViewFlowLayout()
        habitCollectionLayout.scrollDirection = .vertical
        let habitsCollection = UICollectionView(frame: .zero, collectionViewLayout: habitCollectionLayout)
        habitsCollection.toAutoLayout()
        habitsCollection.backgroundColor = UIColor(named: "appLightGray")
        habitsCollection.register(HabitsCollectionViewCell.self, forCellWithReuseIdentifier: HabitsCollectionViewCell.id)
        habitsCollection.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.id)
        return habitsCollection
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            habitsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        title = "Сегодня"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNew))
        
    }
    
    @objc func addNew() {
        let habitVC = HabitViewController()
        habitVC.title = "Создать"
        habitVC.isAdded = false
        let habitNC = UINavigationController(rootViewController: habitVC)
        habitNC.modalPresentationStyle = .fullScreen
        self.present(habitNC, animated: true, completion: nil)
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = habitsCollectionView.dequeueReusableCell(withReuseIdentifier: ProgressCollectionViewCell.id, for: indexPath) as! ProgressCollectionViewCell
            cell.configureCell(progress: HabitsStore.shared.todayProgress)
            return cell
        } else {
            let cell = habitsCollectionView.dequeueReusableCell(withReuseIdentifier: HabitsCollectionViewCell.id, for: indexPath) as! HabitsCollectionViewCell
            cell.configureCell(color: HabitsStore.shared.habits[indexPath.row].color,
                               name: HabitsStore.shared.habits[indexPath.row].name,
                               date: HabitsStore.shared.habits[indexPath.row].date,
                               trackDates: HabitsStore.shared.habits[indexPath.row].trackDates)
            
            cell.markView.tag = indexPath.row
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.track))
            cell.markView.addGestureRecognizer(gesture)
            
            let store = HabitsStore.shared
            
            for (i, value) in store.habits.enumerated() {
                if cell.markView.tag == i {
                    if value.isAlreadyTakenToday == false {
                        cell.markView.backgroundColor = .white
                        cell.markImage.alpha = 0
                    } else if value.isAlreadyTakenToday == true {
                        cell.markView.backgroundColor = UIColor(cgColor: cell.markView.layer.borderColor ?? UIColor.black.cgColor)
                        cell.markImage.alpha = 1
                    }
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            let itemsPerRow: CGFloat = 1
            let paddindWidth = 16.5 * (itemsPerRow + 1)
            let accessibleWidth = collectionView.frame.width - paddindWidth
            let widthPerItem = accessibleWidth / itemsPerRow
            return CGSize(width: widthPerItem, height: 130)
        } else {
            let itemsPerRow: CGFloat = 1
            let paddindWidth = 16.5 * (itemsPerRow + 1)
            let accessibleWidth = collectionView.frame.width - paddindWidth
            let widthPerItem = accessibleWidth / itemsPerRow
            return CGSize(width: widthPerItem, height: 60)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 17)
        }
        return UIEdgeInsets(top: 18, left: 16, bottom: 10, right: 17)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let habitDetailsVC = HabitDetailsViewController()
            habitDetailsVC.habitIndex = indexPath.item
            habitDetailsVC.title = HabitsStore.shared.habits[indexPath.row].name
            navigationController?.pushViewController(habitDetailsVC, animated: true)
        }
    }
    
    @objc func track(_ gesture: UITapGestureRecognizer) {
        let index = gesture.view?.tag
        let store = HabitsStore.shared

        for (i, value) in store.habits.enumerated() {
            if index == i {
                if value.isAlreadyTakenToday == false {
                    store.track(value)
                } else {
                    return
                }
            }
        }
        habitsCollectionView.reloadData()
    }
}


