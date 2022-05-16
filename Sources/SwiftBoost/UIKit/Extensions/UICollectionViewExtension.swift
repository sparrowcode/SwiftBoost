#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public extension UICollectionView {
    
    func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section >= 0 &&
        indexPath.item >= 0 &&
        indexPath.section < numberOfSections &&
        indexPath.item < numberOfItems(inSection: indexPath.section)
    }
    
    func safeScrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        guard isValidIndexPath(indexPath) else { return }
        scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
    }
    
    // MARK: - Cell Registration
    
    func register<T: UICollectionViewCell>(_ class: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: `class`))
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(withClass class: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: `class`), for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }
    
    // MARK: - Header & Footer Registration
    
    func register<T: UICollectionReusableView>(_ class: T.Type, kind: String) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: `class`))
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(withCalss class: T.Type, kind: String, for indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: `class`), for: indexPath) as? T else {
            fatalError()
        }
        return view
    }
    
    // MARK: - Layout
    
    func invalidateLayout(animated: Bool) {
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
