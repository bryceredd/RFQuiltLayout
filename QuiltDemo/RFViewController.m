//
//  RFViewController.m
//  QuiltDemo
//
//  Created by Bryce Redd on 12/26/12.
//  Copyright (c) 2012 Bryce Redd. All rights reserved.
//

#import "RFViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface RFViewController () {
    BOOL isAnimating;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSMutableArray* sections;
@end

@implementation RFViewController

- (void)viewDidLoad {
    
	self.sections = [NSMutableArray array];
	
	int num = 0;
	for(int i=0; i < 8; i++)
	{
		NSMutableArray *section = [NSMutableArray array];
		for(int j=0; j < 28; j++)
		{
			[section addObject:@(num)];
			num ++;
		}
		[self.sections addObject:section];
	}
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
	[self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
	[self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    
    RFQuiltLayout* layout = (id)[self.collectionView collectionViewLayout];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemBlockSize = CGSizeMake(100, 100);
	layout.sectionInset = UIEdgeInsetsMake(10, 150, 50, 150);
	layout.itemInset = UIEdgeInsetsMake(4, 4, 4, 4);
	layout.headerReferenceSize = CGSizeMake(720, 70);
	layout.footerReferenceSize = CGSizeMake(720, 70);
    
    [self.collectionView reloadData];
}

- (void) viewDidAppear:(BOOL)animated {
    [self.collectionView reloadData];
}

- (IBAction)remove:(id)sender {
	//    if(!self.numbers.count) return;
	//
	//    if(isAnimating) return;
	//    isAnimating = YES;
	//
	//    [self.collectionView performBatchUpdates:^{
	//        int index = arc4random() % MAX(1, self.numbers.count);
	//        [self.numbers removeObjectAtIndex:index];
	//        [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]];
	//    } completion:^(BOOL done) {
	//        isAnimating = NO;
	//    }];
}

- (IBAction)refresh:(id)sender {
    [self.collectionView reloadData];
}

- (IBAction)add:(id)sender {
	//    if(isAnimating) return;
	//    isAnimating = YES;
	//
	//    [self.collectionView performBatchUpdates:^{
	//        int index = arc4random() % MAX(self.numbers.count,1);
	//        [self.numbers insertObject:@(++num) atIndex:index];
	//        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]];
	//    } completion:^(BOOL done) {
	//        isAnimating = NO;
	//    }];
}

- (UIColor*)colorForNumber:(NSNumber*)num {
    return [UIColor colorWithHue:((19 * num.intValue) % 255)/255.f saturation:1.f brightness:1.f alpha:1.f];
}

- (CGSize)blockSizeForNumber:(NSNumber*)num {
	return ([num intValue] % 2 ? CGSizeMake(1, 1) : CGSizeMake(2, 1));
}

#pragma mark - UICollectionView Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return [self.sections count];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
	return [[self.sections objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UILabel* label = (id)[cell viewWithTag:5];
    if(!label) {
		label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 30, 20)];
		label.tag = 5;
		label.textColor = [UIColor blackColor];
		label.backgroundColor = [UIColor clearColor];
		[cell addSubview:label];
	}
	
	NSNumber *number = [[self.sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	cell.backgroundColor = [self colorForNumber:number];
	label.text = [NSString stringWithFormat:@"%@", number];
	
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
	UICollectionReusableView *view = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
	{
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
		headerView.backgroundColor = [UIColor redColor];
        view = headerView;
    }
	else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
	{
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
		footerView.backgroundColor = [UIColor blueColor];
        view = footerView;
    }
	
    return view;
}


#pragma mark – RFQuiltLayoutDelegate

- (CGSize) blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	NSNumber *number = [[self.sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	return [self blockSizeForNumber:number];
}

@end
