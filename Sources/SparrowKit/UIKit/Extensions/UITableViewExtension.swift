// The MIT License (MIT)
// Copyright © 2020 Ivan Vorobei (hello@ivanvorobei.io)
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
// SOFTWARE.

#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public extension UITableView {
    
    // MARK: - Helpers
    
    /**
     SparrowKit: Get last index of last section of collection.
     */
    var indexPathForLastRow: IndexPath? {
        guard let lastSection = lastSection else { return nil }
        return indexPathForLastRow(inSection: lastSection)
    }
    
    /**
     SparrowKit: Get last index path for special section.
     
     - parameter section: Section for which need get last row.
     */
    func indexPathForLastRow(inSection section: Int) -> IndexPath? {
        guard numberOfSections > 0, section >= 0 else { return nil }
        guard numberOfRows(inSection: section) > 0 else {
            return IndexPath(row: 0, section: section)
        }
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }
    
    /**
     SparrowKit: Index of last section.
     */
    var lastSection: Int? {
        return numberOfSections > 0 ? numberOfSections - 1 : nil
    }
    
    /**
     SparrowKit: Total count of rows.
     */
    func numberOfRows() -> Int {
        var section = 0
        var rowCount = 0
        while section < numberOfSections {
            rowCount += numberOfRows(inSection: section)
            section += 1
        }
        return rowCount
    }
    
    /**
     SparrowKit: Check if index path is availabe.
     
     - parameter indexPath: Checking index path.
     */
    func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section >= 0 &&
            indexPath.row >= 0 &&
            indexPath.section < numberOfSections &&
            indexPath.row < numberOfRows(inSection: indexPath.section)
    }
    
    /**
     SparrowKit: Scroll to index path.
     
     If index path isn't availalbe, scroll will be canceled.
     
     - parameter indexPath: Scroll to this index path.
     - parameter scrollPosition: Position of cell to which scroll.
     - parameter animated: Is aniamted scroll.
     */
    func safeScrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard isValidIndexPath(indexPath) else { return }
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
    
    // MARK: - Cell Registration
    
    /**
     SparrowKit: Register cell with `ID` its name class.
     
     - parameter class: Class of `UITableViewCell`.
     */
    func register<T: UITableViewCell>(_ class: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: `class`))
    }
    
    /**
     SparrowKit: Dequeue cell with `ID` its name class.
     
     - parameter class: Class of `UITableViewCell`.
     - parameter indexPath: Index path of getting cell.
     */
    func dequeueReusableCell<T: UITableViewCell>(withClass class: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: `class`), for: indexPath) as? T else {
            fatalError()
        }
        if let cell = cell as? SPTableViewCell {
            cell.currentIndexPath = indexPath
        }
        return cell
    }
    
    // MARK: - Header Footer Registration
    
    /**
     SparrowKit: Register header footer view with `ID` its name class.
     
     - parameter class: Class of `UITableViewHeaderFooterView`.
     - parameter kind: Kind of usage reusable view.
     */
    func register<T: UITableViewHeaderFooterView>(_ class: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: `class`))
    }
    
    /**
     SparrowKit: Dequeue header footer view  with `ID` its name class.
     
     - parameter class: Class of `UITableViewHeaderFooterView`.
     */
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass class: T.Type) -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: String(describing: `class`)) as? T else {
            fatalError()
        }
        return view
    }
    
}
#endif
