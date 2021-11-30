//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Ален Авако on 26.10.2021.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    static let id = "ProgressCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(titleLabel, progressLabel, progressView)
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
        label.text = "Всё получится!"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .systemGray
        return label
    }()
    
    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .systemGray
        return label
    }()
    
    lazy var progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.toAutoLayout()
        progress.transform = progress.transform.scaledBy(x: 1, y: 2)
        progress.trackTintColor = UIColor(named: "backgroundColor")
        progress.progressTintColor = UIColor(named: "appPurple")
        return progress
    }()
    
    public func configureCell(progress: Float) {
        let myProgress = progress * 100
        let progressStr = String(format: "%.0f", myProgress)
        progressLabel.text = "\(progressStr)%"
        
        self.progressView.setProgress(progress, animated: true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            progressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ])
    }
}
