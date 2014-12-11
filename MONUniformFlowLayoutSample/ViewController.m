//
//  ViewController.m
//  CollectionSample
//
//  Created by mownier on 12/2/14.
//  Copyright (c) 2014 mownier. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "MONUniformFlowLayout.h"
#import "CollectionHeaderView.h"
#import "CollectionFooterView.h"

static NSString *kCollectionViewCellIdentifier = @"kCollectionViewCellIdentifier";
static NSString *kCollectionViewSectionHeaderIdentifier = @"kCollectionViewSectionHeaderIdentifier";
static NSString *kCollectionViewSectionFooterIdentifier = @"kCollectionViewSectionFooterIdentifier";

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MONUniformFlowLayoutDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) MONUniformFlowLayout *simpleLayout;

- (void)addVerticalConstraints:(NSArray **)verticalConstraints
         horizontalConstraints:(NSArray **)horizontalConstraints
                         views:(NSDictionary *)views
                       metrics:(NSDictionary *)metrics;

- (UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end

@implementation ViewController

#pragma mark -
#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
    [self.collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCollectionViewSectionHeaderIdentifier];
    [self.collectionView registerClass:[CollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kCollectionViewSectionFooterIdentifier];
    [self.view addSubview:self.collectionView];
    
    NSArray *v;
    NSArray *h;
    NSDictionary *views = @{ @"collectionView": self.collectionView };
    [self addVerticalConstraints:&v horizontalConstraints:&h views:views metrics:nil];
    [self.view addConstraints:v];
    [self.view addConstraints:h];
}

#pragma mark -
#pragma mark - Add Vertical and Horizontal Constraints

- (void)addVerticalConstraints:(NSArray *__autoreleasing *)verticalConstraints
         horizontalConstraints:(NSArray *__autoreleasing *)horizontalConstraints
                         views:(NSDictionary *)views
                       metrics:(NSDictionary *)metrics {
    NSMutableArray *v = [NSMutableArray new];
    NSMutableArray *h = [NSMutableArray new];
    
    [v addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[collectionView]-0-|" options:0 metrics:metrics views:views]];
    
    [h addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[collectionView]-0-|" options:0 metrics:metrics views:views]];
    
    *verticalConstraints = v;
    *horizontalConstraints = h;
}

#pragma mark -
#pragma mark - Collection View

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.simpleLayout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        NSDictionary *contentInset = [self.inputInfo objectForKey:@"content_inset"];
        _collectionView.contentInset = UIEdgeInsetsMake([[contentInset objectForKey:@"top"] floatValue],
                                                        [[contentInset objectForKey:@"left"] floatValue],
                                                        [[contentInset objectForKey:@"bottom"] floatValue],
                                                        [[contentInset objectForKey:@"right"] floatValue]);
    }
    return _collectionView;
}

- (MONUniformFlowLayout *)simpleLayout {
    if (!_simpleLayout) {
        _simpleLayout = [[MONUniformFlowLayout alloc] init];
        NSDictionary *itemSpacingInfo = [self.inputInfo objectForKey:@"item_spacing"];
        _simpleLayout.interItemSpacing = MONInterItemSpacingMake([[itemSpacingInfo objectForKey:@"horizontal"] floatValue],
                                                              [[itemSpacingInfo objectForKey:@"vertical"] floatValue]);
        _simpleLayout.enableStickyHeader = [[self.inputInfo objectForKey:@"sticky_header"] boolValue];
    }
    return _simpleLayout;
}

#pragma mark -
#pragma mark - Collection View Delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];
    NSArray *sections = [self.inputInfo objectForKey:@"sections"];
    NSDictionary *sectionDetails = [sections objectAtIndex:indexPath.section];
    cell.backgroundColor = [self colorWithHexString:[sectionDetails objectForKey:@"item_color"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc  = [UIViewController new];
    vc.view.backgroundColor = [UIColor lightGrayColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    NSArray *sections = [self.inputInfo objectForKey:@"sections"];
    NSDictionary *sectionDetails = [sections objectAtIndex:indexPath.section];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kCollectionViewSectionHeaderIdentifier forIndexPath:indexPath];
        headerView.backgroundColor = [self colorWithHexString:[sectionDetails objectForKey:@"header_color"]];
        reusableView = headerView;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        CollectionFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kCollectionViewSectionFooterIdentifier forIndexPath:indexPath];
        footerView.backgroundColor = [self colorWithHexString:[sectionDetails objectForKey:@"footer_color"]];
        reusableView = footerView;
    }
    
    return reusableView;
}

#pragma mark -
#pragma mark - Collection View Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    NSArray *sections = [self.inputInfo objectForKey:@"sections"];
    NSDictionary *sectionDetails = [sections objectAtIndex:section];
    return [[sectionDetails objectForKey:@"number_of_items"] integerValue];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [[self.inputInfo objectForKey:@"sections"] count];
}

#pragma mark -
#pragma mark - Get Number of Columns

- (NSUInteger)getNumberOfColumnsInSection:(NSInteger)section {
    UIDevice *device = [UIDevice currentDevice];
    NSArray *sections = [self.inputInfo objectForKey:@"sections"];
    NSDictionary *sectionDetails = [sections objectAtIndex:section];
    if (UIDeviceOrientationIsLandscape(device.orientation)) {
        return [[sectionDetails objectForKey:@"landscape_number_of_columns"] floatValue];
    } else {
        return [[sectionDetails objectForKey:@"portrait_number_of_columns"] floatValue];
    }
}

#pragma mark -
#pragma mark - Simple Flow Layout Delegate

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(MONUniformFlowLayout *)layout
      itemHeightInSection:(NSInteger)section {
    NSArray *sections = [self.inputInfo objectForKey:@"sections"];
    NSDictionary *sectionDetails = [sections objectAtIndex:section];
    return [[sectionDetails objectForKey:@"item_height"] floatValue];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(MONUniformFlowLayout *)layout
   headerHeightInSection:(NSInteger)section {
    NSArray *sections = [self.inputInfo objectForKey:@"sections"];
    NSDictionary *sectionDetails = [sections objectAtIndex:section];
    return [[sectionDetails objectForKey:@"header_height"] floatValue];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(MONUniformFlowLayout *)layout
   footerHeightInSection:(NSInteger)section {
    NSArray *sections = [self.inputInfo objectForKey:@"sections"];
    NSDictionary *sectionDetails = [sections objectAtIndex:section];
    return [[sectionDetails objectForKey:@"footer_height"] floatValue];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
  sectionSpacingForlayout:(MONUniformFlowLayout *)layout {
    return [[self.inputInfo objectForKey:@"section_spacing"] floatValue];
}

- (NSUInteger)collectionView:(UICollectionView *)collectionView
                      layout:(MONUniformFlowLayout *)layout
    numberOfColumnsInSection:(NSInteger)section {
    return [self getNumberOfColumnsInSection:section];
}

#pragma mark -
#pragma mark - Convert Hext String to Color

- (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    NSString *noHashString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""]; // remove the #
    NSScanner *scanner = [NSScanner scannerWithString:noHashString];
    [scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]]; // remove + and $
    
    unsigned hex;
    if (![scanner scanHexInt:&hex]) return nil;
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

@end
