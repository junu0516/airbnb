import UIKit

@propertyWrapper
struct CodableLayoutView<T: UIView> {
    private var view: T
    var wrappedValue: T {
        get {
            self.view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }
        set { view = newValue }
    }
    
    init(view: T) {
        self.view = view
    }
}
