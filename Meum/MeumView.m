//
//  MeumView.m
//  Meum
//
//  Created by hello on 17/5/15.
//  Copyright © 2017年 Hello. All rights reserved.
//

#import "MeumView.h"



@implementation MeumView

-(instancetype)initWithMeum:(CGRect)meumRect andViewControllers:(NSArray *)viewControllers andBtnTitles:(NSArray *)titles andMeumSize:(CGSize)meumSize{
    if (self = [super initWithFrame:meumRect]) {
        self.viewcontrollers = viewControllers;
        self.titles = titles;
        self.meumSize = meumSize;
        [self loadButton];
        [self loadPageViewController];
    }
    return self;
}



-(void)loadButton{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.meumSize.height)];
    scrollView.contentSize = CGSizeMake(self.meumSize.width*self.titles.count,self.meumSize.height);
    [self addSubview:scrollView];
    
    UIView *sliderView = [[UIView alloc] init];
    sliderView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:sliderView];
    _sliderView = sliderView;
    
    for (int  i = 0 ; i < _titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[NSString stringWithFormat:@"菜单%d",i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(self.meumSize.width*i,0, self.meumSize.width, self.meumSize.height);
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = 200+i;
        [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btn];
        _scrollView = scrollView;
        if (i == 0) {
            [self clicked:btn];
        }

    }    
}

#pragma  ----- 点击
- (void)clicked:(UIButton*)btn{
    _changeButton.selected = NO;
    btn.selected = YES;
    _changeButton = btn;
    UIViewController *VC = self.viewcontrollers[btn.tag-200];
    [_pageVC setViewControllers:@[VC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [UIView animateWithDuration:0.5 animations:^{
        _sliderView.frame = CGRectMake(btn.frame.origin.x, self.meumSize.height-2, self.meumSize.width, 2);
    }];
}




- (void)loadPageViewController{
    NSDictionary *options = @{UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationMin)}; //UIPageViewControllerTransitionStylePageCurl
    // 设置UIPageViewController初始化数据, 将数据放在NSArray里面
    // 如果 options 设置了 UIPageViewControllerSpineLocationMid,注意viewControllers至少包含两个数据,且 doubleSided = YES
    UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    UIViewController *VC = [self.viewcontrollers firstObject];
    [pageViewController setViewControllers:@[VC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    pageViewController.delegate =self;
    pageViewController.dataSource = self;
    pageViewController.view.frame = CGRectMake(0, self.meumSize.height, self.frame.size.width, self.frame.size.height-self.meumSize.height);
    [self addSubview:pageViewController.view];
    _pageVC = pageViewController;
 
}


#pragma  -------  UIPageViewControllerDelegate,UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [self.viewcontrollers indexOfObject:viewController];
    if (index == 0 || index == NSNotFound ){
        return nil;
    }
    return self.viewcontrollers[index - 1];
    
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [self.viewcontrollers indexOfObject:viewController];
    if (index == self.viewcontrollers.count-1 || index == NSNotFound ){
        return nil;
    }
    return self.viewcontrollers[index + 1];
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    UIViewController *VC = pageViewController.viewControllers[0];
    NSInteger index = [self.viewcontrollers indexOfObject:VC];
    UIButton *btn = (UIButton*)[self.scrollView viewWithTag:200+index];
    [self clicked:btn];
    CGFloat offsetx = btn.center.x - self.scrollView.frame.size.width * 0.5;
    CGFloat offsetMax = self.scrollView.contentSize.width - self.scrollView.frame.size.width;
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    CGPoint offset = CGPointMake(offsetx, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}



@end
