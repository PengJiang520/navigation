//
//  NextViewController.m
//  Demo
//
//  Created by 江鹏 on 2018/4/11.
//  Copyright © 2018年 江鹏. All rights reserved.
//

#import "NextViewController.h"
#import "Masonry.h"
// 头部图片的高度
#define kHeardH  180.0f

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (iPhoneX ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabelView];
    [self createHeaderView];
    [self configNavigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark --创建headerView
- (void)createHeaderView {
    self.scaleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile_female_bg"]];
    _scaleImageView.contentMode = UIViewContentModeScaleAspectFill;
    _scaleImageView.clipsToBounds = YES;
    [self.view addSubview:_scaleImageView];
    [_scaleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(kHeardH);
    }];
    
    
    //创建头像imageview
    UIImage *iconImage = [UIImage imageNamed:@"icon"];
    _iconImageView = [[UIImageView alloc] init];
    
    
    CGRect rect = CGRectMake(0.f, 0.f, 150.f, 150.f);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.width * 0.5];
    UIGraphicsBeginImageContextWithOptions(rect.size, false, [UIScreen mainScreen].scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(), bezierPath.CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    [iconImage drawInRect:rect];
    
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    _iconImageView.image = outputImage;
    [self.scaleImageView addSubview:_iconImageView];

    _iconImageView.frame = CGRectMake((kScreenWidth - 80)*0.5, (kHeardH-80)*0.5, 80, 80);
    

    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //直接添加到控制器的View上面,注意添加顺序,在添加导航栏之后,否则会被遮盖住 千万要注意
    [self.view addSubview:self.navigationView];
}

#pragma mark --创建类似系统的导航栏
- (UIView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[UIView alloc]init];
        _navigationView.frame = CGRectMake(0, 0, kScreenWidth, NAVIGATION_BAR_HEIGHT);
        _navigationView.backgroundColor = [UIColor clearColor];
        _navigationView.alpha = 0.0;
        //添加子控件
        [self setNavigationSubView];
    }
    return _navigationView;
}

#pragma mark --创建导航栏左边和右边的按钮
- (void)configNavigationBar {
    //左边返回按钮
    UIButton *backBtn = [[UIButton alloc]init];
    backBtn.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT - 44, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"paweb_back2"] forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;

    
    
    //右边编辑
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(kScreenWidth-54, NAVIGATION_BAR_HEIGHT - 44, 44, 44);
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    editBtn.titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:backBtn];
    [self.view addSubview:editBtn];
}



// 注意:毛玻璃效果API是iOS8的,适配iOS8以下的请用其他方法
-(void)setNavigationSubView{
    
    // 毛玻璃背景
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:_navigationView.bounds];
    bgImgView.image = [UIImage imageNamed:@"666"];
    [_navigationView addSubview:bgImgView];
    
    /**  毛玻璃特效类型
     *   UIBlurEffectStyleExtraLight,
     *   UIBlurEffectStyleLight,
     *   UIBlurEffectStyleDark
     */
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //  毛玻璃视图
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //添加到要有毛玻璃特效的控件中
    effectView.frame = bgImgView.bounds;
    [bgImgView addSubview:effectView];
    //设置模糊透明度
    effectView.alpha = 0.9f;
    
    //中间文本框
    UIView *centerTextView = [[UIView alloc] init];
    self.centerTextView = centerTextView;
    CGFloat centerTextViewX = 0;
    CGFloat centerTextViewY = NAVIGATION_BAR_HEIGHT;
    CGFloat centerTextViewW = 0;
    CGFloat centerTextViewH = 0;
    
    //文字大小
    NSString *title = @"导航栏文字";
    //NSString *desc  = @"摇滚清心坊8套";
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];;
    centerTextViewW = titleSize.width;
    centerTextViewH = titleSize.height;
    centerTextViewX = (kScreenWidth - centerTextViewW) * 0.5;
    centerTextView.frame = CGRectMake(centerTextViewX, centerTextViewY, centerTextViewW, centerTextViewH);
    
    
    //文字label
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.frame = CGRectMake(0,0, centerTextViewW, titleSize.height);
    
    
    [centerTextView addSubview:titleLabel];
    
    [_navigationView addSubview:centerTextView];
}

