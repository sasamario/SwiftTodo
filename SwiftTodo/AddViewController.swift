//
//  AddViewController.swift
//  SwiftTodo
//
//  Created by 笹間巧馬 on 2021/01/27.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textBox.delegate = self
    }
    
    //TodoをRealmに追加
    @IBAction func addButton(_ sender: Any) {
        let realm = try! Realm()
        
        //Todoインスタンス化
        let todo = Todo()
        todo.title = textBox.text!
        
        //realmにTodoデータを追加
        try! realm.write {
            realm.add(todo)
        }
        
        //ひとつ前のViewControllerに戻る
        self.navigationController?.popViewController(animated: true)
    }
    
    //returnボタンタップ時にUITextFieldを閉じる処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textBox.resignFirstResponder()
        
        return true
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
