//
//  HabitsCollectionViewCell.swift
//  MyHabits
//
//  Created by Ален Авако on 18.10.2021.
//

import UIKit

class HabitsCollectionViewCell: UICollectionViewCell {
    
    static let id = "HabitsCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(titleLabel, timeLabel, markView, countLabel, markImage)
        contentView.backgroundColor = .white
        contentView.roundCornersWithRadius(12)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.systemGray2
        return label
    }()
    
    lazy var markView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.backgroundColor = .white
        view.layer.cornerRadius = 19
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var markImage: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.alpha = 0
        image.tintColor = .white
        image.image = UIImage(systemName: "checkmark")
        return image
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.systemGray2
        return label
    }()
    
    public func configureCell(color: UIColor, name: String, date: Date, trackDates: [Date]) {
        self.titleLabel.text = name
        self.titleLabel.textColor = color
        
        self.markView.layer.borderColor = color.cgColor
        
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.short
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "ru_RU")
        let strDate = formatter.string(from: date)
        
        self.timeLabel.text = "Каждый день в \(strDate)"
        
        countLabel.text = "Счётчик: \(trackDates.count)"
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            
            countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            countLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 30),
            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            markView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 46),
            markView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            markView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -46),
            markView.heightAnchor.constraint(equalToConstant: 38),
            markView.widthAnchor.constraint(equalToConstant: 38),
            
            markImage.centerXAnchor.constraint(equalTo: markView.centerXAnchor),
            markImage.centerYAnchor.constraint(equalTo: markView.centerYAnchor),
            markImage.widthAnchor.constraint(equalToConstant: 20),
            markImage.heightAnchor.constraint(equalTo: markImage.widthAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
