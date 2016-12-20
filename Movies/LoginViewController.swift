//
//  LoginViewController.swift
//  Movies
//
//  Created by Joel Alves on 16/11/16.
//  Copyright © 2016 Joel Alves. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var inputTextUser: UITextField!
    @IBOutlet weak var inputTextPass: UITextField!
    let objectContext = CoreDataManager.sharedInstance.managedObjectContext;

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        //create user test
        if let user = CoreDataManager.newObject(entityName: "User") as? User {
            user.nome = "joel"
            user.numeroCliente = 10
            user.password = "joel"
        }
        if let user1 = CoreDataManager.newObject(entityName: "User") as? User {
            user1.nome = "joel1"
            user1.numeroCliente = 11
            user1.password = "joel"
        }
        if let user2 = CoreDataManager.newObject(entityName: "User") as? User {
            user2.nome = "joel2"
            user2.numeroCliente = 12
            user2.password = "joel"
        }
        CoreDataManager.sharedInstance.saveContext()
        
        let defaults = UserDefaults.standard
        if (defaults.string(forKey: "userName") != nil) {
            print("devia ir para o tab bar controller")
            //self.prepare(for: self, sender: <#T##Any?#>)
            self.performSegue(withIdentifier: "Login", sender: nil)
        }
        

        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews");
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare")
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let (valLogin,user) = auth()
        print(valLogin)
        
        if valLogin,
            let moviesController = segue.destination as? MoviesCollectionViewController{
            moviesController.user = user
        }
       
    }
 
    func displayAlertMessage(userMessage:String) {
        
        let alertMessage = UIAlertController(title: "Alert!", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        alertMessage.addAction(okAction)
        self.present(alertMessage, animated: true, completion: nil)
        //self.presentViewController(alertMessage, animated: true, completion: nil)
    }
    func auth() -> (Bool, User?){
        print("auth")
        let defaults = UserDefaults.standard
        if (defaults.string(forKey: "userName") != nil)
        {
            print("#vamosLogin")
            return (true,nil)
        }
        print("#naoVamos")
        if let textUser = self.inputTextUser.text,
            let textPass = self.inputTextPass.text{
            let usersFetch : NSFetchRequest<User> = User.fetchRequest()
            do {
                usersFetch.predicate = NSPredicate(format: "nome == %@ AND password == %@", textUser, textPass)
                
                //go get the results
                if let searchResults = try? objectContext.fetch(usersFetch) {
                    //I like to check the size of the returned results!
                    print ("num of results = \(searchResults)")
                    if !searchResults.isEmpty {
                        print("Exist")
                        
                        let userDefaults = Foundation.UserDefaults.standard
                        userDefaults.set( textUser, forKey: "userName")
                        userDefaults.set( textPass, forKey: "userPass")
                        
                        if let user = searchResults[0] as? User {
                            return (true,user)
                        }
                    }else {
                        displayAlertMessage(userMessage: "Not exist user")
                        return (false, nil)
                    }
                }
            } catch {
                print("Error with request: \(error)")
            }
        } else {
            displayAlertMessage(userMessage: "You haven't filled out all the fields.")
            return (false, nil)
        }
      return (false, nil)
    }

}
