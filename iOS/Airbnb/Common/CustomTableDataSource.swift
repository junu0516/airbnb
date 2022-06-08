import UIKit

final class CustomTableDataSource<CELL: UITableViewCell, T>: NSObject, UITableViewDataSource {
    
    private var cellIdentifier : String
    private var items : [T]
    var configureCell : (CELL, T) -> ()
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func updateNewItems(items: [T]) {
        self.items = items
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CELL else { return UITableViewCell() }
        let item = self.items[indexPath.row]
        
        self.configureCell(cell, item)
        return cell
    }
}

