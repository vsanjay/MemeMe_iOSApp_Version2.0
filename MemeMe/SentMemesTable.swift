//
//  SentMemesTable.swift
//  MemeMe
//
//  Created by VERDU SANJAY on 26/08/17.
//  Copyright © 2017 VERDU SANJAY. All rights reserved.
//

import UIKit

class SentMemesTable: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var delegate : AppDelegate!
    
    @IBOutlet weak var sentMemesTable: UITableView!
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegateAndDataSourceForTable()
        configureNavigationBar()
    }
    
    //Add Custom bar buttons and give names
    func configureNavigationBar(){
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(SentMemesTable.presentMemeEditor))
        navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "Sent Memes", style: .done, target: self, action: nil)
    }
    
    //Set Delegate and DataSource for Table
    func setDelegateAndDataSourceForTable(){
        
        sentMemesTable.dataSource = self
        sentMemesTable.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDelegate()
        sentMemesTable.reloadData()
    }
    
    //Get the delegate where we stored all our images
    func getDelegate(){
        
        delegate = UIApplication.shared.delegate as! AppDelegate!
    }
    
    //Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Number of Rows in our table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return delegate.memes.count
    }
    
    //Giving information for each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = sentMemesTable.dequeueReusableCell(withIdentifier: "tableCell") as! customTableCell
        let index = indexPath.row
        cell.memeImage.image = delegate.memes[index].originalImage
        cell.topLabel.text = delegate.memes[index].topText
        cell.bottomLabel.text = delegate.memes[index].bottomText
        cell.memeDescription.text = delegate.memes[index].topText + " " + delegate.memes[index].bottomText
        return cell
    }
    
    //Function to present MemeEditor
    func presentMemeEditor(){
        
        let memeEditor = storyboard?.instantiateViewController(withIdentifier: "memeEditor") as! MemeEditorViewController
        present(memeEditor, animated: true, completion: nil)
    }
    
    //Master Detail Implementation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "showMemedImage") as! showMemedImageViewController
        vc.indexOfImageInArray = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
