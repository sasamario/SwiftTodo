//
//  EditViewController.swift
//  SwiftTodo
//
//  Created by 笹間巧馬 on 2021/01/28.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController {
    
    //遷移元からタップしたセルの番号を受け取るための変数
    var index = Int()

    var todoItems: Results<Todo>!
    
    @IBOutlet weak var todoText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //データベースインスタンス化
        let realm = try! Realm()
        
        //TodoデータをtodoItemsに入れる
        todoItems = realm.objects(Todo.self)

        //遷移元のセル番号のTodoをラベルに反映
        todoText.text = todoItems[index].title
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
