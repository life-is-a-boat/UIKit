//
//  ViewController.m
//  PageViewController
//
//  Created by mac on 2017/4/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController.h"

#define kXMLYBGGray [UIColor colorWithRed:0.92f green:0.93f blue:0.93f alpha:1.00f]

@interface ViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic, strong)NSMutableArray *subTitleArray;
@property (nonatomic, strong)NSMutableArray *controllers;
@property (nonatomic, weak)UIPageViewController *pageViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"PageViewController";
    self.view.backgroundColor = kXMLYBGGray;
    [self configSubViews];
}
- (void)configSubViews
{
    self.pageViewController.view.frame = CGRectMake(0., 64., self.view.bounds.size.width, self.view.bounds.size.height - 64.);
    [self.view addSubview:self.pageViewController.view];
}

#pragma mark - UIPageViewControllerDelegate/UIPageViewControllerDataSource
//这个方法是返回前一个页面,如果返回为nil,那么UIPageViewController就会认为当前页面是第一个页面不可以向前滚动或翻页
-(nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexForViewController:viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    return [self.controllers objectAtIndex:index - 1];
}
//这个方法是下一个页面,如果返回为nil,那么UIPageViewController就会认为当前页面是最后一个页面不可以向后滚动或翻页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexForViewController:viewController];
    if (index == NSNotFound || index == self.controllers.count - 1) {
        return nil;
    }
    return [self.controllers objectAtIndex:index + 1];
}
//返回多少个控制器
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return self.controllers.count;
}
#pragma mark -private
- (NSInteger)indexForViewController:(UIViewController *)controller
{
    return [self.controllers indexOfObject:controller];
}
//这个方法是在UIPageViewController结束滚动或翻页的时候触发
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
//    UIViewController *viewcontroller = self.pageViewController.viewControllers[0];
//
//    NSUInteger index = [self indexForViewController:viewcontroller];
//
//    [self.subTitleView trans2ShowAtIndex:index];
    self.title = self.pageViewController.viewControllers[0].title;
}
#pragma mark - getter

- (UIPageViewController *)pageViewController {
    if(!_pageViewController) {
        NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationNone] forKey:UIPageViewControllerOptionInterPageSpacingKey];
        UIPageViewController *page = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        page.delegate = self;
        page.dataSource = self;
        //设置UIPageViewController初始显示的页面
        [page setViewControllers:@[[self.controllers firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        [self addChildViewController:page];

        [self.view addSubview:page.view];
        _pageViewController = page;
    }
    return _pageViewController;
}

- (NSMutableArray *)controllers {
    if(!_controllers) {
        _controllers = [[NSMutableArray alloc] init];
        for (NSString *title in self.subTitleArray) {
            UIViewController *con = [[UIViewController alloc]init];
            con.title = title;
            con.view.backgroundColor = [self arndomColor];
            [_controllers addObject:con];
        }
    }
    return _controllers;
}
- (UIColor *)arndomColor
{

    CGFloat red = arc4random_uniform(256)/ 255.0;

    CGFloat green = arc4random_uniform(256)/ 255.0;

    CGFloat blue = arc4random_uniform(256)/ 255.0;

    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    return color;
    
}
/**
 *  分类标题数组
 */
- (NSMutableArray *)subTitleArray {
    if(!_subTitleArray) {
        _subTitleArray = [[NSMutableArray alloc] initWithObjects:@"推荐",@"分类",@"广播",@"榜单",@"主播",nil];
    }
    return _subTitleArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
