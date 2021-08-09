//
//  ViewController.swift
//  UIKitDemo
//
//  Created by Jędrzej Chołuj on 05/05/2021.
//

import UIKit

class ViewController: UIViewController {
    
    private var switchView = SwitchBackgroundView()
    private var fetchButton = UIButton()
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupLayout()
        setupProperties()
    }
    
    private func setupHierarchy() {
        view.addSubview(switchView)
        view.addSubview(fetchButton)
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        switchView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(46)
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        
        fetchButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-32)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-32)
            $0.height.equalTo(60)
        }
        
        tableView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-32)
            $0.top.equalTo(switchView.snp.bottom).offset(16)
            $0.bottom.equalTo(fetchButton.snp.top).offset(-16)
        }
    }
    
    private func setupProperties() {
        view.backgroundColor = .white
        
        switchView.customSwitch.onTintColor = .secondaryColor
        switchView.customSwitch.thumbOnTintColor = .secondaryColor
        
        fetchButton.layer.cornerRadius = 15
        fetchButton.backgroundColor = .mainColor
        fetchButton.setTitle("FETCH CHARACTERS", for: .normal)
        
        tableView.tableFooterView = UIView()
        tableView.register(DemoTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    // TODO: Bind all actions
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
