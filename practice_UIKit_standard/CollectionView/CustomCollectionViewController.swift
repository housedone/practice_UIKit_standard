//
//  CustomCollectionViewController.swift
//  practice_UIKit_standard
//
//  Created by 김우성 on 6/26/25.
//

import UIKit

// MARK: - Constants
// 팁: 사이즈 숫자를 직접 넣을수도 있지만, 따로 빼두는 것이 코드를 유지보수하는 데에 좋다.
private enum Const {
    static let cellWidth: CGFloat = 100.0
    static let cellHeight: CGFloat = 100.0
    
    static let lineSpacing: CGFloat = 10.0
    static let interItemSpacing: CGFloat = 10.0
    
    static let sectionInsetLeft: CGFloat = 20.0
    static let sectionInsetRight: CGFloat = 20.0
}

// MARK: - ViewController

class CustomCollectionViewController: UIViewController {
    
    // MARK: - Properties
    private var dataSource: [MyCellData] = []

    private lazy var collectionView: UICollectionView = {
        // layout을 반드시 선언해주어야 한다! 그리고 어떤 레이아웃을 쓸건지 넣어주어야 한다.
        let layout = UICollectionViewFlowLayout() // 제공된 Flow 레이아웃을 넣어준다. 만약 디자이너가 이런걸로 구현 불가능한 것을 원한다? 그럼 UICollectionViewLayout을 서브클래싱해서 각각의 셀들이 나타날 때 어떻게 배치할것인지를 커스텀해야 하겠다..
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: Const.cellWidth, height: Const.cellHeight)
        // layout.estimatedItemSize // 예상치를 줌으로써 로딩 성능을 향상시키는 방법이 제공된다.
        layout.minimumLineSpacing = Const.lineSpacing // 버티컬 스크롤일때는 행간 간격을 의미한다.
        layout.minimumInteritemSpacing = Const.interItemSpacing // 버티컬 스크롤일때는 좌우 셀간의 간격을 의미한다.
        layout.sectionInset = .init( // 팁: control + m 누르면 바로 아래로 정렬됨!
            top: 0.0,
            left: Const.sectionInsetLeft,
            bottom: 0.0,
            right: Const.sectionInsetRight
        )// 컬렉션 뷰가 갖고 있는 사이즈가 있을 때, 셀들이 들어가야 하는 크기에 대한 inset 값을 말한다.
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .blue.withAlphaComponent(0.2)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 컬렉션 뷰는 테이블 뷰와 달리 커스텀 셀을 직접 구현해주어야 한다!
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.id)
        
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
            dataSource.append(.init(title: "title \(i)"))
        }
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension CustomCollectionViewController: UICollectionViewDataSource {
    // 이 섹션의 아이템 개수는 몇 개냐?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    // indexPath에 해당하는 위치에 표시할 셀이 뭐냐?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.id, for: indexPath) as? CustomCollectionViewCell
        
        cell?.configure(title: dataSource[indexPath.row].title)
        
        return cell ?? .init() // cell이 nil일 경우 기본 UICollectionViewCell()로 대체. 이건 약간 임시 땜빵 스타일이고, cell 정의할 때에 guard 하고 else { fatalError() 처리하는 게 실전형.
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
// 사용자 인터렉션 뿐 아니라 UI 레이아웃을 동적으로 사용할때도 델리게이트 내부에서 아이템 사이즈 등 값을 전달할 수 있는데,
// FlowLayout을 사용할 때는 반드시 그냥 CollectionViewDelegate가 아닌 CollectionViewDelegateFlowLayout을 채택해야 한다.
extension CustomCollectionViewController: UICollectionViewDelegateFlowLayout {
    // 필요한 경우 델리게이트 메서드 추가
}

