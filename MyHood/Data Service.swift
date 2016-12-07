//
//  Data Service.swift
//  MyHood
//
//  Created by Patrick Robertson on 6/12/16.
//  Copyright © 2016 Patrick Robertson. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    
    static let instance = DataService()
    
    private var _loadedPosts = [Post]()
    
    var loadedPosts: [Post] {
        return _loadedPosts
    }
    
    func savePosts() {
        let postsData = NSKeyedArchiver.archivedData(withRootObject: _loadedPosts)
        
        UserDefaults.standard.set(postsData, forKey: "posts")
        UserDefaults.standard.synchronize()
    }
    
    func loadPosts() {
        if let postsData = UserDefaults.standard.object(forKey: "posts") as? Data {
            if let postsArray = NSKeyedUnarchiver.unarchiveObject(with: postsData) as? [Post] {
                _loadedPosts = postsArray
            }
        }
        
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "posts-Loaded"), object: nil))
        
    }
    
    func saveImageAndCreatePath(_ image: UIImage) -> String {
        let imgData = UIImagePNGRepresentation(image)
        
        let imgPath = "image\(Date.timeIntervalSinceReferenceDate).png"
        
        let fullPath = documentsPathForFileName(imgPath)
        
        try? imgData?.write(to: URL(fileURLWithPath: fullPath), options: [.atomic])
        
        return imgPath
    }
    
    func imageForPath(_ path: String) -> UIImage? {
        let fullPath = documentsPathForFileName(path)
        
        let image = UIImage(named: fullPath)
        
        return image
        
    }
    
    func addPost(post: Post) {
        _loadedPosts.append(post)
        savePosts()
        loadPosts()
    }
    
    func documentsPathForFileName(_ name: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let fullPath = paths[0] as NSString
        
        return fullPath.appendingPathComponent(name)
    }
}
