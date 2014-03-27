//
//  RFQuiltLayout.h
//
//  Created by Bryce Redd on 12/7/12.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RFQuiltLayoutDelegate <UICollectionViewDelegate>
@optional

- (CGSize)blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath; // defaults to 1x1
- (UIEdgeInsets)insetForItemAtIndexPath:(NSIndexPath *)indexPath; // defaults to uiedgeinsetszero

/*
 Limitation: insets in the axis opposite to the scrolling axis must be constant across all sections.
 Use the sectionInset property instead.
 */
- (UIEdgeInsets)insetForSectionAtIndex:(NSInteger)section; // defaults to uiedgeinsetszero
@end


@interface RFQuiltLayout : UICollectionViewLayout
@property (nonatomic, weak) IBOutlet NSObject<RFQuiltLayoutDelegate>* delegate;

@property (nonatomic) CGSize itemBlockSize; // defaults to 100x100
@property (nonatomic) UIEdgeInsets itemInset; // effective only if delegate is not implemented
@property (nonatomic) UIEdgeInsets sectionInset; // effective only if delegate is not implemented
@property (nonatomic) UICollectionViewScrollDirection scrollDirection; // defaults to vertical
@property (nonatomic) CGSize headerReferenceSize; // defaults to CGSizeZero
@property (nonatomic) CGSize footerReferenceSize; // defaults to CGSizeZero

// only use this if you don't have more than 1000ish items.
// this will give you the correct size from the start and
// improve scrolling speed, at the cost of time at the beginning
@property (nonatomic) BOOL prelayoutEverything;

@end
