//
//  HabitDatesTableViewCell.swift
//  MyHabits
//
//  Created by Ален Авако on 24.10.2021.
//

import UIKit

class HabitDatesTableViewCell: UITableViewCell {
    
    static let id = "HabitDatesTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        contentView.addSubviews(trackDates)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var trackDates: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
