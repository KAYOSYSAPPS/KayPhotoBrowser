//
//  KayCacheable.swift
//  KayPhotoBrowser
//
//

import UIKit.UIImage

public protocol KayCacheable {}
public protocol KayImageCacheable: KayCacheable {
    func imageForKey(_ key: String) -> UIImage?
    func setImage(_ image: UIImage, forKey key: String)
    func removeImageForKey(_ key: String)
}

public protocol KayRequestResponseCacheable: KayCacheable {
    func cachedResponseForRequest(_ request: URLRequest) -> CachedURLResponse?
    func storeCachedResponse(_ cachedResponse: CachedURLResponse, forRequest request: URLRequest)
}
