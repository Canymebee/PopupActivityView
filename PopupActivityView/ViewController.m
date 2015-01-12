//
//  ViewController.m
//  PopupActivityView
//
//  Created by Rain on 14/12/17.
//  Copyright (c) 2014年 Canymebee. All rights reserved.
//

#import "ViewController.h"
#import "PopupActivityView.h"
#import "CustomizeItem.h"
#import "MyActivity.h"

@interface ViewController ()

@property (nonatomic, strong) UIWindow * window;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAction:(id)sender {
    CustomizeItem * item1 = [[CustomizeItem alloc] initWithTitle:@"Message" icon:[UIImage imageNamed:@"shareicon_01"]];
    CustomizeItem * item2 = [[CustomizeItem alloc] initWithTitle:@"Email" icon:[UIImage imageNamed:@"shareicon_02"]];
    CustomizeItem * item3 = [[CustomizeItem alloc] initWithTitle:@"Timeline" icon:[UIImage imageNamed:@"shareicon_03"]];
    CustomizeItem * item4 = [[CustomizeItem alloc] initWithTitle:@"Weibo" icon:[UIImage imageNamed:@"shareicon_04"]];
    CustomizeItem * item5 = [[CustomizeItem alloc] initWithTitle:@"Wechat" icon:[UIImage imageNamed:@"qq_image"]];
    
    PopupActivityView * popView = [[PopupActivityView alloc] initWithSharingItems:@[item1, item2, item3, item4, item5] actionItems:nil];
    [popView popIn];
}

- (IBAction)popSystemAction:(id)sender {
    MyActivity * ac1 = [[MyActivity alloc] init];
    MyActivity * ac2 = [[MyActivity alloc] init];
    MyActivity * ac3 = [[MyActivity alloc] init];
    MyActivity * ac4 = [[MyActivity alloc] init];
    MyActivity * ac5 = [[MyActivity alloc] init];
    UIActivityViewController * vc = [[UIActivityViewController alloc] initWithActivityItems:@[@"balabala"] applicationActivities:@[ac1,ac2,ac3,ac4,ac5]];
    
    [self presentViewController:vc animated:YES completion:^{
        NSMutableArray * queue = [[NSMutableArray alloc] init];
        [queue addObject:[vc.view subviews][0]];
        while (queue.count) {
            UIView * view = [queue firstObject];
            [queue removeObjectAtIndex:0];
            for (UIView * v in [view subviews]) {
                NSLog(@"%@", v);
                if ([v isKindOfClass:[UILabel class]]) {
                    NSLog(@"================================ Font : %@\n %@", ((UILabel *)v).font, ((UILabel *)v).textColor);
                }
                if (v.frame.size.height == 1) {
                    NSLog(@">>>>>>>>>>> Color : %@", v.backgroundColor);
                }
                [queue addObject:v];
            }
        }
        NSLog(@"%@", [UIScreen mainScreen].bounds);
    }];
    
}

@end
