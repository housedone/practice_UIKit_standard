//
//  CarouselCollectionViewController.swift
//  practice_UIKit_standard
//
//  Created by 김우성 on 6/26/25.
//

import UIKit

// MARK: - ViewController

class CarouselCollectionViewController: UIViewController {
    
    // MARK: - Properties
    lazy var dataSource: [CarouselCollectionViewItem] = []
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 20.0
        flowLayout.sectionInset = UIEdgeInsets(
            top: 0,
            left: (UIScreen.main.bounds.width - 300.0) / 2.0,
            bottom: 0,
            right: (UIScreen.main.bounds.width - 300.0) / 2.0
        )
        flowLayout.itemSize = CGSize(width: 300.0, height: 300.0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .gray.withAlphaComponent(0.2)
        collectionView.decelerationRate = .fast
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: CarouselCollectionViewCell.id)
        
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        view.backgroundColor = .systemBackground
        
        setupData()
        setupLayout()
    }
    
    // MARK: - Setup Methods
    
    private func setupData() {
        for i in 0..<100 {
            dataSource.append(CarouselCollectionViewItem(title: "Item \(i)", subtitle: "Subtitle \(i)"))
        }
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 300.0)
        ])
    }
    
}
// MARK: - UICollectionViewDataSource
extension CarouselCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1. Reuse Pool에서 재사용 가능한 Cell 요청
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.id, for: indexPath) as? CarouselCollectionViewCell
        
        // 2. Cell에 데이터 설정
        cell?.configure(item: dataSource[indexPath.item])
        
        return cell ?? UICollectionViewCell()
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CarouselCollectionViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let scrollOffset = targetContentOffset.pointee.x
        let cellWidthIncludingSpacing = 300.0 + 20.0 // itemSize + minimumLineSpacing
        let index = round(scrollOffset / cellWidthIncludingSpacing)
        targetContentOffset.pointee.x = index * cellWidthIncludingSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataSource[indexPath.item].isSelected.toggle()
        
        collectionView.reloadItems(at: [indexPath])
    }
}
