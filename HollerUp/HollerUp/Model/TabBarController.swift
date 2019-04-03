

import UIKit
import EZSwiftExtensions

open
class TabBarController: UITabBarController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.04293424636, green: 0.7124077678, blue: 0.8466896415, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        UITabBar.appearance().barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        UITabBar.appearance().isTranslucent = false
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont.appFont(.Medium, size: UIDevice.isPhone() ? 10:15)], for: .normal)

        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        self.tabBar.layer.shadowRadius = 2
        self.tabBar.layer.shadowColor = UIColor.blackColor.cgColor
        self.tabBar.layer.shadowOpacity = 0.3
        delegate = self
    }
    
    /// Override to ensure that upon selection, the center button is updated
    override open var selectedViewController: UIViewController? {
        didSet {
            updateCenterButton()
        }
    }
    
    /// Override to ensure that upon selection, the center button is updated.
    override open var selectedIndex: Int {
        didSet {
            updateCenterButton()
        }
    }
    
    
    /// Reference to the center button. Marked optional, but generally should exist (else what's the point?).
    fileprivate weak var centerButton: UIButton?
    
    /// Reference to the "selected" version of the button. Marked optional, but generally should exist (else what's the point?).
    fileprivate var buttonImageSelected: UIImage?
    
    /// Reference to the "unselected" version of the button. Marked optional, but generally should exist (else what's the point?).
    fileprivate var buttonImageUnselected: UIImage?
    
    /// Reference to the action target. Optional, as the button doesn't have to have a target-action behavior.
    fileprivate var buttonTarget: AnyObject?
    
    /// Reference to the action selector. Optional, as the button doesn't haev to have a target-action behavior.
    fileprivate var buttonAction: Selector?
    
    /// Does tapping/selecting the center button allow the tab controller to actually switch to that tab or not? Generally if set to false, the target-action should be set so as to have some response to the button tap.
    fileprivate var allowSwitch: Bool = true
    

    public func addCenterButton(unselectedImage: UIImage, selectedImage: UIImage, target: AnyObject? = nil, action: Selector? = nil, allowSwitch: Bool = true) {
        assert((target == nil && action == nil) || (target != nil && action != nil))
        assert(delegate === self, "TabBarController must be its own delegate")
        delegate = self
        
        buttonImageUnselected = unselectedImage
        buttonImageSelected = selectedImage
        buttonTarget = target
        buttonAction = action
        self.allowSwitch = allowSwitch
        
        if let centerButton = centerButton {
            centerButton.removeFromSuperview()
            self.centerButton = nil
        }
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(button)
        
        view.addConstraint(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0));
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[button]-\(self.tabBar.h - (unselectedImage.size.height/2))-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["button": button]));
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[button(==\(unselectedImage.size.width))]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["button": button]));
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[button(==\(unselectedImage.size.height))]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["button": button]));
        
        button.addTarget(self, action: #selector(centerButtonAction(_:)), for: .touchUpInside)
        centerButton = button
        updateCenterButton()
    }


    @IBAction dynamic fileprivate func centerButtonAction(_ sender: AnyObject) {
        if allowSwitch {
            selectedViewController = centerViewController
        }
        
        if let buttonTarget = buttonTarget, let buttonAction = buttonAction {
            let _ = buttonTarget.perform(buttonAction, with: sender)
        }
    }
    
    
    /// Obtains the center UIViewController, if any.
    open var centerViewController: UIViewController? {
        if let viewControllers = viewControllers {
            let centerVC = viewControllers[viewControllers.count / 2]
            return centerVC
        }
        return nil
    }
    

    /**
    Ensures the center button cosmetics are correct, regarding the button images.
    */
    fileprivate func updateCenterButton() {
        var buttonImage = buttonImageUnselected
        if selectedViewController === centerViewController {
            buttonImage = buttonImageSelected
        }
        
        if let centerButton = centerButton {
            centerButton.setBackgroundImage(buttonImage, for: UIControlState())
        }
    }

}

private typealias TabBarControllerDelegate = TabBarController
extension TabBarControllerDelegate: UITabBarControllerDelegate {

    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController === self {
            if viewController === centerViewController {
                if let centerButton = centerButton {
                    centerButtonAction(centerButton)
                }
            }
            else {
                updateCenterButton()
            }
        }
    }
    
    
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        var should = true
        if centerViewController === viewController && !allowSwitch {
            should = false
        }
        return should
    }
}

