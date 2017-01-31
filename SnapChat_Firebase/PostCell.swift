//
//  PostCell.swift
//  SnapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/27/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    var post: Post!
    
    @IBOutlet weak var senderUserName: UILabel!
    @IBOutlet weak var senderUserImage: UIImageView!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var heartIcon: UIImageView!
    @IBOutlet weak var webView: UIWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(post: Post) {

        comment.text = post.comment
        
        if post.videoURL.characters.count >= 0 {
            webView.isHidden = false
            let url = "<iframe width=\"100%\" height=\"100%\" src=\"\(post.videoURL)\" frameborder=\"0\" allowfullscreen></iframe>"
            webView.scalesPageToFit = true
            webView.allowsInlineMediaPlayback = true
            webView.scrollView.isScrollEnabled = false
            webView.loadHTMLString(url, baseURL: nil)
        } else {
            webView.isHidden = true
        }
    
        // Extract pullRequest
        DataService.instance.usersRef.child(post.senderUID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let user = snapshot.value as? Dictionary<String, AnyObject> {
                
                if let username = user["username"] as? String {
                    self.senderUserName.text = username
                }
                
                if let profilePictureURL = user["profilePictureURL"] as? String {
                    DispatchQueue.global().async {
                        if let imageData = try? Data(contentsOf: URL(string: profilePictureURL)!) {
                            DispatchQueue.main.async {
                                self.senderUserImage.image = UIImage(data: imageData)
                            }
                        }
                    }
                }
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
  
    }
    
    
    
    
}
