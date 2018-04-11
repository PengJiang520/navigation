//
//  NextViewController.h
//  Demo
//
//  Created by 江鹏 on 2018/4/11.
//  Copyright © 2018年 江鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>


@property(nonatomic, strong) UIView *navigationView;       // 导航栏
@property(nonatomic, strong) UIView *centerTextView;       // title文字
@property (nonatomic, assign) CGFloat lastOffsetY;        // 记录上一次位置
@property (nonatomic, strong) UIImageView *scaleImageView; // 顶部图片
@property (nonatomic, strong) UITableView *tableView;

/** 头像ImageView */
@property (nonatomic,strong) UIImageView *iconImageView;



@end
