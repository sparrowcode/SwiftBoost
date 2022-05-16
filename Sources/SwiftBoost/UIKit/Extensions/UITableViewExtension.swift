#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public extension UITableView {
    
    // MARK: - Helpers
    
    func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section >= 0 &&
        indexPath.row >= 0 &&
        indexPath.section < numberOfSections &&
        indexPath.row < numberOfRows(inSection: indexPath.section)
    }
    
    func safeScrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard isValidIndexPath(indexPath) else { return }
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
    
    // MARK: - Cell Registration
    
    func register<T: UITableViewCell>(_ class: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: `class`))
    }
    
    func dequeueReusableCell<T: UITableViewCell>(withClass class: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: `class`), for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }
    
    // MARK: - Header & Footer Registration
    
    func register<T: UITableViewHeaderFooterView>(_ class: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: `class`))
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass class: T.Type) -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: String(describing: `class`)) as? T else {
            fatalError()
        }
        return view
    }
}
#endif
