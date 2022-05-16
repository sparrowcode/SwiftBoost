import Foundation

public extension Calendar.Component {
    /**
     SwiftBoost: Format components.
     
     Take a look at this example:
     ```
     Calendar.Component.month.formatted(numberOfUnits: 2, unitsStyle: .full) // 2 months
     Calendar.Component.day.formatted(numberOfUnits: 15, unitsStyle: .short) // 15 days
     Calendar.Component.year.formatted(numberOfUnits: 1, unitsStyle: .abbreviated) // 1y
     ```
     
     - parameter numberOfUnits: Count of units of component.
     - parameter unitsStyle: Style of formatting of units.
     */
    func formatted(numberOfUnits: Int, unitsStyle: DateComponentsFormatter.UnitsStyle = .full) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = unitsStyle
        formatter.zeroFormattingBehavior = .dropAll
        var dateComponents = DateComponents()
        dateComponents.setValue(numberOfUnits, for: self)
        return formatter.string(from: dateComponents)
    }
}
