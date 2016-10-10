RFQUILTLAYOUT
=============

RFQuiltLayout is a [UICollectionViewLayout](http://developer.apple.com/library/ios/#documentation/UIKit/Reference/UICollectionViewLayout_class/Reference/Reference.html#//apple_ref/occ/cl/UICollectionViewLayout) subclass, used as the layout object of [UICollectionView](http://developer.apple.com/library/ios/#documentation/UIKit/Reference/UICollectionView_class/Reference/Reference.html). 

![Demo 1](http://i.imgur.com/BcQhwzRm.png)
![Demo 2](http://i.imgur.com/hoBWCism.png)


Installation
------------

Add the layout as the subclass of your UICollectionViewLayout.

![Subclass the layout](http://i.imgur.com/vlqqKjP.png)


*Make sure you set the delegate of the flow layout*

    - (void) viewDidLoad {
      // ...

      RFQuiltLayout* layout = (id)[self.collectionView collectionViewLayout];
      layout.direction = UICollectionViewScrollDirectionVertical;
      layout.blockPixels = CGSizeMake(100, 100);
    }
    
    - (CGSize) blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
        switch (indexPath.section) {
            case 0:
                return CGSizeMake(1, -100); // Negative values will set absolute values;
            default:
                if (indexPath.row % 2 == 0)
                    return CGSizeMake(1, 2);
                else 
                    return CGSizeMake(2, 1);
        }
    }

(Note: all delegate methods and properties are optional)


