//
//  DBHelper.swift
//  fyp
//
//  Created by Matt on 04/7/2023.
//

import Foundation
import SQLite3

class DBHelper {
    var db : OpaquePointer?
    var path : String = "langDb.sqlite"
    init() {
        self.db = createDB()
        self.createTable()
        self.createAccTable()
    }
    
    //建立數據庫
    func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(path)
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK{
            print("There is error in creating DB")
            return nil
        }else {
            print("Database has been created with path \(path)")
            return db
        }
    }
   
    
    //創建本地數據庫表格
    func createTable() {
        let query = "CREATE TABLE IF NOT EXISTS mood(id INTEGER PRIMARY KEY AUTOINCREMENT,currentSlides TEXT,currentMultiplier TEXT,date TEXT);"
        
        var createTable : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &createTable, nil)  == SQLITE_OK{
            if sqlite3_step(createTable) == SQLITE_DONE{
                print("Table creation success")
            }else{
                print("Table creation fail")
            }
        }else{
            print("Prepartion fail")
        }
    }
    
    func createAccTable() {
        let query = "CREATE TABLE IF NOT EXISTS account(id INTEGER PRIMARY KEY AUTOINCREMENT,email TEXT,password TEXT,loginStatus TEXT);"
        
        var createTable : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &createTable, nil)  == SQLITE_OK{
            if sqlite3_step(createTable) == SQLITE_DONE{
                print("Account Table creation success")
            }else{
                print("Account Table creation fail")
            }
        }else{
            print("Prepartion fail")
        }
    }
    
    static var isOKRegister:Bool = false
    static var isOKLogin:Bool = false
    func insertAc(email: String,password:String){
        let query = "INSERT INTO account(email,password, loginStatus) VALUES (?,?,?)"
        
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            sqlite3_bind_text(statement, 1, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (password as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, ("Y" as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE{
//                updateLoginStatus(username: username)
                print("Ac Data inserts success")
                DBHelper.isOKRegister = true
            } else{
                print("Data is not inserted in table")
                DBHelper.isOKRegister = false
            }
            
        } else {
            print("Query is not as per requirement")
            DBHelper.isOKRegister = false
        }
    }
    
    
    func updateStatus(email:String) {
        let query = "UPDATE account SET loginStatus = 'N' WHERE email = '\(email)';"
        
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            if sqlite3_step(statement) == SQLITE_DONE{
                print("Ac Status Y updated success")
            } else{
                print("Data is not updated in table")
            }
        }
    }
    
    static var currentLoginEmail:String = ""
    static var currentPassword:String = ""
    static var currentLoginStatus:String = ""
    
    func readLoginedAc() -> (String,String,String) {
        var email = ""
        var password = ""
        var loginstatus = ""
        let query = "SELECT email,password,loginStatus FROM account LIMIT 1;"
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let resultName = sqlite3_column_text(statement, 0)
                let resultPass = sqlite3_column_text(statement, 1)
                let resultStatus = sqlite3_column_text(statement, 2)
                email = String(cString: resultName!)
                password = String(cString: resultPass!)
                loginstatus = String(cString: resultStatus!)
                DBHelper.currentLoginEmail = email
                DBHelper.currentPassword = password
                DBHelper.currentLoginStatus = loginstatus
                print("Ac Logined")
            }
            
        }
        return (email,password,loginstatus)
    }
    
    
    
    
    func insertMood(currentSlides: String,currentMultiplier:String,date:String){
        let query = "INSERT INTO mood(currentSlides,currentMultiplier,date) VALUES (?,?,?)"
        
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            sqlite3_bind_text(statement, 1, (currentSlides as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (currentMultiplier as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (date as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE{
                print("Ac Data inserts success")
            } else{
                print("Data is not inserted in table")
            }
            
        } else {
            print("Query is not as per requirement")
        }
    }
    
    func readMood() -> [Mood] {
        var moodList = [Mood]()
        let query = "SELECT currentSlides,currentMultiplier FROM mood;"
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
         
            while sqlite3_step(statement) == SQLITE_ROW {
                let currentSlides = String(cString: sqlite3_column_text(statement, 0))
                let currentMultiplier = String(cString: sqlite3_column_text(statement, 1))
                let mood = Mood(currentSlides: currentSlides, currentMultiplier: currentMultiplier)
                moodList.append(mood)
            }
        }
        print("hello\(moodList)")
        
        return moodList
    }
    
    
}

struct Mood {
    let currentSlides: String
    let currentMultiplier: String
}
