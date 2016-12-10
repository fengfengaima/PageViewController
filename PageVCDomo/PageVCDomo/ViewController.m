//
//  ViewController.m
//  PageVCDomo
//
//  Created by mibo02 on 16/12/10.
//  Copyright © 2016年 mibo02. All rights reserved.
//

#import "ViewController.h"
#import "ContentViewController.h"
@interface ViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property (nonatomic,strong)UIPageViewController *pageViewController;
@property (nonatomic, strong)NSArray *pageContentArray;

@end

@implementation ViewController

- (NSArray *)pageContentArray
{
    if (!_pageContentArray) {
        NSMutableArray *arrayM = [[NSMutableArray alloc] init];
        for (int i = 1 ; i < 10; i++) {
            NSString *contentString = [[NSString alloc] initWithFormat:@"第%d页",i];
            [arrayM addObject:contentString];
        }
        _pageContentArray = [[NSArray alloc] initWithArray:arrayM];
    }
    return _pageContentArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //设置page的配置项
    NSDictionary *dic = @{UIPageViewControllerOptionInterPageSpacingKey :@(10)};
    //UIPageViewControllerTransitionStylePageCurl<页码翻滚>
    //UIPageViewControllerTransitionStyleScroll<滑动翻滚>
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:1 navigationOrientation:(UIPageViewControllerNavigationOrientationHorizontal) options:dic];
    //
    _pageViewController.delegate =self;
    _pageViewController.dataSource = self;
    ContentViewController *initVC = [self viewControllerAtIndex:0];//得到第一页
    NSArray *viewCongrollers = [NSArray arrayWithObject:initVC];
    [_pageViewController setViewControllers:viewCongrollers direction:(UIPageViewControllerNavigationDirectionReverse) animated:NO completion:nil];
    _pageViewController.view.frame = self.view.bounds;
    //
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

//数组元素值，得到下标值
- (NSUInteger)indexOfViewController:(ContentViewController *)viewController
{
    return [self.pageContentArray indexOfObject:viewController.content];
}
#pragma mark 返回下一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pageContentArray count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
    
    
}

#pragma mark --根据index得到对应的VC
- (ContentViewController *)viewControllerAtIndex:(NSUInteger )index
{
    if (self.pageContentArray.count == 0 || index >= self.pageContentArray.count) {
        return nil;
    }
    //创建一个新的控制器，并分配相应的数据
    ContentViewController *contentVC = [[ContentViewController alloc] init];
    contentVC.content = self.pageContentArray[index];
    return contentVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
