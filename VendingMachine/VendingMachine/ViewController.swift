//
//  ViewController.swift
//  VendingMachine
//
//  Created by Colin on 5/14/20.
//  Copyright © 2020 Colin. All rights reserved.
//

/**
 This the main view controller for the app
 It functions to display the vending machine contents
 It only contains the logic for view layout
 */

import UIKit

protocol VendingMachineView: class {
    func updateFundsText(_ value: String)
    func displayError(_ value: String)
    func needsReload()
}

class ViewController: UIViewController, VendingMachineView {
    @IBOutlet weak var fundsButton: UIBarButtonItem?
    @IBOutlet weak var tableView: UITableView?
    private var presenter: VendingMachinePresenter<VendingMachine>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = VendingMachinePresenter(view: self)
    }
    
    func displayError(_ value: String) {
        let alert = UIAlertController(title: "Error", message: value, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okay)
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateFundsText(_ value: String) {
        fundsButton?.title = value
    }
    
    func needsReload() {
        self.tableView?.reloadData()
    }
    
    @IBAction func addMoreFunds() {
        let alert = UIAlertController(title: "Add Funds", message: "Enter the amout of funds to add", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.keyboardType = .numbersAndPunctuation
        }
        let add = UIAlertAction(title: "Add", style: .default) { _ in
            self.presenter.addFunds(alert.textFields?.first?.text ?? "")
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(add)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VendingItemCell") as! VendingItemCell
        cell.item = presenter.item(for: indexPath.row)
        cell.delegate = self
        return cell
    }
}

extension ViewController: PurchaseDelegate {
    func itemWasPurchased(_ item: Vendable?) {
        presenter.makePurchase(item)
    }
}
