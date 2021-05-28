import UIKit

extension UITabBar {

    struct TabBarColorSet {
        let background: UIColor?
        let selectedBackground: UIColor?
        let item: UIColor?
        let selectedItem: UIColor?
    }

    func updateColors(with colorSet: TabBarColorSet) {

        barTintColor = colorSet.background ?? barTintColor
        tintColor = colorSet.selectedItem ?? tintColor

        backgroundImage = UIImage()
        isTranslucent = false

        guard let barItems = items else {
            return
        }

        if let selectedbg = colorSet.selectedBackground {
            let rect = CGSize(width: frame.width / CGFloat(barItems.count), height: frame.height)
            selectionIndicatorImage = { (color: UIColor, size: CGSize) -> UIImage in
                UIGraphicsBeginImageContextWithOptions(size, false, 1)
                color.setFill()
                UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
                guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
                UIGraphicsEndImageContext()
                guard let aCgImage = image.cgImage else { return UIImage() }
                return UIImage(cgImage: aCgImage)
            }(selectedbg, rect)
        }

        if let itemColor = colorSet.item {
            for barItem in barItems as [UITabBarItem] {
                barItem.setTitleTextAttributes([.foregroundColor: itemColor], for: .normal)
                if let selected = colorSet.selectedItem {
                    barItem.setTitleTextAttributes([.foregroundColor: selected], for: .selected)
                }
            }
        }
    }
}
