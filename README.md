# MONUniformFlowLayout
A simple flow layout the handles the arrangement of the items in a collection view uniformly based on the given number of columns, height of the item, inter item spacing, header height, and footer height for a particular section. 

<!-- screenshot -->
![MONUniformFlowLayout](https://raw.github.com/mownier/MONUniformFlowLayout/master/MONUniformFlowLayout-Screenshot.png)

## Installation
 * Manual Install

```
    1. Add the files 'MONUniformFlowLayout.h' and 'MONUniformFlowLayout.m' to your project.
    2. Then import the header file to use it.
```

* Via CocoaPods

```
    1. Add 'pod MONUniformFlowLayout' in your Podfile.
    2. Then 'pod install' in the terminal.
```

## Setting as UICollectionView's Layout
```objective-c
    MONUniformFlowLayout *layout = [MONUniformFlowLayout new];
    layout.interItemSpacing = MONInterItemSpacingMake(10.0f, 10.0f);
    layout.enableStickyHeader = YES;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds 
                                                          collectionViewLayout:layout];
```
The property `interItemSpacing` is the horizontal and the vertical space between items for all sections while the property `enableStickyHeader` gives an option to the user whether the collection view should enable or disable sticky header views for all sections.

The static inline method `MONInterItemSpacingMake(CGFloat x, CGFloat y)` creates a struct defining the horizontal and vertical spaces between items.

## MONUniformFlowLayoutDelegate Methods
```objective-c
    @required
    // Gets the item height in a particular section
    - (CGFloat)collectionView:(UICollectionView *)collectionView  
                       layout:(MONUniformFlowLayout *)layout 
          itemHeightInSection:(NSInteger)section;

    @optional
    //  Gets the header height in a particular section
    - (CGFloat)collectionView:(UICollectionView *)collectionView
                       layout:(MONUniformFlowLayout *)layout 
        headerHeightInSection:(NSInteger)section;
    
    // Gets the footer height in a particular section
    - (CGFloat)collectionView:(UICollectionView *)collectionView
                       layout:(MONUniformFlowLayout *)layout
        footerHeightInSection:(NSInteger)section;

    // Gets the spacing between sections
    - (CGFloat)collectionView:(UICollectionView *)collectionView
      sectionSpacingForlayout:(MONUniformFlowLayout *)layout;

    // Gets the number of columns in a particular section
    - (NSUInteger)collectionView:(UICollectionView *)collectionView
                          layout:(MONUniformFlowLayout *)layout
        numberOfColumnsInSection:(NSInteger)section;)
```

Usage in a UIViewController

```objective-c
    @interface ViewController : UIViewController <MONUniformFlowLayoutDelegate,
                             UICollectionViewDelegate, UICollectionViewDataSource,
                             UICollectionViewDelegateFlowLayout>
    ...
    @end
```