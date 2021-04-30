//
//  SetDeadlinesCell.swift
//  MyDeadlines
//
//  Created by Oleh Derkachov on 30.04.2021.
//

import UIKit

class SetDeadlinesCell: UITableViewCell {
        
    @IBOutlet weak var lessonNumber: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewAppearance()
    }
}

// MARK: - Update

extension SetDeadlinesCell {
    func update(with lesson: LessonModel) {
        lessonNumber.text = lesson.number
    }
}


// MARK: - Private

private extension SetDeadlinesCell {

    func setupViewAppearance() {
        selectedBackgroundView = UIView()
    }
}
