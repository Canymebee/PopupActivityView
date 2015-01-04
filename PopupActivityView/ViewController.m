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
    CustomizeItem * item5 = [[CustomizeItem alloc] initWithTitle:@"Wechat" icon:[UIImage imageNamed:@"shareicon_05"]];
    
    PopupActivityView * popView = [[PopupActivityView alloc] initWithSharingItems:@[item1, item2, item3, item4, item5] actionItems:@[] enableAirDrop:NO];
    [popView popIn:self];
    
//    UIViewController * vc = [[UIViewController alloc] init];
//    vc.view.backgroundColor = [UIColor blackColor];
//    vc.view.alpha = 0.3;
//    
//    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    view.backgroundColor = [UIColor blueColor];
//    [vc.view addSubview:view];
//    
//    [self presentViewController:vc animated:YES completion:^{
//        vc.view.alpha = 0.3;
//    }];
    
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
//    self.window.windowLevel = UIWindowLevelNormal;
//    [self.window makeKeyAndVisible];
    
}

@end
