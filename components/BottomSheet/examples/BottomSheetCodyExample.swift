import UIKit
import MaterialComponents

class ExampleCode: UIViewController {
  let presentButton = UIButton()
  override func viewDidLoad() {
    super.viewDidLoad()

    presentButton.setTitle("Present", for: .normal)
    presentButton.setTitleColor(.black, for: .normal)
    presentButton.backgroundColor = .white
    presentButton.sizeToFit()
    presentButton.addTarget(self, action: #selector(presentBottomSheet), for: .touchUpInside)
    view.backgroundColor = .white
    view.addSubview(presentButton)
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    presentButton.center = view.center
  }

  @objc func presentBottomSheet() {
    let bottomSheet = CodyBottomSheet()
    present(bottomSheet, animated: true, completion: nil)
  }
}

// MARK: Catalog by convention
extension ExampleCode {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Bottom Sheet", "Cody"],
      "primaryDemo": false,
      "presentable": true,
      "debug": true,
    ]
  }
}


class CodyBottomSheet: UIViewController {
  let transitionController = MDCBottomSheetTransitionController()
  var expanded: Bool = false
  var cellNumber: Int {
    return expanded ? 100 : 5
  }
  let tableView = UITableView()

  init() {
    super.init(nibName: nil, bundle: nil)
    transitionController.dismissOnBackgroundTap = true
    super.transitioningDelegate = transitionController
    super.modalPresentationStyle = .custom
    self.view.backgroundColor = .white
    transitionController.trackingScrollView = tableView
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellTypeIdentifier")
    tableView.delegate = self
    tableView.dataSource = self
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(tableView)
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    if let bottom = presentationController as? MDCBottomSheetPresentationController {
      let height: CGFloat
      if expanded {
        tableView.contentOffset = CGPoint(x: 0, y: -77)
        tableView.contentInset = UIEdgeInsets(top: 77, left: 0, bottom: 0, right: 0)
        height = view.bounds.height / 2
      } else {
        tableView.contentOffset = CGPoint(x: 0, y: 0)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        height = tableView.contentSize.height
      }
      print("Height = \(height)")
      bottom.preferredSheetHeight = height
    }
    print("tableView.contentSize = \(tableView.contentSize)")
    tableView.frame = view.bounds
  }
}

extension CodyBottomSheet: UITableViewDataSource {
  // Return the number of rows for the table.
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return cellNumber
  }

  // Provide a cell object for each row.
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     // Fetch a cell of the appropriate type.
     let cell = tableView.dequeueReusableCell(withIdentifier: "cellTypeIdentifier", for: indexPath)

     // Configure the cell’s contents.
    cell.textLabel!.text = "Cell #\(indexPath.row)"

     return cell
  }
}

extension CodyBottomSheet: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    expanded = !expanded
    tableView.reloadData()
    view.setNeedsLayout()
  }
}
