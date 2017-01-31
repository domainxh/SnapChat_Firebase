//
//  Post.swift
//  SnapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/30/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import Foundation
import Firebase

class Post {
    
    private var _comment: String!
    private var _senderUID: String!
    private var _imageURL: String!
    private var _videoURL: String!
    private var _postKey: String!
    private var _postRef: String!
    
    var comment: String { return _comment }
    var senderUID: String { return _senderUID }
    var imageURL: String { return _imageURL }
    var videoURL: String { return _videoURL }
    var postKey: String { return _postKey }
    var postRef: String { return _postRef }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let senderUID = postData["senderUID"] as? String { self._senderUID = senderUID }
        if let comment = postData["comment"] as? String { self._comment = comment }
        if let imageURL = postData["imageURL"] as? String { self._imageURL = imageURL }
        if let videoURL = postData["videoURL"] as? String { self._videoURL = videoURL }
        if let senderUID = postData["senderUID"] as? String { self._senderUID = senderUID }
        
    }
    
}
