//
//  PopupActivityItem.h
//  PopupActivityView
//
//  Created by Rain on 14/12/19.
//  Copyright (c) 2014年 Canymebee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ActivityCategory) {
    ActivityCategoryShare,
    ActivityCategoryAction,
};

@interface PopupActivityItem : NSObject

- (UIImage *)itemImage;
- (NSString *)itemTitle;
- (ActivityCategory)itemCategory;
- (void)performAction;

@end
