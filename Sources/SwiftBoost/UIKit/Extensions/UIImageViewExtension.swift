#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public extension UIImageView {
    
    @MainActor
    func download(
        from url: URL,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        placeholder: UIImage? = nil
    ) async -> UIImage? {
        image = placeholder
        self.contentMode = contentMode
        guard
            let (data, response) = try? await URLSession.shared.data(from: url),
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            response.mimeType?.hasPrefix("image") == true,
            let loaded = UIImage(data: data)
        else {
            return nil
        }
        image = loaded
        return loaded
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
