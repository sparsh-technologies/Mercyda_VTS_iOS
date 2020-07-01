

import UIKit

protocol StoryboardIdentifiable {
  static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
  static var storyboardIdentifier: String {
    return String(describing: self)
  }
}

extension UIViewController: StoryboardIdentifiable { }

extension UIStoryboard {
   //  If there are multiple storyboards in the project, each one must be named here:
  enum Storyboard: String {
    
    case Login = "Login"
    
  }
  
  convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
    self.init(name: storyboard.rawValue, bundle: bundle)
  }
  
  class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
    return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
  }
  
  func instantiateViewController<T: UIViewController>() -> T {
    guard let viewController = instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
        //instantiateViewController().modalPresentationStyle = .fullScreen
      fatalError("Could not find view controller with name \(T.storyboardIdentifier)")
    }
    
    return viewController
  }
}

/// Use in view controllers:
///
/// 1) Have view controller conform to SegueHandlerType
/// 2) Add `enum SegueIdentifier: String { }` to conformance
/// 3) Manual segues are trigged by `performSegue(with:sender:)`
/// 4) `prepare(for:sender:)` does a `switch segueIdentifier(for: segue)` to select the appropriate segue case

protocol SegueHandlerType {
  associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
  func performSegue(withIdentifier identifier: SegueIdentifier, sender: Any?) {
    performSegue(withIdentifier: identifier.rawValue, sender: sender)
  }
  
  func segueIdentifier(for segue: UIStoryboardSegue) -> SegueIdentifier {
    guard let identifier = segue.identifier,
      let segueIdentifier = SegueIdentifier(rawValue: identifier)
      else {
        fatalError("Invalid segue identifier: \(String(describing: segue.identifier))")
    }
    
    return segueIdentifier
  }
    
}



