//
//  ViewController.h
//  轮播图小试
//
//  Created by 萨缪 on 2018/8/3.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
//实现协议
<
UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate
>
{
    UITableView * _tableView;
}

@end

