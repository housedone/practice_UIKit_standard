//
//  CustomCollectionViewCell.swift
//  practice_UIKit_standard
//
//  Created by 김우성 on 6/26/25.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Identifier
    static let id = "CustomCollectionViewCell"
    
    // MARK: - UI Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("cell did init")
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } // UIViewController, UIView, 혹은 NSCoding을 따르는 클래스에서 Storyboard나 XIB에서 초기화될 가능성을 차단하기 위한 패턴임
    
    // MARK: - Setup Methods
    private func setupUI() {
        backgroundColor = .red.withAlphaComponent(0.3)
        addSubview(titleLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    // MARK: - Configuration
    func configure(title: String) {
        titleLabel.text = title
    }
}
