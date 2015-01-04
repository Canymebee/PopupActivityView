//
//  CustomizeItem.h
//  PopupActivityView
//
//  Created by Rain on 14/12/19.
//  Copyright (c) 2014年 Canymebee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupActivityItem.h"

@interface CustomizeItem : PopupActivityItem

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) UIImage * image;

- initWithTitle:(NSString *)tile icon:(UIImage *)image;

@end
