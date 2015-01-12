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
#define ACTIVITY_WIDTH              SCREEN_WIDTH - 16
#define ITEM_WIDTH                  72
#define ITEM_HEIGHT                 96
#define DISPLAY_MARGIN_LEFT         8
#define ANIMATION_DURATION          0.2

#define BLUE                        [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1]


#import "PopupActivityView.h"
#import "PopupActivityItem.h"
#import "CustomizeItem.h"

@interface ItemCell : UICollectionViewCell

@property (nonatomic, strong) UIButton * itemButton;

- (void)updateCell:(PopupActivityItem *)activityItem;

@end

@implementation ItemCell

- (void)updateCell:(PopupActivityItem *)activityItem
{
    self.itemButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 72, 96)];
    [self.itemButton setImage:[activityItem itemImage] forState:UIControlStateNormal];
    self.itemButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 34, 5);
    [self.itemButton setTitle:[activityItem itemTitle] forState:UIControlStateNormal];
    [self.itemButton setTitleEdgeInsets:UIEdgeInsetsMake(67.5, -60, 15, 1)];
    [self.itemButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.itemButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.itemButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [self.itemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.itemButton addTarget:activityItem action:@selector(performAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.itemButton];
    
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

- (instancetype)initWithSharingItems:(NSArray *)sharingItems actionItems:(NSArray *)actionItems
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(DISPLAY_MARGIN_LEFT, SCREEN_HEIGHT, ACTIVITY_WIDTH, 0);
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
        self.displayView.layer.cornerRadius = 3;
        self.displayView.clipsToBounds = YES;
        
        self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, displayHeight + DISPLAY_MARGIN_LEFT, ACTIVITY_WIDTH, BUTTON_HEIGHT)];
        [self.cancelButton.titleLabel setFont:[UIFont boldSystemFontOfSize:21]];
        [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.cancelButton setBackgroundColor:[UIColor whiteColor]];
        [self.cancelButton setTitleColor:BLUE forState:UIControlStateNormal];
        self.cancelButton.layer.cornerRadius = 3;
        self.cancelButton.clipsToBounds = YES;
        [self.cancelButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        
        self.frame = CGRectMake(DISPLAY_MARGIN_LEFT, SCREEN_HEIGHT, ACTIVITY_WIDTH, displayHeight + BUTTON_HEIGHT + 16);
        
        [self addSubview:self.cancelButton];
        [self addSubview:self.displayView];
        
        self.backgroundWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.backgroundWindow.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [self.backgroundWindow addSubview:self];
        
        self.collectionViews = [[NSMutableArray alloc] initWithCapacity:self.expectedCategoryNum];
        for (int i = 0; i < self.expectedCategoryNum; i ++) {
            UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            layout.minimumInteritemSpacing = 0;
            UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(2, CATEGORY_HEIGHT * i + i, ACTIVITY_WIDTH - 4, CATEGORY_HEIGHT) collectionViewLayout:layout];
            collectionView.delegate = self;
            collectionView.dataSource = self;
            [collectionView setTag:i];
            [collectionView registerClass:[ItemCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
            collectionView.contentSize = CGSizeMake(100 * self.sharingItems.count, CATEGORY_HEIGHT);
            collectionView.backgroundColor = [UIColor whiteColor];
            collectionView.showsHorizontalScrollIndicator = NO;
            [self.displayView addSubview:collectionView];
            
            UIView * dividerLine = [[UIView alloc] initWithFrame:CGRectMake(0, CATEGORY_HEIGHT * i + i - 1, ACTIVITY_WIDTH, i == 0 ? 0 : 1)];
            dividerLine.backgroundColor = [UIColor grayColor];
            [self.displayView addSubview:dividerLine];
            
        }
    }
    return self;
}

- (void)popIn
{
    if (self.backgroundWindow) {
        [self.backgroundWindow makeKeyAndVisible];
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
            CGFloat height = self.frame.size.height;
            self.frame = CGRectMake(DISPLAY_MARGIN_LEFT, SCREEN_HEIGHT - height, ACTIVITY_WIDTH, height);
        } completion:^(BOOL finished) {
            
        }];
    }
    else {
        NSLog(@"The view has not been init");
    }
}

 - (void)hide
{
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        CGFloat height = self.frame.size.height;
        self.frame = CGRectMake(DISPLAY_MARGIN_LEFT, SCREEN_HEIGHT, ACTIVITY_WIDTH, height);
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

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


#pragma mark - Cell button action
- (void)cellTouchAction:(id)sender
{
    
}


@end
