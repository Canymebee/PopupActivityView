//
//  PopupActivityView.m
//  PopupActivityView
//
//  Created by Rain on 14/12/17.
//  Copyright (c) 2014年 Canymebee. All rights reserved.
//

#define SCREEN_HEIGHT               [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                [UIScreen mainScreen].bounds.size.width
#define BUTTON_HEIGHT               44
#define CATEGORY_HEIGHT             128
#define ACTIVITY_WIDTH              304
#define ITEM_WIDTH                  72
#define ITEM_HEIGHT                 96


#import "PopupActivityView.h"
#import "PopupActivityItem.h"
#import "CustomizeItem.h"

@interface ItemCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView * itemImageView;
@property (nonatomic, strong) UILabel * itemTitle;

- (void)updateCell:(PopupActivityItem *)activityItem;

@end

@implementation ItemCell

- (void)updateCell:(PopupActivityItem *)activityItem
{
//    CGRect frame = self.frame;
//    frame.size = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
//    self.frame = CGRectMake(0, 0, ITEM_WIDTH, ITEM_HEIGHT);
    
    self.itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 62, 62)];
    self.itemImageView.image = [activityItem itemImage];
    [self addSubview:self.itemImageView];
    
    self.itemTitle = [[UILabel alloc] initWithFrame:CGRectMake(1, 67.5, 70, 13.5)];
    self.itemTitle.text = [activityItem itemTitle];
    self.itemTitle.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.itemTitle];
}

@end

//////////////////////////////////////////////////////////////////////////////////////////////////////

@interface PopupActivityView()

@property (nonatomic, strong) UIWindow * backgroundWindow;

@property (nonatomic, strong) UIView * displayView;
@property (nonatomic, strong) UIView * airdropView;
@property (nonatomic, strong) UIButton * cancelButton;

@property (nonatomic, strong) NSMutableArray * collectionViews;
@property (nonatomic, strong) NSArray * sharingItems;
@property (nonatomic, strong) NSArray * actionItems;

@property (nonatomic) int expectedCategoryNum;

@end

@implementation PopupActivityView

- (instancetype)initWithSharingItems:(NSArray *)sharingItems actionItems:(NSArray *)actionItems enableAirDrop:(BOOL)isWithAirDrop;
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(8, SCREEN_HEIGHT, 304, 0);
        self.backgroundColor = [UIColor clearColor];
        
        if ((sharingItems && sharingItems.count) && (actionItems && actionItems.count)) {
            self.expectedCategoryNum = 2;
        }
        else if ((sharingItems && sharingItems.count) || (actionItems && actionItems.count)) {
            self.expectedCategoryNum = 1;
        }
        else self.expectedCategoryNum = 0;
        self.sharingItems = sharingItems;
        self.actionItems = actionItems;
        
        int displayHeight = CATEGORY_HEIGHT * self.expectedCategoryNum;
        self.displayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ACTIVITY_WIDTH, displayHeight)];
        self.displayView.backgroundColor = [UIColor whiteColor];
        self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, displayHeight + 5, ACTIVITY_WIDTH, BUTTON_HEIGHT)];
        [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.cancelButton setBackgroundColor:[UIColor whiteColor]];
        [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        
        self.frame = CGRectMake(10, SCREEN_HEIGHT, ACTIVITY_WIDTH, displayHeight + BUTTON_HEIGHT + 10);
        
        [self addSubview:self.cancelButton];
        [self addSubview:self.displayView];
        
        self.backgroundWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.backgroundWindow.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [self.backgroundWindow addSubview:self];
        
        
        self.collectionViews = [[NSMutableArray alloc] initWithCapacity:self.expectedCategoryNum];
        for (int i = 0; i < self.expectedCategoryNum; i ++) {
//            UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CATEGORY_HEIGHT * i, ACTIVITY_WIDTH, CATEGORY_HEIGHT)];
//            UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5 * ITEM_WIDTH, CATEGORY_HEIGHT)];
//            for (int i = 0; i < self.sharingItems.count; i ++) {
//                CustomizeItem * item = self.sharingItems[i];
//                UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(i * ITEM_WIDTH, 0, ITEM_WIDTH, ITEM_HEIGHT)];
//                UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ITEM_WIDTH, ITEM_WIDTH)];
//                imageView.image = item.image;
//                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, ITEM_HEIGHT, ITEM_WIDTH, ITEM_HEIGHT - ITEM_WIDTH)];
//                label.text = item.title;
//                [cellView addSubview:imageView];
//                [cellView addSubview:label];
//                [contentView addSubview:cellView];
//            }
//            [scrollView addSubview:contentView];
//            [scrollView setContentSize:contentView.frame.size];
//            scrollView.showsHorizontalScrollIndicator = NO;
//            scrollView.backgroundColor = [UIColor redColor];
//            [self.collectionViews addObject:scrollView];
//            [self addSubview:scrollView];
            
            UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CATEGORY_HEIGHT * i, ACTIVITY_WIDTH, CATEGORY_HEIGHT) collectionViewLayout:layout];
            collectionView.delegate = self;
            collectionView.dataSource = self;
            [collectionView setTag:i];
            [collectionView registerClass:[ItemCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
            collectionView.contentSize = CGSizeMake(100 * self.sharingItems.count, CATEGORY_HEIGHT);
            [self addSubview:collectionView];
        }
    }
    return self;
}

- (void)popIn:(UIViewController *)viewController
{
    if (viewController && self.backgroundWindow) {
        [self.backgroundWindow makeKeyAndVisible];
        [UIView beginAnimations:nil context:nil];
        CGFloat height = self.frame.size.height;
        self.frame = CGRectMake(10, SCREEN_HEIGHT - height, 300, height);
        [UIView setAnimationDuration:0.5];
        [UIView commitAnimations];
    }
    else {
        NSLog(@"The view has not been init");
    }
}

 - (void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat height = self.frame.size.height;
        self.frame = CGRectMake(10, SCREEN_HEIGHT, 300, height);
    } completion:^(BOOL finished) {
        [self.backgroundWindow resignKeyWindow];
        self.backgroundWindow = nil;
    }];

}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return collectionView.tag == 0 ? self.sharingItems.count : self.actionItems.count;
     
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    if (cell) {
        NSArray * items = collectionView.tag == 0 ? self.sharingItems : self.actionItems;
        [cell updateCell:items[indexPath.item]];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
}


@end
