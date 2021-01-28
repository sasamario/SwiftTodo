//
//  ViewController.swift
//  SwiftTodo
//
//  Created by 笹間巧馬 on 2021/01/26.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var todoItems: Results<Todo>!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
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
    
    //セルの削除ボタンが押された時の処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //セルに削除編集コントロールがあるとき
        if editingStyle == .delete {
            //該当箇所のセルを削除する
            deleteTodo(at: indexPath.row)
            table.reloadData()
        }
    }
    
    //指定のTodoデータを削除する処理
    func deleteTodo(at index: Int) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(todoItems[index])
        }
    }
    
    //セル選択時に実行される処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //セルの選択の解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        //別画面に遷移（その際、senderにセルの番号を指定）
        performSegue(withIdentifier: "editViewController", sender: indexPath.row)
        
    }
    
    //segueが動作する時に処理されるメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //編集ページに遷移した時
        if segue.identifier == "editViewController" {
            
            let editVC = segue.destination as? EditViewController
            
            //遷移先にタップしたセルの番号を渡す
            editVC?.index = sender as! Int
            
        }
    }
}