#pragma mark --创建TableView
- (void)createTabelView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.lastOffsetY = -kHeardH;
    [self.view addSubview:self.tableView];
    self.tableView.contentInset = UIEdgeInsetsMake(kHeardH - STATUS_BAR_HEIGHT, 0, 0, 0);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = 120;
    //self.tableView.estimatedRowHeight = 1000;
    
}

#pragma mark - < UITableViewDatasource >
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //UITableViewCell * settingCell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    UITableViewCell *cell = nil;
    switch (indexPath.row) {
        case 0:
            cell = [UITableViewCell new];
            cell.textLabel.text = [NSString stringWithFormat:@"客户名称:%@",@"12312"];
            
            
            break;
            
        case 1:
            cell = [UITableViewCell new];
            cell.textLabel.text = [NSString stringWithFormat:@"客户名称:%@",@"12312"];
            
            
            break;
            
        case 2:
            cell = [UITableViewCell new];
           cell.textLabel.text = [NSString stringWithFormat:@"客户名称:%@",@"12312"];
            break;
            
        case 3:
            cell = [UITableViewCell new];
          cell.textLabel.text = [NSString stringWithFormat:@"客户名称:%@",@"12312"];
            break;
            
        case 4:
            cell = [UITableViewCell new];
           cell.textLabel.text = [NSString stringWithFormat:@"客户名称:%@",@"12312"];
            break;
            
        case 5:
            cell = [UITableViewCell new];
           cell.textLabel.text = [NSString stringWithFormat:@"客户名称:%@",@"12312"];
            break;
            
        case 6:
            cell = [UITableViewCell new];
            cell.textLabel.text = [NSString stringWithFormat:@"客户名称:%@",@"12312"];
            break;
            
        case 7:
            cell = [UITableViewCell new];
            cell.textLabel.text = [NSString stringWithFormat:@"客户名称:%@",@"12312"];
            break;
            
        case 8:
            cell = [UITableViewCell new];
            cell.textLabel.text = [NSString stringWithFormat:@"客户名称:%@",@"12312"];
            break;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - < UITableViewDelegate >
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 计算当前偏移位置
    CGFloat offsetY = scrollView.contentOffset.y;
    
    NSLog(@"偏移位置===%f",offsetY);
    CGFloat delta = offsetY - _lastOffsetY;
    CGFloat height = kHeardH - delta;
    
    if (height <= NAVIGATION_BAR_HEIGHT) {
        height = NAVIGATION_BAR_HEIGHT;
    }
    
    
    [_scaleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
    NSLog(@"delta高度===%f",delta);
    
    //拿到当前centerTextView的位置
//    NSLog(@"我当前的位置 x=%f,y=%f,w=%f,h=%f",self.centerTextView.x,self.centerTextView.y,self.centerTextView.width,self.centerTextView.height);
    
    CGFloat margin = kHeardH-NAVIGATION_BAR_HEIGHT;//10是header中Label的top
    
    if (delta > margin) {
        CGPoint center = self.centerTextView.center;
        center.y = NAVIGATION_BAR_HEIGHT - self.centerTextView.frame.size.height;
        self.centerTextView.center = center;
        self.centerTextView.alpha = 1.0;
    }
    
    
    if (delta <= margin) {
        self.centerTextView.alpha = 0;
    }
    
    if (delta<= 0) {
        CGPoint center = self.centerTextView.center;
        center.y = NAVIGATION_BAR_HEIGHT;
        self.centerTextView.center = center;
        self.centerTextView.alpha = 0.0;
    }
    
    
    
    CGFloat alpha = delta / (kHeardH - NAVIGATION_BAR_HEIGHT);
    if (alpha >= 1.0) {
        alpha = 1.0;
    }
    self.navigationView.alpha = alpha;
    _iconImageView.alpha = 1 - alpha;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}



@end
