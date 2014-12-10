//
//  MONUniformFlowLayout.h
//
//  Created by mownier on 12/2/14.
//  Copyright (c) 2014 mownier. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct InterItemSpacing {
    CGFloat x, y;
} InterItemSpacing;

static inline InterItemSpacing InterItemSpacingMake(CGFloat x, CGFloat y) {
    InterItemSpacing spacing = {x, y};
    return spacing;
}

@interface MONUniformFlowLayout : UICollectionViewFlowLayout

@property (readwrite, nonatomic) InterItemSpacing interItemSpacing;
@property (readwrite, nonatomic) BOOL enableStickyHeader;

- (CGFloat)computeItemWidthInSection:(NSInteger)section;

@end

@protocol SimpleFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(MONUniformFlowLayout *)layout itemHeightInSection:(NSInteger)section;

@optional
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(MONUniformFlowLayout *)layout headerHeightInSection:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(MONUniformFlowLayout *)layout footerHeightInSection:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView sectionSpacingForlayout:(MONUniformFlowLayout *)layout;

- (NSUInteger)collectionView:(UICollectionView *)collectionView layout:(MONUniformFlowLayout *)layout numberOfColumnsInSection:(NSInteger)section;

@end



