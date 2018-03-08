//
//  MeumView.h
//  Meum
//
//  Created by hello on 17/5/15.
//  Copyright © 2017年 Hello. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeumView : UIView<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

{
    UIButton *_changeButton;
}

@property (nonatomic, strong) NSArray *viewcontrollers;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIPageViewController *pageVC;
@property (nonatomic, assign) CGSize meumSize;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *sliderView;


-(instancetype)initWithMeum:(CGRect)meumRect   andViewControllers:(NSArray*)viewControllers  andBtnTitles:(NSArray*)titles  andMeumSize:(CGSize)meumSize;


@end
