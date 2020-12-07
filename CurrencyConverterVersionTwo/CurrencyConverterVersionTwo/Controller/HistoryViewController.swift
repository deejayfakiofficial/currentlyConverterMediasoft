//
//  HistoryViewController.swift
//  CurrencyConverterVersionTwo
//
//  Created by Admin on 05.12.2020.
//

import UIKit

class HistoryViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HistoryDataSource.history.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let historyCell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        historyCell.textLabel?.text = HistoryDataSource.history[indexPath.row]
        return historyCell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            HistoryDataSource.history.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}


//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("tappet me")
//        HistoryDataSource.history.remove(at: indexPath.row)
//        tableView.deleteRows(at: [indexPath], with: .automatic)
//    }
//
//    //Действия по свайпу слева направо
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let swipeShare = UIContextualAction(style: .normal, title: "Расшарить") { (action, view, succes) in
//            print("share")
//        }
//        swipeShare.image = #imageLiteral(resourceName: "chat")
//        return UISwipeActionsConfiguration(actions: [swipeShare])
//    }
//
//    //Действия по свайпу справа налево
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let swipeDelete = UIContextualAction(style: .destructive, title: "Удалить") { (action, view, succes) in
//            print("delete")
//        }
//        swipeDelete.image = #imageLiteral(resourceName: "del")
//        return UISwipeActionsConfiguration(actions: [swipeDelete])
//    }


