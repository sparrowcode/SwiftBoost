#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public extension UIImageView {
    
    func download(
        from url: URL,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        placeholder: UIImage? = nil,
        completionHandler: ((UIImage?) -> Void)? = nil) {
        
        image = placeholder
        self.contentMode = contentMode
        URLSession.shared.dataTask(with: url) { data, response, _ in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data,
                let image = UIImage(data: data) else {
                completionHandler?(nil)
                return
            }
            DispatchQueue.main.async { [unowned self] in
                self.image = image
                completionHandler?(image)
            }
        }.resume()
    }
    
    func blur(withStyle style: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        clipsToBounds = true
    }
}
#endif
