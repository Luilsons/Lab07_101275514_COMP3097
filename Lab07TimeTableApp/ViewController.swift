//
//  ViewController.swift
//  Lab07TimeTableApp
//
//  Created by Luilson Marcos Sousa dos Reis on 2025-02-19.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    // UI Elements
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter a number"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        return textField
    }()
   
    let calculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Calculate", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)
        return button
    }()
   
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.systemGray6
        return tableView
    }()
   
    var timesTable: [String] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Set background color
        view.backgroundColor = .white
       
        // Set TableView delegate & data source
        tableView.delegate = self
        tableView.dataSource = self
       
        // Register a default UITableViewCell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
       
        // Add UI Elements to View
        view.addSubview(inputTextField)
        view.addSubview(calculateButton)
        view.addSubview(tableView)
       
        // Apply Auto Layout Constraints
        setupConstraints()
    }
   
    // Setup Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            inputTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            inputTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputTextField.trailingAnchor.constraint(equalTo: calculateButton.leadingAnchor, constant: -10),
            inputTextField.heightAnchor.constraint(equalToConstant: 40),
           
            calculateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            calculateButton.centerYAnchor.constraint(equalTo: inputTextField.centerYAnchor),
            calculateButton.widthAnchor.constraint(equalToConstant: 100),
            calculateButton.heightAnchor.constraint(equalToConstant: 40),
           
            tableView.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
   
    //Button Action
    @objc func calculateButtonTapped() {
        guard let inputText = inputTextField.text, let number = Int(inputText) else {
            print("Invalid input")
            return
        }

        view.endEditing(true)
       
        timesTable = (1...10).map { "\($0) x \(number) = \($0 * number)" }
        tableView.reloadData()
    }
   
    // UITableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timesTable.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = timesTable[indexPath.row]
        cell.backgroundColor = UIColor.systemGray6
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return cell
    }
}
