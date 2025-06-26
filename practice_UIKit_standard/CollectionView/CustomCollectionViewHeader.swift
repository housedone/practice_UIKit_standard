//
//  CustomCollectionViewHeader.swift
//  practice_UIKit_standard
//
//  Created by 김우성 on 6/26/25.
//

import UIKit

class CustomCollectionViewHeader: UICollectionReusableView { // ReusableView 라는 클래스를 상속받아야 한다.
    
    // MARK: - Identifier
    static let id = "CustomCollectionViewHeader"
    
    // MARK: - UI Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
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
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        backgroundColor = .green.withAlphaComponent(0.5)
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
