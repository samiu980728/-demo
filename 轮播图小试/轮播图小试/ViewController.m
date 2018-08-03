//
//  ViewController.m
//  轮播图小试
//
//  Created by 萨缪 on 2018/8/3.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,retain) UIScrollView * scrollView;
@property (nonatomic,retain) UIPageControl * pageCpntrol;//分页控制器
@property (nonatomic,strong) NSTimer * timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    
    titleView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = titleView;
    
    
    [self layout];
}


//滚动视图
- (void)layout{
    //布局ScrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    
    //不知道这里对不对
    [self.view addSubview:self.scrollView];
    
    //布局分页控制器
    //设置小滚轮坐标
    self.pageCpntrol = [[UIPageControl alloc] initWithFrame:CGRectMake(100, 140, 200, 30)];
    
    [self.view addSubview:_pageCpntrol];
    
    int count = 4;
    CGSize size = _scrollView.frame.size;
    
    //动态设置5个imageView
    for (int i = 0; i < count; i++) {
        UIImageView * iconView = [[UIImageView alloc] init];
        [self.scrollView addSubview:iconView];
        
        NSString * imgName = [NSString stringWithFormat:@"%d,.png",i+1];
        iconView.image = [UIImage imageNamed:imgName];
        
        //size 屏幕的size 所以width呼之欲出
        CGFloat x = i * size.width;
        
        iconView.frame = CGRectMake(x, 0, size.width, size.height);
        
    }
    
    //设置滚动范围
    self.scrollView.contentSize = CGSizeMake(count * size.width, size.height);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    //设置分页
    self.scrollView.pagingEnabled = YES;
    
    //设置分页内容
    //分页数目
    self.pageCpntrol.numberOfPages = count;
    //分页器小圆点在当前页 亮起颜色
    self.pageCpntrol.currentPageIndicatorTintColor = [UIColor blueColor];
    
    self.pageCpntrol.pageIndicatorTintColor = [UIColor blackColor];
    
    //设置代理
    self.scrollView.delegate = self;
    
    
    [self addTimerTask];
    
    
    
    
    
    
    
}

//封装定时器
- (void)addTimerTask
{
    NSTimer * timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
    self.timer = timer;
    
    //消息循环
    NSRunLoop * runloop = [NSRunLoop currentRunLoop];//获取当前线程的Run 对象
    [runloop addTimer:timer forMode:NSDefaultRunLoopMode];//这个Mode是固定的
    
}

- (void)nextImage{
    //当前页码
    NSInteger page = self.pageCpntrol.currentPage;
    //如果是到达最后一张
    if ( page == self.pageCpntrol.numberOfPages - 1 ){
        page = 0;
        //设置偏移量 到达最后一张后 切换到第一张
        _scrollView.contentOffset = CGPointMake(0, 0);
        [_scrollView setContentOffset:_scrollView.contentOffset animated:YES];
    }else{
        page++;
    }
    
    //此page是 page++之后的 page
    //获得x的偏移量 用于调取下一张视图
    CGFloat offsetX = page * self.scrollView.frame.size.width;
    [UIView animateWithDuration:1.0 animations:^{
        self.scrollView.contentOffset = CGPointMake(offsetX, 0);
    }];
}

//正在滚动时
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //偏移量的计算
    int page = (scrollView.contentOffset.x + scrollView.frame.size.width / 2) / scrollView.frame.size.width;
    
    self.pageCpntrol.currentPage = page;
}

//当你点击图片按住不动时 把定时器停止
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}

//当不再按下图片 立刻调用定时器方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimerTask];
}


- (void)dealloc
{
    self.scrollView = nil;
    self.pageCpntrol = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
