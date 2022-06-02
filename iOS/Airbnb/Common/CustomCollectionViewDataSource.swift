import UIKit

final class CustomCollectionViewDataSource<CELL: UICollectionViewCell, T>: NSObject, UICollectionViewDataSource {
    
    private var identifier : String
    private var items : [T]
    var updateCell : (CELL, T) -> ()
    
    init(identifier : String, items : [T], updateCell : @escaping (CELL, T) -> ()) {
        self.identifier = identifier
        self.items =  items
        self.updateCell = updateCell
    }
    
    func updateNewItems(items: [T]) {
        self.items = items
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CELL else { return UICollectionViewCell() }
        let item = self.items[indexPath.row]
        
        self.updateCell(cell, item)
        return cell
    }
}

