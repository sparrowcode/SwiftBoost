// The MIT License (MIT)
// Copyright © 2020 Ivan Varabei (varabeis@icloud.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE. IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if canImport(Foundation)
import Foundation

public extension Date {

    var isInFuture: Bool {
        return self > Date()
    }

    var isInPast: Bool {
        return self < Date()
    }
    
    var isInToday: Bool {
        return Calendar.current.isDateInToday(self)
    }

    var isInYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }

    var isInTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }

    var isInWeekend: Bool {
        return Calendar.current.isDateInWeekend(self)
    }

    var isWorkday: Bool {
        return !Calendar.current.isDateInWeekend(self)
    }
    
    var isInCurrentWeek: Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
    }

    var isInCurrentMonth: Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .month)
    }

    var isInCurrentYear: Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .year)
    }
    
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        return (min(date1, date2) ... max(date1, date2)).contains(self)
    }
    
    func getDates(toDate date: Date, withComponent component: Calendar.Component, withUnit unit: Int) -> [Date] {
        var fromDate = self
        var dates = [fromDate]
        while fromDate < date {
            if let newDate = Calendar.current.date(byAdding: component, value: unit, to: fromDate)?.beginning(of: .day) {
                dates.append(newDate)
                fromDate = newDate
            }
        }
        return dates
    }
    
    func component(_ component: Calendar.Component) -> Int {
        Calendar.current.component(component, from: self)
    }
    
    func componentBetween(_ component: Calendar.Component, end: Date) -> Int {
        let components = Calendar.current.dateComponents([component], from: self, to: end)
        switch component {
        case .nanosecond:
            return components.nanosecond ?? 0
        case .second:
            return components.second ?? 0
        case .minute:
            return components.minute ?? 0
        case .hour:
            return components.hour ?? 0
        case .day:
            return components.day ?? 0
        case .month:
            return components.month ?? 0
        case .year:
            return components.year ?? 0
        default:
            return 0
        }
    }
    
    func adding(_ component: Calendar.Component, value: Int = 1) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self) ?? self
    }
    
    mutating func add(_ component: Calendar.Component, value: Int = 1) {
        if let date = Calendar.current.date(byAdding: component, value: value, to: self) {
            self = date
        }
    }
    
    func changing(_ component: Calendar.Component, value: Int) -> Date? {
        switch component {
        case .nanosecond:
            #if targetEnvironment(macCatalyst)
            // The `Calendar` implementation in `macCatalyst` does not know that a nanosecond is 1/1,000,000,000th of a second
            let allowedRange = 0..<1_000_000_000
            #else
            let allowedRange = Calendar.current.range(of: .nanosecond, in: .second, for: self)!
            #endif
            guard allowedRange.contains(value) else { return nil }
            let currentNanoseconds = Calendar.current.component(.nanosecond, from: self)
            let nanosecondsToAdd = value - currentNanoseconds
            return Calendar.current.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: self)
        case .second:
            let allowedRange = Calendar.current.range(of: .second, in: .minute, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentSeconds = Calendar.current.component(.second, from: self)
            let secondsToAdd = value - currentSeconds
            return Calendar.current.date(byAdding: .second, value: secondsToAdd, to: self)
        case .minute:
            let allowedRange = Calendar.current.range(of: .minute, in: .hour, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentMinutes = Calendar.current.component(.minute, from: self)
            let minutesToAdd = value - currentMinutes
            return Calendar.current.date(byAdding: .minute, value: minutesToAdd, to: self)
        case .hour:
            let allowedRange = Calendar.current.range(of: .hour, in: .day, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentHour = Calendar.current.component(.hour, from: self)
            let hoursToAdd = value - currentHour
            return Calendar.current.date(byAdding: .hour, value: hoursToAdd, to: self)
        case .day:
            let allowedRange = Calendar.current.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentDay = Calendar.current.component(.day, from: self)
            let daysToAdd = value - currentDay
            return Calendar.current.date(byAdding: .day, value: daysToAdd, to: self)
        case .month:
            let allowedRange = Calendar.current.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentMonth = Calendar.current.component(.month, from: self)
            let monthsToAdd = value - currentMonth
            return Calendar.current.date(byAdding: .month, value: monthsToAdd, to: self)
        case .year:
            guard value > 0 else { return nil }
            let currentYear = Calendar.current.component(.year, from: self)
            let yearsToAdd = value - currentYear
            return Calendar.current.date(byAdding: .year, value: yearsToAdd, to: self)
        default:
            return Calendar.current.date(bySetting: component, value: value, of: self)
        }
    }
    
    func beginning(of component: Calendar.Component) -> Date? {
        if component == .day {
            return Calendar.current.startOfDay(for: self)
        }

        var components: Set<Calendar.Component> {
            switch component {
            case .second:
                return [.year, .month, .day, .hour, .minute, .second]
                
            case .minute:
                return [.year, .month, .day, .hour, .minute]

            case .hour:
                return [.year, .month, .day, .hour]
                
            case .day:
                return [.year, .month, .day]

            case .weekOfYear, .weekOfMonth:
                return [.yearForWeekOfYear, .weekOfYear]

            case .month:
                return [.year, .month]

            case .year:
                return [.year]

            default:
                return []
            }
        }

        guard !components.isEmpty else { return nil }
        return Calendar.current.date(from: Calendar.current.dateComponents(components, from: self))
    }
    
    func end(of component: Calendar.Component) -> Date? {
        guard let date = self.beginning(of: component) else { return nil }
        
        var components: DateComponents? {
            switch component {
            case .second:
                var components = DateComponents()
                components.second = 1
                components.nanosecond = -1
                return components
                
            case .minute:
                var components = DateComponents()
                components.minute = 1
                components.second = -1
                return components

            case .hour:
                var components = DateComponents()
                components.hour = 1
                components.second = -1
                return components
                
            case .day:
                var components = DateComponents()
                components.day = 1
                components.second = -1
                return components

            case .weekOfYear, .weekOfMonth:
                var components = DateComponents()
                components.weekOfYear = 1
                components.second = -1
                return components

            case .month:
                var components = DateComponents()
                components.month = 1
                components.second = -1
                return components

            case .year:
                var components = DateComponents()
                components.year = 1
                components.second = -1
                return components

            default:
                return nil
            }
        }
        guard let addedComponent = components else { return nil }
        return Calendar.current.date(byAdding: addedComponent, to: date)!
    }
    
    func interval(to: Date, dateStyle: DateIntervalFormatter.Style = .medium, timeStyle: DateIntervalFormatter.Style = .none) -> String {
        let formatter = DateIntervalFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self, to: to)
    }
    
    func string(withFormat format: String = "dd.MM.yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func string(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        DateFormatter.localizedString(from: self, dateStyle: dateStyle, timeStyle: timeStyle)
    }
    
    func stringLocalized(withFormat format: String = "dd.MM.yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }
    
    func age(toDate date: Date, components: Set<Calendar.Component>) -> String {
        let calender = Calendar.current
        let dateComponent = calender.dateComponents(components, from: self, to: date)
        var years = ""; var months = ""; var days = "";
        
        if let _years = dateComponent.year, _years > 0 {
            years = Calendar.Component.year.quantitiesOfTime(numberOfUnits: _years) ?? ""
        }
        if let _months = dateComponent.month, _months > 0 {
            months = Calendar.Component.month.quantitiesOfTime(numberOfUnits: _months) ?? ""
        }
        if var _days = dateComponent.day {
            _days = _days == 0 ? 1 : _days
            days = Calendar.Component.day.quantitiesOfTime(numberOfUnits: _days) ?? ""
        }
        return "\(years) \(months) \(days)".trim
    }
}
#endif



