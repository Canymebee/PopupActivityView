//
//  PopupActivityItem.m
//  PopupActivityView
//
//  Created by Rain on 14/12/19.
//  Copyright (c) 2014年 Canymebee. All rights reserved.
//

#import "PopupActivityItem.h"

@implementation PopupActivityItem

- (UIImage *)itemImage
{
    return [[UIImage alloc] init];
}

- (NSString *)itemTitle
{
    return @"";
}

- (ActivityCategory)itemCategory
{
    return ActivityCategoryShare;
}

- (void)performAction
{
    NSLog(@"Perform action");
}

@end
