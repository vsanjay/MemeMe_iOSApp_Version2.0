//
//  showMemedImageViewController.swift
//  MemeMe
//
//  Created by VERDU SANJAY on 26/08/17.
//  Copyright © 2017 VERDU SANJAY. All rights reserved.
//

import UIKit

class showMemedImageViewController: UIViewController {
    
    @IBOutlet weak var memedImage: UIImageView!
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    //This has value of the index in memes array of Appdelegate
    var indexOfImageInArray : Int = 0
    var delegate : AppDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = UIApplication.shared.delegate as! AppDelegate
        memedImage.image = delegate.memes[indexOfImageInArray].memedImage
   }
}
