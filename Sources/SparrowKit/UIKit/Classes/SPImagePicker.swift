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

#if canImport(UIKit) && (os(iOS))
import UIKit

/**
 SparrowKit: Wrapper of pick image.
 */
public class SPImagePicker {
    
    // MARK: - Public
    
    /**
     SparrowKit: Start pick process by source type.
     
     - parameter sourceType: Type of source.
     - parameter controller: Parent controller for present.
     - parameter completion: Call after complete picking.
     */
    public static func pick(sourceType: UIImagePickerController.SourceType, on controller: UIViewController, completion: @escaping (UIImage?) -> Void) {
        let handler = SPImagePickerHandler.shared
        handler.completion = completion
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = handler
        imagePickerController.sourceType = sourceType
        controller.present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: - Private
    
    private init() {}
    
    // MARK: - Models
    
    private class SPImagePickerHandler: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        // MARK: - UIImagePickerControllerDelegate
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                completion(image)
                picker.dismiss(animated: true, completion: nil)
                return
            }
            if let image = info[.originalImage] as? UIImage {
                completion(image)
                picker.dismiss(animated: true, completion: nil)
                return
            }
            // Other
            completion(nil)
            picker.dismiss(animated: true, completion: nil)
            return
        }
        
        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            completion(nil)
            picker.dismiss(animated: true, completion: nil)
        }
        
        // MARK: - Singltone
        
        internal var completion: (UIImage?) -> Void = { _ in }
        internal static var shared = SPImagePickerHandler()
        
        private override init() {
            super.init()
        }
    }
}
#endif
