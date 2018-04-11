//
//  ViewController.m
//  Demo
//
//  Created by 江鹏 on 2018/4/11.
//  Copyright © 2018年 江鹏. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"导航栏渐变";
}

- (IBAction)btnClick:(id)sender {
    [self.navigationController pushViewController:[NextViewController new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
