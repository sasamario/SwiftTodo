//
//  ViewController.swift
//  SwiftTodo
//
//  Created by 笹間巧馬 on 2021/01/26.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource {
    
    var todoItems: Results<Todo>!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        
        //データベースのインスタンス化
        let realm = try! Realm()
        
        //objectのTodoを取り出し、todoItemsに代入している
        todoItems = realm.objects(Todo.self)
        
        //テーブルを更新する
        table.reloadData()
        
    }
    
    //画面が表示される前に（毎回）実行される処理
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
    }

    //セルの数を宣言
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Todoアイテムの数だけセルを生成するため
        return todoItems.count
    }
    
    //セル表示に関する処理
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let object = todoItems[indexPath.row]
        cell.textLabel?.text = object.title
        
        return cell
    }
    
}

