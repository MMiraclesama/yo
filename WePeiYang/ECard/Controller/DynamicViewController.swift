//
//  DynamicViewController.swift
//  WePeiYang
//
//  Created by 安宇 on 06/04/2019.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import UIKit

class DynamicViewController: UIViewController {
    
    let dynamicTableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .grouped)
    var DynamicInformation: DynamicInformation!
    let WPYLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        WPYLabel.frame = CGRect(x: UIScreen.main.bounds.width - 30, y: UIScreen.main.bounds.height - 20, width: 60, height: 20)
        WPYLabel.text = "微北洋 - 校园卡"
        WPYLabel.textColor = .white
        dynamicTableView.delegate = self
        dynamicTableView.dataSource = self
        view.addSubview(WPYLabel)
        view.addSubview(dynamicTableView)
        navigationItem.title = "校园卡"
        UINavigationBar.appearance().backgroundColor = UIColor.blue
        let leftButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(pop))
        leftButton.image = UIImage.resizedImage(image: UIImage(named:"返回-1")!, scaledToSize: CGSize(width: 20, height: 20))
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func loadData() {
        GetDynamicHelper.getDynamic(success: { DynamicInformation in
            self.DynamicInformation = DynamicInformation
            self.dynamicTableView.reloadData()
        }, failure: { _ in
            
        })
    }
    @objc func pop() {
        navigationController?.popViewController(animated: true)
    }

}

extension DynamicViewController: UITableViewDelegate {
    
}
extension DynamicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DynamicInformation == nil {
            return 0
        }
        return DynamicInformation.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return DynamicCell(byModel: DynamicInformation, withIndex: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UILabel()
        view.backgroundColor = .white
        view.text = "补办校园卡流程"
        view.textColor = .black
        view.textAlignment = .center
        return view
    }
    
    
}
