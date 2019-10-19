//
//  PostCollectionViewCell.swift
//  Fakestagram-Xcode10
//
//  Created by Ruben Alejandro Leon Del Villar on 18/10/19.
//  Copyright © 2019 unam. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {

    var post: Post? {
        didSet {
            updateContent()
        }
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeCounter: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeBttn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!

    @IBAction func onTapLike(_ sender: Any?){
        print("Likes")
    }
    @IBAction func onTapCreateComment(_ sender: Any?){
        print("to comment")
    }
    @IBAction func onTapShowComment(_ sender: Any?){
        print("to show comment")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateContent(){
        guard let post = self.post else { return}
        //self.authorView.author = post.
        self.titleLabel.text = post.title
        post.load { [unowned self] img in
            self.imageView.image = img
        }

    }
}
