//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Ален Авако on 15.10.2021.
//

import UIKit

class HabitViewController: UIViewController {
    
    var habitIndex: Int = 0
    
    var isAdded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupNavigationBar()
        setupView()
    }
    
    private func setupNavigationBar() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(save))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancel))
    }
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    fileprivate lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.toAutoLayout()
        return contentView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.text = "НАЗВАНИЕ"
        return label
    }()
    
    lazy var titleText: String = ""
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.toAutoLayout()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.addTarget(self,
                           action: #selector(titleTextChanged(_:)),
                           for: .editingChanged)
        textField.returnKeyType = .done
        textField.tintColor = .systemGray2
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 17)
        return textField
    }()
    
    lazy var colorPickerLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.text = "ЦВЕТ"
        return label
    }()
    
    lazy var newColor: UIColor? = .black
    
    lazy var colorPickerButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.addTarget(self, action: #selector(pickColor), for: .touchUpInside)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 15
        return button
    }()
    
    lazy var date = Date()
    
    lazy var habitDates: [Date] = []
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.text = "ВРЕМЯ"
        return label
    }()
    
    lazy var dateField: UILabel = {
        let textField = UILabel()
        textField.toAutoLayout()
        textField.text = "Каждый день в"
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return textField
    }()
    
    lazy var timeField: UILabel = {
        let textField = UILabel()
        textField.toAutoLayout()
        textField.text = ""
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.textColor = UIColor(named: "appPurple")
        return textField
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.toAutoLayout()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(handler(sender:)), for: .valueChanged)
        return datePicker
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(UIColor(named: "appRed"), for: .normal)
        button.alpha = 0
        return button
    }()
    
    func setupView() {
        view.addSubviews(titleLabel, titleTextField, colorPickerLabel, colorPickerButton, dateLabel, dateField, timeField, datePicker, deleteButton)
        
        NSLayoutConstraint.activate([

            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            titleTextField.heightAnchor.constraint(equalToConstant: 22),
            
            colorPickerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            colorPickerLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15),
            
            colorPickerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            colorPickerButton.topAnchor.constraint(equalTo: colorPickerLabel.bottomAnchor, constant: 7),
            colorPickerButton.widthAnchor.constraint(equalToConstant: 30),
            colorPickerButton.heightAnchor.constraint(equalToConstant: 30),
            
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateLabel.topAnchor.constraint(equalTo: colorPickerButton.bottomAnchor, constant: 15),
            
            dateField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 7),
            
            timeField.leadingAnchor.constraint(equalTo: dateField.trailingAnchor, constant: 5),
            timeField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 7),
            
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            datePicker.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: 15),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: 216),
            
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
            deleteButton.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
}

extension HabitViewController {
    @objc func save() {
        if titleText.isEmpty {
            let alert = UIAlertController(title: "Название не заполнено", message: "Заполните название", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        } else {
            let newHabit = Habit(name: titleText, date: date, trackDates: habitDates, color: newColor ?? .black)
            let store = HabitsStore.shared
            self.dismiss(animated: true, completion: nil)
            
            if isAdded == false {
                store.habits.append(newHabit)
            } else if isAdded == true {
                store.habits.remove(at: habitIndex)
                store.habits.insert(newHabit, at: habitIndex)
            }
        }
    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func deleteHabit() {
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \(titleText)?", preferredStyle: .alert)
        let cancleButton = UIAlertAction(title: "отмена", style: .cancel, handler: nil)
        let deleteButton = UIAlertAction(title: "Удалить", style: .destructive, handler: deleteCurrentHabit(_:))
        alert.addAction(cancleButton)
        alert.addAction(deleteButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteCurrentHabit(_ action: UIAlertAction) {
        let store = HabitsStore.shared
        store.habits.remove(at: habitIndex)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func pickColor() {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true)
    }
    
    @objc func handler(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.short
        formatter.dateFormat = "hh:mm a"
        formatter.locale = Locale(identifier: "ru_RU")
        let strDate = formatter.string(from: sender.date)
        
        timeField.text = "\(strDate)"
        date = sender.date
    }
    
    @objc private func titleTextChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        titleText = text
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        let myColor = viewController.selectedColor
        colorPickerButton.backgroundColor = color
        colorPickerButton.layer.borderColor = color.cgColor
        newColor = myColor
    }
}


