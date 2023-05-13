import Foundation

extension Mirror {
    /**
     This static method iterates over properties of a given object, applying a closure to each property that matches the specified type.

     - Parameters:
       - target: The object whose properties will be reflected.
       - type: The type of properties to which the closure should be applied. By default, it's `T.self`.
       - recursively: If set to `true`, the method will reflect properties of the target's properties recursively. Default value is `false`.
       - closure: The closure to apply to each property of the specified type. The closure takes a parameter of type `T`.

     - Note: This function uses **Swift's Mirror API** for reflection. Not all properties may be accessible for types that do not fully support reflection.
     
     Exmaple usage:
     ```
     class MyClass {
        var myIntProperty: Int = 0
        var myStringProperty: String = "Hello"
     }

     let myInstance = MyClass()
     Mirror.reflectProperties(of: myInstance, matchingType: Int.self) { property in
        print("The value of myIntProperty is (property)")
     }
     ```
     */
    public static func reflectProperties<T>(
        of target: Any,
        matchingType type: T.Type = T.self,
        recursively: Bool = false,
        using closure: (T) -> Void
    ) {
        let mirror = Mirror(reflecting: target)
        
        for child in mirror.children {
            (child.value as? T).map(closure)
            guard recursively else { continue }
            
            Mirror.reflectProperties(
                of: child.value,
                recursively: true,
                using: closure
            )
        }
    }
}
