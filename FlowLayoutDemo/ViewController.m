//
//  Copyright (c) 2013 Luke Scott
//  https://github.com/lukescott/DraggableCollectionView
//  Distributed under MIT license
//

#import "ViewController.h"
#import "Cell.h"

#define SECTION_COUNT 1
#define ITEM_COUNT 10

@interface ViewController ()
{
    NSMutableArray *sections;
    NSMutableArray *data;
    NSMutableDictionary *numberData;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [super viewDidLoad];
    
    sections = [[NSMutableArray alloc] initWithCapacity:ITEM_COUNT];
    for(int s = 0; s < SECTION_COUNT; s++) {
        data = [[NSMutableArray alloc] initWithCapacity:ITEM_COUNT];
        NSMutableArray *colors = [NSMutableArray array];
        colors = [[NSMutableArray alloc] initWithObjects:
                  [UIColor colorWithRed:1 green:0 blue:0 alpha:1],
                  [UIColor colorWithRed:1 green:0.25 blue:0 alpha:1],
                  [UIColor colorWithRed:1 green:0.5 blue:0 alpha:1],
                  [UIColor colorWithRed:1 green:0.75 blue:0 alpha:1],
                  [UIColor colorWithRed:1 green:1 blue:0 alpha:1],
                  [UIColor colorWithRed:0.75 green:1 blue:0 alpha:1],
                  [UIColor colorWithRed:0.5 green:1 blue:0 alpha:1],
                  [UIColor colorWithRed:0 green:0.25 blue:1 alpha:1],
                  [UIColor colorWithRed:0 green:.75 blue:0 alpha:1],
                  [UIColor colorWithRed:1 green:1 blue:0.25 alpha:1],
                  nil];

        for(int i = 0; i < ITEM_COUNT; i++) {
           numberData = [[NSMutableDictionary alloc] init];
            [numberData setObject:[NSString stringWithFormat:@"%c%@", 65+s, @(i)] forKey:@"number"];
            [numberData setObject:[colors objectAtIndex:i] forKey:@"color"];
            [data addObject:numberData];
            
        }
        NSLog(@"Color Data:%@",data);
        [sections addObject:data];
    }
    
    [self CollectionViewLayout];
}
-(void) CollectionViewLayout {
    
    Layout=[[DraggableCollectionViewFlowLayout alloc] init];
    Layout.minimumLineSpacing = 20;
    Collectionview=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, 768, 1004)collectionViewLayout:Layout];
    [Collectionview setDataSource:self];
    [Collectionview setDelegate:self];
    Collectionview.draggable=YES;
    Cell * WidgetCell = [[Cell alloc] init];
    [Collectionview registerClass:[WidgetCell class] forCellWithReuseIdentifier:@"CollectionCell"];
    [Collectionview setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:Collectionview];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return sections.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2==0) {
        return CGSizeMake( 250, 300);
    }
    return CGSizeMake( 450, 300);
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 26.0f;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[sections objectAtIndex:section] count];
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 20 , 0, 20);
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell *cell = (Cell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    NSMutableArray *data12 = [sections objectAtIndex:indexPath.section];
    NSLog(@"Data@:: %@",[[data12 valueForKey:@"number"] objectAtIndex:indexPath.row]);
//    CGFloat redLevel    = rand() / (float) RAND_MAX;
//    CGFloat greenLevel  = rand() / (float) RAND_MAX;
//    CGFloat blueLevel   = rand() / (float) RAND_MAX;
//    
//    cell.backgroundColor = [UIColor colorWithRed: redLevel
//                                             green: greenLevel
//                                              blue: blueLevel
//                                             alpha: 1.0];
    
    cell.backgroundColor = [[data12 valueForKey:@"color"] objectAtIndex:indexPath.row];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 100, 50, 100)];
    label.text = [NSString stringWithFormat:@"%@",[[data12 valueForKey:@"number"] objectAtIndex:indexPath.row]];
    label.font = [UIFont boldSystemFontOfSize:30];
    [cell.contentView addSubview:label];
    
    return cell;
}

- (BOOL)collectionView:(LSCollectionViewHelper *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath
{
// Prevent item from being moved to index 0
//    if (toIndexPath.item == 0) {
//        return NO;
//    }
    return YES;
}

- (void)collectionView:(LSCollectionViewHelper *)collectionView moveItemAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSMutableArray *data1 = [sections objectAtIndex:fromIndexPath.section];
    NSMutableArray *data2 = [sections objectAtIndex:toIndexPath.section];
    NSString *index = [data1 objectAtIndex:fromIndexPath.item];
    
    [data1 removeObjectAtIndex:fromIndexPath.item];
    [data2 insertObject:index atIndex:toIndexPath.item];
}

@end
