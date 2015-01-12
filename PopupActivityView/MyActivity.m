//
//  MyActivity.m
//  PopupActivityView
//
//  Created by Rain on 15/1/6.
//  Copyright (c) 2015年 Canymebee. All rights reserved.
//

#import "MyActivity.h"

@implementation MyActivity

- (NSString *)activityTitle
{
    return @"title";
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"shareicon_05"];
}

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    
}

- (void)performActivity
{
    NSLog(@"worinima");
}


@end
