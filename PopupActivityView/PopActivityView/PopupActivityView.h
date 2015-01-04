//
//  PopupActivityView.h
//  PopupActivityView
//
//  Created by Rain on 14/12/17.
//  Copyright (c) 2014年 Canymebee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupActivityView : UIView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

- (instancetype)initWithSharingItems:(NSArray *)sharingItems actionItems:(NSArray *)actionItems enableAirDrop:(BOOL)isWithAirDrop;
- (void)popIn:(UIViewController *)viewController;
- (void)hide;

@end
