//
//  StandardTableViewController.swift
//  practice_250617_tableView
//
//  Created by 김우성 on 6/17/25.
//

import UIKit

class StandardTableViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var tableViewData: [TableViewItem] = [
        .init(title: "1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번1번", iconName: "questionmark.circle"),
        .init(title: "2번", iconName: "questionmark.circle.fill"),
        .init(title: "3번", iconName: "a.circle.fill"),
        .init(title: "4번", iconName: "a.square"),
        .init(title: "5번", iconName: "b.circle.fill"),
    ]
    
    var tableViewData2: [TableViewItem] = [
        .init(title: "1번", iconName: "questionmark.circle"),
        .init(title: "2번", iconName: "questionmark.circle.fill"),
        .init(title: "3번", iconName: "a.circle.fill"),
        .init(title: "4번", iconName: "a.square"),
        .init(title: "5번", iconName: "b.circle.fill"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTableView()
    }
    
    private let tableViewCellID = "DefaultTableViewCellId"
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = UITableView.automaticDimension // 행의 높이가 얼마나 될 건지에 대한 추정치를 제공하면 테이블 뷰 로딩 성능을 향상시킬 수 있다.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellID) // Reuse - 어떤 타입의 셀을 사용할거냐?
    }
}

// MARK: - TableViewDataSource

extension StandardTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // 한 섹션 안에서 열들을 몇개 나타낼거냐?
        switch section {
        case 0:
            tableViewData.count
        case 1:
            tableViewData2.count
        default:
            0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 재사용한 셀에 어떤 걸 넣을거냐?
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellID, for: indexPath)
        let cellData = tableViewData[indexPath.row]
        
        cell.textLabel?.text = indexPath.section == 0 ? cellData.title :  "\(indexPath.section * 5 + indexPath.row + 1)번"
        cell.textLabel?.numberOfLines = 0
        cell.imageView?.image = UIImage(systemName: cellData.iconName)
        
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        "테스트"
    //    }
    //
    //    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    //        "테스트 Footer"
    //    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.frame = .init(origin: .zero, size: .init(width: 300.0, height: 50.0))
        
        let label = UILabel()
        label.text = "\(section)번째 섹션"
        label.font = .systemFont(ofSize: 30.0, weight: .bold)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }
}

// MARK: - TableViewDelegate

extension StandardTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)번째 셀 터치")
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.section == 0 else { return nil }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] action, view, completion in
            
            self?.tableViewData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            print("\(indexPath.row)셀 삭제 스와이프 완료")
            
            completion(true)
        }
        
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(systemName: "trash")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
    
    
    // 성능 개선
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        <#code#>
//    }
}
