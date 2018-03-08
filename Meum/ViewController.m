//
//  ViewController.m
//  Meum
//
//  Created by hello on 17/4/24.
//  Copyright © 2017年 Hello. All rights reserved.
//

#import "ViewController.h"
#import "MeumView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *viewcontrollers = [NSMutableArray array];
    for (int  i = 0; i < 7; i++) {
        UIViewController *VC = [[UIViewController alloc] init];
        VC.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
        [viewcontrollers addObject:VC];
    }
    NSArray *titles = @[@"菜单1",@"菜单2",@"菜单3",@"菜单4",@"菜单5",@"菜单6",@"菜单7"];
    MeumView *view = [[MeumView alloc] initWithMeum:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) andViewControllers:viewcontrollers andBtnTitles:titles andMeumSize:CGSizeMake(self.view.bounds.size.width/5, 40)];
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
