//
//  Copyright (c) 2013 Luke Scott
//  https://github.com/lukescott/DraggableCollectionView
//  Distributed under MIT license
//

#import <UIKit/UIKit.h>
#import "UICollectionView+Draggable.h"
#import "DraggableCollectionViewFlowLayout.h"
#import "Cell.h"

@interface ViewController : UIViewController <UICollectionViewDataSource_Draggable, UICollectionViewDelegate>{
    UICollectionView * Collectionview;
    DraggableCollectionViewFlowLayout * Layout;
    Cell * CellObj;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end
