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

extension UICollectionView {
    
    // MARK: - Helpers
    
    /**
     SparrowKit: Get last index of last section of collection.
     */
    open var indexPathForLastItem: IndexPath? {
        return indexPathForLastItem(inSection: lastSection)
    }
    
    /**
     SparrowKit: Get last index path for special section.
     
     - parameter section: Section for which need get last row.
     */
    open func indexPathForLastItem(inSection section: Int) -> IndexPath? {
        guard section >= 0 else {
            return nil
        }
        guard section < numberOfSections else {
            return nil
        }
        guard numberOfItems(inSection: section) > 0 else {
            return IndexPath(item: 0, section: section)
        }
        return IndexPath(item: numberOfItems(inSection: section) - 1, section: section)
    }
    
    /**
     SparrowKit: Index of last section.
     */
    open var lastSection: Int {
        return numberOfSections > 0 ? numberOfSections - 1 : 0
    }
    
    /**
     SparrowKit: Total count of rows.
     */
    open func numberOfItems() -> Int {
        var section = 0
        var itemsCount = 0
        while section < numberOfSections {
            itemsCount += numberOfItems(inSection: section)
            section += 1
        }
        return itemsCount
    }
    
    /**
     SparrowKit: Check if index path is availabe.
     
     - parameter indexPath: Checking index path.
     */
    open func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section >= 0 &&
            indexPath.item >= 0 &&
            indexPath.section < numberOfSections &&
            indexPath.item < numberOfItems(inSection: indexPath.section)
    }
    
    /**
     SparrowKit: Scroll to index path.
     
     If index path isn't availalbe, scroll will be canceled.
     
     - parameter indexPath: Scroll to this index path.
     - parameter scrollPosition: Position of cell to which scroll.
     - parameter animated: Is aniamted scroll.
     */
    open func safeScrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        guard isValidIndexPath(indexPath) else { return }
        scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
    }
    
    // MARK: - Cell Registration
    
    /**
     SparrowKit: Register cell with `ID` its name class.
     
     - parameter class: Class of `UICollectionViewCell`.
     */
    open func register<T: UICollectionViewCell>(_ class: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: `class`))
    }
    
    /**
     SparrowKit: Dequeue cell with `ID` its name class.
     
     - parameter class: Class of `UICollectionViewCell`.
     - parameter indexPath: Index path of getting cell.
     */
    open func dequeueReusableCell<T: UICollectionViewCell>(withClass class: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: `class`), for: indexPath) as? T else {
            fatalError()
        }
        if let cell = cell as? SPCollectionViewCell {
            cell.currentIndexPath = indexPath
        }
        return cell
    }
    
    // MARK: - Header Footer Registration
    
    /**
     SparrowKit: Register reusable view with `ID` its name class and `kind`.
     
     - parameter class: Class of `UICollectionReusableView`.
     - parameter kind: Kind of usage reusable view.
     */
    open func register<T: UICollectionReusableView>(_ class: T.Type, kind: String) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: `class`))
    }
    
    /**
     SparrowKit: Dequeue reusable view with `ID` its name class.
     
     - parameter class: Class of `UICollectionReusableView`.
     - parameter kind: Kind of usage reusable view.
     - parameter indexPath: Index path of getting reusable view.
     */
    open func dequeueReusableSupplementaryView<T: UICollectionReusableView>(withCalss class: T.Type, kind: String, for indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: `class`), for: indexPath) as? T else {
            fatalError()
        }
        if let cell = view as? SPCollectionViewCell {
            cell.currentIndexPath = indexPath
        }
        return view
    }
    
    // MARK: - Layout
    
    /**
     SparrowKit: Wrapper of invalidate layout.
     
     - parameter animated: If set to `true`, invalidate layout call in block of `performBatchUpdates`.
     */
    open func invalidateLayout(animated: Bool) {
        if animated {
            performBatchUpdates({
                self.collectionViewLayout.invalidateLayout()
            }, completion: nil)
        } else {
            collectionViewLayout.invalidateLayout()
        }
    }
}
#endif
