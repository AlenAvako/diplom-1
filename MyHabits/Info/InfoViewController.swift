//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Ален Авако on 15.10.2021.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Информация"
        view.backgroundColor = .white
        
        setupView()
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

    lazy var label: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "Привычка за 21 день"
        return label
    }()
    
    lazy var infoSection: UILabel = {
        let text = UILabel()
        text.toAutoLayout()
        text.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        text.text = "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:"
        text.textColor = .black
        text.numberOfLines = 0
        return text
    }()
    
    lazy var textSectionOne: UILabel = {
        let text = UILabel()
        text.toAutoLayout()
        text.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        text.text = "1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага."
        text.textColor = .black
        text.numberOfLines = 0
        return text
    }()
    
    lazy var textSectionTwo: UILabel = {
        let text = UILabel()
        text.toAutoLayout()
        text.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        text.text = "2. Выдержать 2 дня в прежнем состоянии самоконтроля."
        text.textColor = .black
        text.numberOfLines = 0
        return text
    }()
    
    lazy var textSectionThree: UILabel = {
        let text = UILabel()
        text.toAutoLayout()
        text.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        text.text = "3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться."
        text.textColor = .black
        text.numberOfLines = 0
        return text
    }()
    
    lazy var textSectionFour: UILabel = {
        let text = UILabel()
        text.toAutoLayout()
        text.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        text.text = "4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств."
        text.textColor = .black
        text.numberOfLines = 0
        return text
    }()
    
    lazy var textSectionFive: UILabel = {
        let text = UILabel()
        text.toAutoLayout()
        text.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        text.text = "5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой."
        text.textColor = .black
        text.numberOfLines = 0
        return text
    }()
    
    lazy var textSectionSix: UILabel = {
        let text = UILabel()
        text.toAutoLayout()
        text.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        text.text = "6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся."
        text.textColor = .black
        text.numberOfLines = 0
        return text
    }()
    
    lazy var sourceTextSection: UILabel = {
        let text = UILabel()
        text.toAutoLayout()
        text.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        text.text = "Источник: psychbook.ru"
        text.textColor = .black
        text.numberOfLines = 0
        return text
    }()
    
    private func setupView() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(label, infoSection, textSectionOne, textSectionTwo, textSectionThree, textSectionFour, textSectionFive, textSectionSix, sourceTextSection)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            
            infoSection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoSection.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
            infoSection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            textSectionOne.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textSectionOne.topAnchor.constraint(equalTo: infoSection.bottomAnchor, constant: 12),
            textSectionOne.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            textSectionTwo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textSectionTwo.topAnchor.constraint(equalTo: textSectionOne.bottomAnchor, constant: 12),
            textSectionTwo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            textSectionThree.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textSectionThree.topAnchor.constraint(equalTo: textSectionTwo.bottomAnchor, constant: 12),
            textSectionThree.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            textSectionFour.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textSectionFour.topAnchor.constraint(equalTo: textSectionThree.bottomAnchor, constant: 12),
            textSectionFour.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            textSectionFive.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textSectionFive.topAnchor.constraint(equalTo: textSectionFour.bottomAnchor, constant: 12),
            textSectionFive.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            textSectionSix.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textSectionSix.topAnchor.constraint(equalTo: textSectionFive.bottomAnchor, constant: 12),
            textSectionSix.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            sourceTextSection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            sourceTextSection.topAnchor.constraint(equalTo: textSectionSix.bottomAnchor, constant: 16),
            sourceTextSection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            sourceTextSection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
