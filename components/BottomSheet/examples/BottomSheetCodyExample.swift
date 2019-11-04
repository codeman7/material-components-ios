import UIKit
import MaterialComponents

@available(iOS 10.0, *)
class ExampleCode: UIViewController {
  let label = UILabel()
  let customView = CustomView()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    customView.label.font = UIFont.preferredFont(forTextStyle: .body)
    if #available(iOS 11.0, *) {
      customView.label.adjustsFontForContentSizeCategory = true
    }
    customView.label.textColor = .black
    customView.label.text = "Foo"
    view.addSubview(customView)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    customView.sizeToFit()
    customView.center = view.center
  }
}

// MARK: Catalog by convention
@available(iOS 10.0, *)
extension ExampleCode {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Bottom Sheet", "Cody"],
      "primaryDemo": false,
      "presentable": true,
    ]
  }
}

@available(iOS 10.0, *)
class CustomView: UIView, UIContentSizeCategoryAdjusting {
  var adjustsFontForContentSizeCategory: Bool {
    get {
      return label.adjustsFontForContentSizeCategory
    }

    set {
      label.adjustsFontForContentSizeCategory = newValue
    }
  }

  let label = UILabel()

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    return label.sizeThatFits(size)
  }

  init() {
    super.init(frame: .zero)
    label.text = ""
    addSubview(label)

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    let firstSize = label.sizeThatFits(bounds.size)
    print("Label sizeThatFits first = \(firstSize)")
    label.frame = bounds
    let secondarySize = label.sizeThatFits(bounds.size)
    print("label sizeThatFits = \(secondarySize)")
  }
}
