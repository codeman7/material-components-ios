import Metal



class Hello: UIViewController {
  let button = UIButton()
  override func viewDidLoad() {
    super.viewDidLoad()

    button.addTarget(self, action: #selector(presentSearch), for: .touchUpInside)
    button.setTitle("Search", for: .normal)
    button.sizeToFit()
    view.backgroundColor = .blue
    view.addSubview(button)
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    button.center = view.center
  }

  @objc func presentSearch() {
    print("hello")
    let results = UIViewController()
    results.view.backgroundColor = .green
    let search = CustomSearch(searchResultsController: results)
    present(search, animated: true, completion: nil)
  }
}

class CustomSearch: UISearchController {
  override var searchBar: UISearchBar {
    let search = UISearchBar(frame: .zero)
    search.tintColor = .green
    search.backgroundColor = .lightGray
    return search
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    searchBar.frame = CGRect(origin: .zero, size: CGSize(width: 812, height: 56))
  }
}

// MARK: Catalog by Convensions
extension Hello {
  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Action Sheet", "Hello (Swift)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
