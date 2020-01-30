import UIKit

open class ActionHandleButton : UIButton {
    
    open var action: (() -> Void)?
    
    @objc open func triggerActionHandleBlock() {
        self.action?()
    }
    
    open func actionHandle(_ control :UIControl.Event, ForAction action:@escaping () -> Void) {
        self.action = action
        self.addTarget(self,
                       action: #selector(ActionHandleButton.triggerActionHandleBlock),
                       for: control)
    }
}
