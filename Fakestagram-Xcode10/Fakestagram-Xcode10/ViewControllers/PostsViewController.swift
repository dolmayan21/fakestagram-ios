//
//  PostsViewController.swift
//  Fakestagram-Xcode10
//
//  Created by Ruben Alejandro Leon Del Villar on 18/10/19.
//  Copyright © 2019 unam. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var posts: [Post]? {
        didSet {
            self.postsCollection.reloadData()
        }
    }
    let client = RestClient<[Post]>(client: Client.fakestagram, basePath: "/api/v1/posts")
    let refreshControl = UIRefreshControl()

    @IBOutlet weak var postsCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        postsCollection.delegate = self
        postsCollection.dataSource = self
        let nib = UINib(nibName: String(describing: PostCollectionViewCell.self), bundle: nil)
        postsCollection.register(nib, forCellWithReuseIdentifier: PostCollectionViewCell.identifier)

        postsCollection.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(self.reloadData), for: .valueChanged)

        client.show { [unowned self] data in
            self.posts = data
        }
        // Do any additional setup after loading the view.
    }

    @objc func reloadData(){
        client.show { [unowned self] data in
            self.posts = data
            //sleep(1)
            self.refreshControl.endRefreshing()
        }
    }

    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

    // MARK: - Collection View Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as! PostCollectionViewCell
        guard let posts = self.posts else { return cell }
        cell.post = posts[indexPath.row]
        return cell
    }

    // MARK: - Flow Layout Delegates
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 650)
    }
}
