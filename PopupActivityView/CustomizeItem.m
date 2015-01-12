//
//  CustomizeItem.m
//  PopupActivityView
//
//  Created by Rain on 14/12/19.
//  Copyright (c) 2014年 Canymebee. All rights reserved.
//

#import "CustomizeItem.h"

@implementation CustomizeItem

- (id)initWithTitle:(NSString *)tile icon:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.title = tile;
        self.image = image;
    }
    return self;
}

- (NSString *)itemTitle
{
    return self.title;
}

- (UIImage *)itemImage
{
    return self.image;
}

- (void)performAction
{
    NSLog(@"NImei a a a a a a a ");
}

@end
