//
//  StoryboardMakeable.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/15/21.
//

import UIKit

public protocol StoryboardMakeable: class {
    associatedtype StoryboardMakeableType
    static var storyboardName: String { get }
    static func make() -> StoryboardMakeableType
}

public extension StoryboardMakeable where Self: UIViewController {
    
    /// make view StoryboardMakeableType from
    static func make() -> StoryboardMakeableType {
        let viewControllerId = NSStringFromClass(self).components(separatedBy: ".").last ?? ""
        
        return make(with: viewControllerId)
    }
    
    static func make(with viewControllerId: String) -> StoryboardMakeableType {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: self))
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerId) as? StoryboardMakeableType else {
            fatalError("Did not find \(viewControllerId) in \(storyboardName)!")
        }
        
        return viewController
    }
}

