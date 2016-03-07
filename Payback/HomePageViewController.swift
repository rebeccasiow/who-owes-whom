//
//  HomePageViewController.swift
//  Payback
//
//  Created by Kelly Stathis on 2/24/16.
//  Copyright © 2016 Kelly Stathis. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController,UITableViewDataSource, UITableViewDelegate  {
    
    var valueToPass: User
    
    required init(coder aDecoder: NSCoder) {
        self.valueToPass = User(id:-1, name:"dummy")
        super.init(coder: aDecoder)!
    }
    
    @IBOutlet weak var tableView: UITableView!
    static var userList:[User] = []
    static var userOfApp:User = User(id:0, name: "Me")
    let user3 = User(id: 3, name: "Tess")
    let user1 = User(id: 1, name: "Shefali")
    let user2 = User(id: 2, name: "Kelly")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self;
        tableView.delegate = self;
        
        let expense1 = Expense(id: 1, name: "Rent", buyer: user3, totalAmount: 200.00, owers: [user2])
        let expense2 = Expense(id: 2, name: "Food", buyer: user3, totalAmount: 15.00, owers: [user1])
        user3.addAsBuyer(expense1)
        user2.addAsOwer(expense1)
        user3.addAsBuyer(expense2)
        user1.addAsOwer(expense2)
        HomePageViewController.userList = [user1,user2]
        print(user1.getAmountOwedTo(user3))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return HomePageViewController.userList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       /* let cell = tableView.dequeueReusableCellWithIdentifier("expenseCell", forIndexPath: indexPath)
        //cell.textLabel!.text = "\(indexPath.row)"
        return cell;
        */
        let cell = tableView.dequeueReusableCellWithIdentifier("expenseCell", forIndexPath: indexPath) as! expenseCell
        print("here")
        print(indexPath.row)
        let temp = HomePageViewController.userList[indexPath.row] as! User
        print(temp.name)
        cell.nameLabel?.text = temp.name
        cell.amountLabel?.text = "$" + String(temp.getAmountOwedTo(user3))
        
        return cell
        
    }
    

    
    /*func cellForRowAtIndexPath(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell? {
       /* let cell = tableView.dequeueReusableCellWithIdentifier("expenseCell", forIndexPath: indexPath)
        cell.textLabel!.text = "\(indexPath.row)"
        print("indexing cells")
        return cell;
        */
        let cell = tableView.dequeueReusableCellWithIdentifier("expenseCell", forIndexPath: indexPath) as! expenseCell
        print("here")
        cell.nameLabel?.text = userList[indexPath.row].name
        print(userList[indexPath.row].name)
        
        return cell
  
    }*/
    /*
    func numberOfRowsInSection(tableView: UITableView!, section: Int) -> Int {
        return 1;
    }
*/

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        print("You selected cell #\(indexPath.row)!")
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        
        valueToPass = HomePageViewController.userList[indexPath.row]
        performSegueWithIdentifier("itemizedExpenseView", sender: self)
        
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if (segue.identifier == "itemizedExpenseView") {
            
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destinationViewController as! ViewExpensesViewController
            // your new view controller should have property that will store passed value
            
            viewController.passedUser = valueToPass
        }
    }
    

}
