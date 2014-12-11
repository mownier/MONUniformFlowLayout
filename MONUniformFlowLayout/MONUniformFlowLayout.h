//
//  MONUniformFlowLayout.h
//
//  Created by mownier on 12/2/14.
//  Copyright (c) 2014 mownier. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Spacing for the items
 */
typedef struct MONInterItemSpacing {
    CGFloat x, y;
} MONInterItemSpacing;

/**
 * Creates an InterItemSpacing struct
 */
static inline MONInterItemSpacing MONInterItemSpacingMake(CGFloat x, CGFloat y) {
    MONInterItemSpacing spacing = {x, y};
    return spacing;
}

@interface MONUniformFlowLayout : UICollectionViewFlowLayout

/// The inter spacing for all items
@property (readwrite, nonatomic) MONInterItemSpacing interItemSpacing;

/// Condition to enable/disable sticky headers
@property (readwrite, nonatomic) BOOL enableStickyHeader;

/**
 * Computes the width of all the items for a particular section
 * @param section A particular section in the collection view
 * @return The width of all the items for a particular section
 */
- (CGFloat)computeItemWidthInSection:(NSInteger)section;

@end

/**
 * Handles the definition of the item height, header height,
 * footer height, section spacing, and number of columns
 * for a particular section
 */
@protocol MONUniformFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

/**
 * Gets the item height in a particular section
 * @param collectionView The involved UICollectionView
 *        layout The involed UICollectionViewFlowLayout
 *        section The section that needs the value of the height of it's items
 * @return Height for all the section's items
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(MONUniformFlowLayout *)layout itemHeightInSection:(NSInteger)section;

@optional

/**
 * Gets the header height in a particular section
 * @param collectionView The involved UICollectionView
 *        layout The involed UICollectionViewFlowLayout
 *        section The section that needs the value of the it's header height
 * @return Height of the section's header
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(MONUniformFlowLayout *)layout headerHeightInSection:(NSInteger)section;

/**
 * Gets the footer height in a particular section
 * @param collectionView The involved UICollectionView
 *        layout The involed UICollectionViewFlowLayout
 *        section The section that needs the value of the it's footer height
 * @return Height of the section's footer
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(MONUniformFlowLayout *)layout footerHeightInSection:(NSInteger)section;

/**
 * Gets the spacing between sections
 * @param collectionView The involved UICollectionView
 *        layout The involed UICollectionViewFlowLayout
 * @return Section spacing between sections
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView sectionSpacingForlayout:(MONUniformFlowLayout *)layout;

/**
 * Gets the number of columns in a particular section
 * @param collectionView The involved UICollectionView
 *        layout The involed UICollectionViewFlowLayout
 *        section The section that needs the value of the it's footer height
 * @return Number of columns
 */
- (NSUInteger)collectionView:(UICollectionView *)collectionView layout:(MONUniformFlowLayout *)layout numberOfColumnsInSection:(NSInteger)section;

@end



