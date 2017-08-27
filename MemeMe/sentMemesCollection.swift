//
//  sentMemesCollection.swift
//  MemeMe
//
//  Created by VERDU SANJAY on 26/08/17.
//  Copyright © 2017 VERDU SANJAY. All rights reserved.
//

import UIKit

class sentMemesCollection: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var sentMemesCollectionView: UICollectionView!
    @IBOutlet weak var cellFlowLayout: UICollectionViewFlowLayout!
    
    var delegate : AppDelegate!
    
    //Hide Status Bar
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureFlowLayout()
        configureNavigationBar()
        setDelegateAndDataSourceForTable()
    }
    
    func configureFlowLayout(){
        
        let space = 3.0
        
        let width = (self.view.frame.size.width - (CGFloat)(space * 2.0))/3.0
        let height = (self.view.frame.size.width - (CGFloat)(space * 2.0))/3.0
        cellFlowLayout.minimumInteritemSpacing = 3.0
        cellFlowLayout.minimumLineSpacing = 3.0
        cellFlowLayout.itemSize = CGSize(width: width, height: width)
    }
    
    //Set Delegate and DataSource for Table
    func setDelegateAndDataSourceForTable(){
        
        sentMemesCollectionView.dataSource = self
        sentMemesCollectionView.delegate = self
    }

    //Configure Navigation Bar
    func configureNavigationBar(){
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(sentMemesCollection.presentMemeEditor))
        navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "Sent Memes", style: .done, target: self, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getDelegate()
        sentMemesCollectionView.reloadData()
    }

    //Number of sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Number of Items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return delegate.memes.count
    }
    
    //Info for each cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = sentMemesCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! customCollectionCell
        cell.topLabel.text = delegate.memes[indexPath.row].topText
        cell.bottomLabel.text = delegate.memes[indexPath.row].bottomText
        cell.memedImage.image = delegate.memes[indexPath.row].originalImage

        return cell
    }
    
    //Initialise Delegate
    func getDelegate() {
        
        delegate = UIApplication.shared.delegate as! AppDelegate
    }
    
    //Master Detail
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "showMemedImage") as! showMemedImageViewController
        
        vc.indexOfImageInArray = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //Present MemeEditor
    func presentMemeEditor(){
        
        let memeEditor = storyboard?.instantiateViewController(withIdentifier: "memeEditor") as! MemeEditorViewController
        
        present(memeEditor, animated: true, completion: nil)
    }


}
