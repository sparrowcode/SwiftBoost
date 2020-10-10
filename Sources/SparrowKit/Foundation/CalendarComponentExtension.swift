//
//  File.swift
//  
//
//  Created by Alexandr Guzenko on 10.10.2020.
//
#if canImport(Foundation)
import Foundation

public extension Calendar.Component {
    func quantitiesOfTime(numberOfUnits: Int) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        formatter.zeroFormattingBehavior = .dropAll
        var dateComponents = DateComponents()
        dateComponents.setValue(numberOfUnits, for: self)
        return formatter.string(from: dateComponents)
    }
}
#endif
